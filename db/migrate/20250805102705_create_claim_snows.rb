class CreateClaimSnows < ActiveRecord::Migration[8.0]
  def change
    create_table :claim_snows do |t|
      t.references :claim, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
