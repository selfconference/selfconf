class RemoveSessionsAndSpeakers < ActiveRecord::Migration
  def change
    drop_table :speakers
    drop_table :sessions
  end
end
