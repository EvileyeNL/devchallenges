class Codechallenge < ActiveRecord::Base

  def nextChallenge(current_id)
    self.class.where('id > ?', current_id).first
  end

end
