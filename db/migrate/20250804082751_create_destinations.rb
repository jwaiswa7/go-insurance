class CreateDestinations < ActiveRecord::Migration[8.0]
  def change
    create_table :destinations do |t|
      t.string :country_code
      t.string :country
      t.references :zone, null: false, foreign_key: { to_table: :configuration_regions }

      t.timestamps
    end
  end
end
