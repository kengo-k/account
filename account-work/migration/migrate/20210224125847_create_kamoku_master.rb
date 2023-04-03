# 勘定科目マスタ
class CreateKamokuMaster < ActiveRecord::Migration[5.0]
  def change
    create_table :kamoku_masters do |t|
      # 科目コード
      t.string :kamoku_cd, limit: 2, null: false
      # 科目フル名称
      t.text :kamoku_full_name, null: false
      # 科目略名称(一覧表示用)
      t.text :kamoku_ryaku_name, null: false
      # 科目カナ名称(科目検索用)
      t.text :kamoku_kana_name, null: false
      # 科目分類
      t.string :kamoku_bunrui_cd, limit: 1, null: false
      # 説明
      t.text :description, null: true
      t.timestamps
    end
  end
end
