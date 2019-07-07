class CreateKlasses < ActiveRecord::Migration[5.2]
  def change
    create_table :klasses do |t|
      t.string :name
      t.string :subject
      t.string :grade
      t.integer :period 
      t.timestamps
    end
  end
end
