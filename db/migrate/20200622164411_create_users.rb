class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstName
      t.string :lastName
      t.string :email
      t.string :password_digest
      t.text :description
      t.string :type
      t.string :generic

      t.timestamps null: false
    end
  end
end
