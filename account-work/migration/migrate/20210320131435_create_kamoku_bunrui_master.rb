class CreateKamokuBunruiMaster < ActiveRecord::Migration[5.0]
  def change
    create_table :kamoku_bunrui_masters do |t|
      # 科目分類: ("1": 資産, "2": 負債, "3": 純資産, "4": 収益, "5": 費用)
      t.string :kamoku_bunrui_cd, limit: 1, null: false
      # 科目分類名
      t.string :kamoku_bunrui_name, limit: 8, null: false
      # 科目分類タイプ: ("L": 借方, "R": 貸方)
      # 資産の増加/減少=L/R
      # 負債の増加/減少=R/L
      # 費用の増加/減少=L/R
      # 収益の増加/減少=R/L
      t.string :kamoku_bunrui_type, limit: 1, null: false
      # 繰越フラグ("0": 繰り越さない, 1: 繰り越す)
      t.string :kurikoshi_flg, limit: 1, null: false
      t.timestamps
    end
  end
end
