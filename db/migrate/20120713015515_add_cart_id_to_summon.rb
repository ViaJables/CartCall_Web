class AddCartIdToSummon < ActiveRecord::Migration
  def change
    add_column :summons, :cart_id, :integer
  end
end
