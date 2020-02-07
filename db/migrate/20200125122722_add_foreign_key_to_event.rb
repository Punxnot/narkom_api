class AddForeignKeyToEvent < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :events, :ages
  end
end
