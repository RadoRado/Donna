class CreateContactsModel < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.belongs_to :user, index: true
    end
  end
end
