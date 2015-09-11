class User < ActiveRecord::Base
  has_surveys

  TEMP_EMAIL = 'change@me.com'
  TEMP_EMAIL_REGEX = /change@me.com/

  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  def self.find_for_oauth(auth, signed_in_resource = nil)

    identity = Identity.find_for_oauth(auth)
    user = identity.user
    if user.nil?
      email = auth.info.email if auth.info.verified_email
      user = User.where(:email => email).first if email

      if user.nil?
        user = User.new(
          name: auth.extra.raw_info.name,
          username: auth.info.nickname || auth.uid,
          email: email ? TEMP_EMAIL : email,
          password: Devise.friendly_token[0,20]
        )
        user.skip_confirmation!
        user.save!
      end

      if identity.user != user
        identity.user = user
        identity.save!
      end
    end
    user
  end

  def setChallenge(challenge)
    self.codechallenge_id = challenge.id
    self.save
  end

end
