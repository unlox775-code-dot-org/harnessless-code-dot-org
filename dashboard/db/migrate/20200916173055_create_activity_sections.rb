class CreateActivitySections < ActiveRecord::Migration[5.0]
  def change
    create_table :activity_sections do |t|
      t.integer :lesson_activity_id, null: false, index: true
      t.string :seeding_key, null: false, index: {unique: true}, comment: 'unique key which is stable across environments for seeding purposes'
      t.integer :position, null: false
      t.string :properties

      t.timestamps
    end
  end
end
