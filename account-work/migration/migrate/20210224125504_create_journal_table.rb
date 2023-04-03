class CreateJournalTable < ActiveRecord::Migration[5.0]
  def change
    create_table :journals do |t|
      # 年度
      t.string :nendo, limit: 4, null: false
      # 日付
      t.string :date, limit: 8, null: false
      # 借方コード
      t.string :karikata_cd, limit: 5, null: false
      # 借方金額
      t.integer :karikata_value, null: false
      # 貸方コード
      t.string :kasikata_cd, limit: 5, null: false
      # 貸方金額
      t.integer :kasikata_value, null: false
      # 備考
      t.text :note

      # チェック("0": OFF, "1": ON)
      # 後で見直しをしたい項目等にチェックをつけて探しやすくするために使用する
      t.string :checked, null: false

      t.timestamps
    end
    add_index :journals, [:nendo, :date], name: 'journals_default_index'
    add_index :journals, [:nendo, :karikata_cd, :kasikata_cd, :date], name: 'journals_code_index'
    add_index :journals, [:nendo, :checked, :date], name: 'journals_checked_index'
  end
end
