class CreateAges < ActiveRecord::Migration[5.2]
  def change
    create_table :ages do |t|
      t.integer :days
      t.text :description

      t.timestamps
    end
  end
end
