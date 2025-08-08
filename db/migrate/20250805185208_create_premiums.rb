class CreatePremiums < ActiveRecord::Migration[8.0]
  def change
    create_table :premiums do |t|
      t.references :claim, null: false, foreign_key: true
      t.references :cover, null: false, foreign_key: { to_table: :configuration_covers }
      t.monetize :base_amount
      t.monetize :final_amount

      t.timestamps
    end

    add_index :premiums, [ :claim_id, :cover_id ], unique: true
  end
end
