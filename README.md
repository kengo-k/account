# プロジェクトの構成

機能単位で主要なリポジトリとしては3つ存在する。

- account-frontend - フロントエンド: Reactアプリケーション
- account-backend - バックエンド: REST APIサーバ
- account-common -上記の2リポジトリで共通で使用する部品

そして上記の3リポジトリを取りまとめる親リポジトリが存在する。つまり合計で4つのリポジトリが存在し下記に示す構成になっている。

```
account
 |-account-frontend
 |-account-backend
 |-account-common
```

親であるaccountリポジトリはsubmoduleとして子である各リポジトリを参照する。

※注意: `account-frontend`および`account-backend`は直接`account-common`を参照する構成にはなっていない。`account-frontend`および`account-backend`のサービスをコンテナとして起動する際に`account-common`の内容を上記2コンテナ内に配置することで参照できるようにする。ただし開発時と本番運用時では下記に示すように参照の方法が異なる。

- 開発時はボリュームマウントを使って配置する
- 本番時はイメージ構築時にコピーによって配置する

# ローカル環境での開発手順

## ソースコードのチェックアウト

まずは親リポジトリである`account`リポジトリをcloneし、続けて`account`リポジトリ内で子リポジトリをsubmoduleとして取得する。

```
# 親リポジトリ内に移動する
$ cd account

# commonを取得
$ cd common
$ git submodule init
$ git submodule update

(frontendとbackendも上記のcommonと同様の作業を行う)
```

## 設定ファイルの作成

### db.env ファイルの作成

このファイル(※README.md)と同階層に db.env ファイルを作成し Postgresql の環境変数を設定します。db.env ファイルは docker コンテナに Postgresql をインストールする際にdocker-compose.ymlから参照されます。

db.env ファイルの内容は以下のとおりです。

```
POSTGRES_USER=Your Postgres UserName
POSTGRES_PASSWORD=Your Postgres Password
PGDATA=/var/lib/postgresql/data/pgdata
```

- ※POSTGRES_USER と POSTGRES_PASSWORD に適当な値を設定してください。
- ※db.env ファイルは git 管理されません

### database.yml ファイルの作成

このファイル(※README.md)と同階層に database.yml ファイルを作成し Postgresql への接続情報を記載します。データベースの Migration ツールおよび backendから参照されます。

database.yml ファイルの内容は以下のとおりです。

```
common:
  host: account_db
  username: Your Postgres UserName
  password: Your Postgres Password
  adapter: postgresql
  encoding: utf-8

production:
  database: production

development:
  database: development

test:
  database: test

```

雛形 database.template.yml ファイルがあるのでコピーして必要箇所を編集します

- ※username と password に適当な値を設定してください。(db.envと同じ値を設定します)
- ※database.yml ファイルは git 管理されません

## コンテナの起動

VSCodeから`Ctrl + Shift + P`を実行しコマンドパレットを開き、`Dev Containers: Open Folder in Container...`を選択しプロジェクトルート下にある.devcontainerディレクトリを開く。プロジェクトルート下にあるdocker-compose.ymlに記述されているコンテナが自動的に起動する。VSCodeは`account-work`コンテナ上で実行される。このコンテナは開発を行うための作業用コンテナとなる。このコンテナ内からfrontendコンテナやbackendコンテナにsshで接続できる。

```sh
$ ssh frontend # frontendにsshログインする
$ ssh backend # backendにsshログインすうｒ
```

## DB 接続確認

backend コンテナにログインし db コンテナ にアクセスできるか確認します。DevContainerを起動している状態で下記コマンドを実行しbackendコンテナにログインします。

```
$ ssh backend
```

ログインできたら psql コマンドを使い db コンテナにログインします。

```
$ psql -U"設定ファイルに記載したユーザ名" -h"account_db" -d "使用するDB名"
```

パスワードの入力を求められるので設定ファイルに記載したパスワードを入力し、psql プロンプトが表示されれば OK です。

# 3.データベースのセットアップ

## 3-1: 初期化

データベースとテーブルの作成を行います。api コンテナにログインし(ログイン方法は前述したとおり)、/opt/migration ディレクトリに移動し、下記コマンドを実行します。

```
$ rake db:init
$ rake migrate:run
```

特に指定がない場合データベースは development が使用されます。指定する場合は下記のようにコマンドを実行します。

```
$ rake db:init[test]
$ rake migrate:run[test]
```

処理の実行中にデータベースのパスワードの入力を求められます。毎回手動で入力してもよいですが、下記の内容で`~/.pgpass`を作成することで入力の手間を省くことができます。

```
接続先ホスト:ポート番号:DB名:ユーザ名:パスワード
```

例えば`develop`向けの設定を作成する場合は次のようになります。

```
db:5432:development:root:root
```

## 3-2: 初期データ投入

下記のコマンドで各種マスタ等の初期データを投入します。

```
$ rake data:import[development,data/init]
```

development データベースに data/init ディレクトリ配下の CSV データをインポートします。

その他データのバックアップ等のタスクが Rakefile に記載されています。使用できるタスクを確認するには

```
$ rake --tasks
```

を実行してください。

# 4.API サーバの起動

api コンテナにログインし/opt/project ディレクトリに移動し、package.json ファイルに記述されている起動コマンドを実行します。起動コマンドは接続する DB ごとに異なります

## 4-1: 開発 DB にアクセスする場合

```
npm start
```

## 4-2: 開発以外の DB にアクセスする場合(ここでは production)

```
npm run start:production
```

# 5.テストの実行

/opt/project ディレクトリ内で下記コマンドを実行します。

```
$ npm test
```

テスト実施の際にテスト用のデータベース作成とデータ投入が行われます。その際に psql コマンドが実行されるためパスワードの入力を求められます。パスワードの入力を省略するために`.pgpass`ファイルを作成しパスワードを記載しておきます。`.pgpass`ファイルは以下の形式で記述します。

```
接続先ホスト:ポート番号:DB名:ユーザ名:パスワード
```

# prismaによるマイグレーション

既存のDBからprismaのスキーマ定義を生成する

```
$ npx prisma introspect
```
