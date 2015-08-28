class AddRelationBetweenPingrulesAndUser < ActiveRecord::Migration
  def change
    change_table :ping_rules do |t|
      t.belongs_to :user, index: true
    end
  end
end
