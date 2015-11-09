class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.text :content
      t.text :html_identifier
      t.boolean :active
    end
  end
end
