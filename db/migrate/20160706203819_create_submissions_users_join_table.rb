class CreateSubmissionsUsersJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table :submissions_users, id: false do |t|
      t.belongs_to :submission, index: true
      t.belongs_to :user, index: true
    end
  end
end
