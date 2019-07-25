class AddUidColumnToTeachers < ActiveRecord::Migration[5.2]
  def change
    add_column :teachers, :uid, :integer
  end
end
