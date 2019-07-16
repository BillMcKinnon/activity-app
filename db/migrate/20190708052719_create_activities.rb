class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :type
      t.string :name
      t.float :minutes

      t.timestamps
    end
  end
end
