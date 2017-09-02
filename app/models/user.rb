class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :chat_rooms, dependent: :destroy
  has_many :messages, dependent: :destroy

  def name
    email.split('@')[0]
  end

  has_attached_file :avatar, :styles => { :medium => '300x300>', :thumb => '30x30#' }, :default_url => '/images/:style/missing.jpg'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

end
