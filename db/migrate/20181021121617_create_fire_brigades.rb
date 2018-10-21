class CreateFireBrigades < ActiveRecord::Migration[5.2]
  def change
    create_table :fire_brigades do |t|
      t.string :province
      t.string :name
      t.string :poviat
      t.string :district
      t.string :city
      t.string :zipcode
      t.string :street
      t.string :fax
      t.string :page
      t.string :email
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
