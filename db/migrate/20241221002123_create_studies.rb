class CreateStudies < ActiveRecord::Migration[8.0]
  def change
    create_table :studies do |t|
      t.string :title
      t.boolean :started
      t.boolean :completed

      t.timestamps
    end
  end
end
