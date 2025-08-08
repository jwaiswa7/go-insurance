class CreateClaimDestinations < ActiveRecord::Migration[8.0]
  def change
    create_table :claim_destinations do |t|
      t.references :claim, null: false, foreign_key: true
      t.references :destination, null: false

      t.timestamps
    end
  end
end
