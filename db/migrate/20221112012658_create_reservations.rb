class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.string :code, index: true, unique: true
      t.date :start_date
      t.date :end_date
      t.integer :nights, default: 0
      t.integer :guests, default: 0
      t.integer :adults, default: 0
      t.integer :children, default: 0
      t.integer :infants, default: 0
      t.string :status
      t.string :currency
      t.float :payout, default: 0
      t.float :security, default: 0
      t.float :total_price, default: 0

      t.references :guest, null: false, foreign_key: true

      t.timestamps
    end
  end
end
