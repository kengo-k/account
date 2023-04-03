# 細目マスタ
class CreateSaimokuMaster < ActiveRecord::Migration[5.0]
  def change
    create_table :saimoku_masters do |t|
      # 科目コード
      t.string :kamoku_cd, limit: 2, null: false
      # 細目コード
      t.string :saimoku_cd, limit: 3, null: false
      # 細目フル名称
      t.text :saimoku_full_name, null: false
      # 細目略名称(一覧表示用)
      t.text :saimoku_ryaku_name, null: false
      # 細目カナ名称(科目検索用)
      t.text :saimoku_kana_name, null: false
      # 説明
      t.text :description, null: true
      t.timestamps
    end
  end
end
