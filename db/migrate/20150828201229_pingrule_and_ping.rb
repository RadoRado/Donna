class PingruleAndPing < ActiveRecord::Migration
  def change
    create_table :ping_rules do |t|
      t.integer :times_a_month
      t.integer :consecutive_months
      t.string :schedule

      t.timestamps null: false
    end

    create_table :pings do |t|
      t.datetime :target_week
      t.datetime :target_day
      t.belongs_to :ping_rule, index: true
    end
  end
end
