class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.date :due_date
      t.date :completed
      t.boolean :sms_reminder
      t.boolean :email_reminder
      t.text :description

      t.timestamps
    end
  end
end
