class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :participants
  has_many :chat_rooms, through: :participants
  has_many :messages, dependent: :destroy

  def name
    email.split('@')[0]
  end

  def online?
    !Redis.new.get("user_#{self.id}_online").nil?
  end

  #this line prevents users from using any email server
  validates_format_of :email, with: /\@yourdomain\.com/, message: 'You should have an email from yourdomain.com'

  has_attached_file :avatar, :styles => { :medium => '300x300>', :thumb => '30x30#' }, :default_url => '/images/:style/missing.jpg'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

end
