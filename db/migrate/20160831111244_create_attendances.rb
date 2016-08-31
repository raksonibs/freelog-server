class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.references :project, index: true, foreign_key: true
      t.text :notes
      t.float :hour_rate
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps null: false
    end
  end
end
