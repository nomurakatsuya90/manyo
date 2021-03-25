class ChangeNotNullToTasks < ActiveRecord::Migration[5.2]
  change_column :tasks, :content, :string, null: false
end
