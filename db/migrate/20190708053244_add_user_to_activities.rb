class AddUserToActivities < ActiveRecord::Migration[5.2]
  def change
    add_reference :activities, :user
  end
end
