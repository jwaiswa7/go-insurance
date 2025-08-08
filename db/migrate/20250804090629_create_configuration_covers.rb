class CreateConfigurationCovers < ActiveRecord::Migration[8.0]
  def change
    create_table :configuration_covers do |t|
      t.string :level, null: false
      t.decimal :multiplier, precision: 10, scale: 2, null: false, default: 0

      t.timestamps
    end
  end
end
