class CreateConfigurationBaseConfigs < ActiveRecord::Migration[8.0]
  def change
    create_table :configuration_base_configs do |t|
      t.decimal :base_number, precision: 10, scale: 15, null: false, default: 0

      t.timestamps
    end
  end
end
