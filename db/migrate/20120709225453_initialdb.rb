class Initialdb < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :pin
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
    
    create_table :summons do |t|
      t.datetime :served
      t.datetime :on_my_way
      t.float :latitude
      t.float :longitude
      t.references :course
      t.timestamps
    end
    
    create_table :carts do |t|
      t.string :name
      t.references :course
      t.timestamps
    end
    
  end
end
