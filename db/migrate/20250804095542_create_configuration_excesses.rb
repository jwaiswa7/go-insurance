class CreateConfigurationExcesses < ActiveRecord::Migration[8.0]
  def change
    create_table :configuration_excesses do |t|
      t.monetize :excess, null: false
      t.decimal :multiplier, precision: 10, scale: 2, null: false, default: 0

      t.timestamps
    end
  end
end
