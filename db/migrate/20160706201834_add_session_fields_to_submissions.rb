class AddSessionFieldsToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :selected, :boolean, null: false, default: false
    add_column :submissions, :room_id, :integer
    add_column :submissions, :slot_id, :integer
    add_column :submissions, :keynote, :boolean
  end
end
