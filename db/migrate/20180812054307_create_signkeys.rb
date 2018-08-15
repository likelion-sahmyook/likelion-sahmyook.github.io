class CreateSignkeys < ActiveRecord::Migration[5.0]
  def change
    create_table :signkeys do |t|
      t.string :key

      t.timestamps
    end
  end
end
