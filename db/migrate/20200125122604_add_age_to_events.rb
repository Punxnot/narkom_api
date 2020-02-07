class AddAgeToEvents < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :age
  end
end
