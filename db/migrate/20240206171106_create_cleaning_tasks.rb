class CreateCleaningTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :cleaning_tasks do |t|
      t.references :room, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.date :task_start, null: false
      t.boolean :done, default: false

      t.timestamps
    end
  end
end
