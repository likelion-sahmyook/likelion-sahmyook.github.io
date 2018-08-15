class User < ApplicationRecord
  #?? 이거 왜 써놓은 건지 모르겠네?
  has_many :posts
  rolify
  # rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_uniqueness_of :nickname
end
