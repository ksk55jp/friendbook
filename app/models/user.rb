class User < ActiveRecord::Base

  has_many :topics, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed

  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  mount_uploader  :avatar, AvatarUploader


  def self.find_for_facebook_oauth(auth, singed_in_resource=nil)
    user = User.find_by( provider: auth.provider, uid: auth.uid)

    unless user
      user = User.new(
        name: auth.extra.raw_info.name,
        provider: auth.provider,
        uid: auth.uid,
        email: "#{auth.uid}-#{auth.provider}@example.com",
        image_url: auth.info.image,
        password: Devise.friendly_token[0,20]
      )
      user.skip_confirmation!
      user.save(validate: false)
    end
    user
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource = nil)
    user = User.find_by(provider: auth.provider, uid: auth.uid)

    unless user
      user = User.new(
          name:     auth.info.nickname,
          image_url: auth.info.image,
          provider: auth.provider,
          uid:      auth.uid,
          email:    "#{auth.uid}-#{auth.provider}@example.com",
          password: Devise.friendly_token[0, 20]
      )
      user.skip_confirmation!
      user.save
    end
    user
  end

  def update_with_password(params, *options)
    if provider.blank?
      super
    else
      params.delete :current_password
      update_without_password(params, *options)
    end
  end

  def self.create_unique_string
    SecureRandom.uuid
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy 
  end

  def followed?(other_user)
    other_user.following?(self)
  end

  def mutual_following?(other_user)
    #binding.pry
    self.following?(other_user) && other_user.following?(self)
  end

  def get_relationship_str(other_user, switch)
    if mutual_following?(other_user)
      if switch =="status"
        "相互フォロー中"
      else
        "相互フォローをやめる"
      end
    else
      if self.following?(other_user)
        if switch == "status"
          "フォローリクエスト申請中"
        else
          "出しているリクエストをやめる"
        end
      elsif other_user.following?(self)
        if switch == "status"
          "相手からリクエストを受けています"
        else
          "相手のリクエストを受ける"
        end
      else
        if switch == "status"
          "リクエストを受けても出してもいません"
        else
          "フォローをリクエストする"
        end
      end
    end
  end

end
