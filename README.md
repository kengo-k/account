# 1.前準備

## 共通部品ソースコードのチェックアウト

本アプリケーションは API とフロントエンドの二つに分けて開発している(Git リポジトリ自体が別)ため、共通で使用される部品(モデルクラス等)を共有しています。共有部品は`account-common`リポジトリで管理されていて、API とフロントエンドのプロジェクトは git の submodule 機能を使って`account-common`リポジトリを参照します。

`api/project/src/main/common`ディレクトリに移動し、下記のコマンドを実行します。

```
$ git submodule init
$ git submodule update
```

# 2.コンテナの起動～ DB アクセス確認

## 2-1: db.env ファイルの作成

このファイル(※README.md)と同階層に db.env ファイルを作成し Postgresql の環境変数を設定します。db.env ファイルは docker コンテナに Postgresql をインストールする際に使用します。

db.env ファイルの内容は以下のとおりです。

```
POSTGRES_USER=Your Postgres UserName
POSTGRES_PASSWORD=Your Postgres Password
PGDATA=/var/lib/postgresql/data/pgdata
```

- ※POSTGRES_USER と POSTGRES_PASSWORD に適当な値を設定してください。
- ※db.env ファイルは git 管理されません

## 2-2: database.yml ファイルの作成

api/config ディレクトリ下に database.yml ファイルを作成し Postgresql への接続情報を記載します。データベースの Migration ツールおよび API アプリケーションから利用されます。

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

- ※username と password に適当な値を設定してください。
- ※database.yml ファイルは git 管理されません

## 2-3: Docker イメージの作成

docker-compose.yml ファイルがある階層に移動し下記のコマンドを実行します。

```
$ docker-compose build --no-cache
```

## 2-4: Docker コンテナの起動

docker-compose.yml ファイルがある階層に移動し下記のコマンドを実行します。

```
$ docker-compose up -d
```

## 2-5: DB 接続確認

api コンテナにログインし db コンテナ にアクセスできるか確認します。まず下記コマンドで api コンテナにログインします。

```
$ docker exec -it account_api bash
```

ログインできたら psql コマンドを使い db コンテナにログインします。

```
$ psql -U"設定ファイルに記載したユーザ名" -h"account_db"
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
