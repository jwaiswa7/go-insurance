class CreateConfigurationRegions < ActiveRecord::Migration[8.0]
  def change
    create_table :configuration_regions do |t|
      t.integer :region_number
      t.decimal :multiplier, precision: 10, scale: 2, null: false, default: 0

      t.timestamps
    end
  end
end
