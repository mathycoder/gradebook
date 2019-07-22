class AddPictureUrlToTeachers < ActiveRecord::Migration[5.2]
  def change
    add_column :teachers, :picture_url, :string
  end
end
