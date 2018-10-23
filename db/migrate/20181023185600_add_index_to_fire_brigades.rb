class AddIndexToFireBrigades < ActiveRecord::Migration[5.2]
  def change
    add_index :fire_brigades, [:latitude, :longitude]
  end
end
