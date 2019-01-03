class AddPostcreatorToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :done, :boolean, default: false
    add_column :tasks, :duedate, :date
    add_column :tasks, :compdate, :date
    add_column :tasks, :priority, :integer, default: false
  end
end
