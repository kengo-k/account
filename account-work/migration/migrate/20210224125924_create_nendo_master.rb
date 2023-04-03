# 年度マスタ
class CreateNendoMaster < ActiveRecord::Migration[5.0]
  def change
    create_table :nendo_masters do |t|
      # 対象年度
      t.string :nendo, limit: 4, null: false
      # 年度開始日
      t.string :start_date, limit: 8, null: false
      # 年度終了日
      t.string :end_date, limit: 8, null: false
      # 確定済みフラグ
      t.string :fixed, limit: 1, null: false
      t.timestamps
    end
  end
end
