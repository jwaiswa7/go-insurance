class CreateConfigurationCruises < ActiveRecord::Migration[8.0]
  def change
    create_table :configuration_cruises do |t|
      t.references :region, null: false, foreign_key: { to_table: :configuration_regions }
      t.monetize :amount, null: false, default: 0

      t.timestamps
    end
  end
end
