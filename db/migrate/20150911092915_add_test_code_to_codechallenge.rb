class AddTestCodeToCodechallenge < ActiveRecord::Migration
  def change
    add_column :codechallenges, :test_code, :text
  end
end
