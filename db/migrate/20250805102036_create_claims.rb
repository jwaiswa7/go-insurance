class CreateClaims < ActiveRecord::Migration[8.0]
  def change
    create_table :claims do |t|
      t.references :trip_type, null: false, foreign_key: { to_table: :configuration_scheme_types }
      t.references :age, null: false, foreign_key: true
      t.date :trip_start_date
      t.date :trip_end_date
      t.references :excess, null: false, foreign_key: { to_table: :configuration_excesses }
      t.boolean :has_cruise, null: false, default: false
      t.string :policy
      t.string :email

      t.timestamps
    end
  end
end
