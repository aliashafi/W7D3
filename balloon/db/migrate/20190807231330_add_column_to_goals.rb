class AddColumnToGoals < ActiveRecord::Migration[5.2]
  def change
    add_column :goals, :goal_type, :string
  end
end
