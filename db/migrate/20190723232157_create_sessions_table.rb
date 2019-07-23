class CreateSessionsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.string :email
      t.string :type
      t.string :password
    end
  end
end
