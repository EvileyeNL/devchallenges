class AddCodechallengeIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :codechallenge_id, :integer
  end
end
