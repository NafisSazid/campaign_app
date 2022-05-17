class CreateInvestments < ActiveRecord::Migration[7.0]
  def change
    create_table :investments do |t|
      t.string :investor_name, null: false
      t.decimal :amount
      t.references :campaign, index: true, null: false, foreign_key: true

      t.timestamps
    end
  end
end
