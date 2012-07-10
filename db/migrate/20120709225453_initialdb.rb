class Initialdb < ActiveRecord::Migration
  def change
    create_table :course do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
    end
    
    create_table :call do |t|
      t.boolean :served, :default => false
      t.float :latitude
      t.float :longitude
      t.reference :course
    end
    
    create_table :cart do |t|
      t.reference :course
      t.float :latitude
      t.float :longitude
    end
    
  end
end
