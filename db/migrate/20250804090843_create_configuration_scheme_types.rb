class CreateConfigurationSchemeTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :configuration_scheme_types do |t|
      t.boolean :one_way, null: false, default: false
      t.decimal :multiplier, precision: 10, scale: 2, null: false, default: 0

      t.timestamps
    end
  end
end
