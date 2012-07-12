class AddActivityToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :active_carts, :boolean, :default => false
  end
end
