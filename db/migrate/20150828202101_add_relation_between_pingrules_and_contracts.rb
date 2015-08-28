class AddRelationBetweenPingrulesAndContracts < ActiveRecord::Migration
  def change
    change_table :ping_rules do |t|
      t.belongs_to :contact, index: true
    end
  end
end
