class CreateCodechallenge < ActiveRecord::Migration
  def self.up
    create_table :codechallenges do |t|
      t.string :name
      t.text :description
      t.text :problem
      t.text :background
      t.integer :attempts_number
      t.text :solution
    end
  end

  def self.down
    drop_table :codechallenges
  end
end
