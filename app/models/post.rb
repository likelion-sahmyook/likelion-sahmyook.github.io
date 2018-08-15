class Post < ApplicationRecord
  resourcify
  has_many :images
  belongs_to :user
  validates :user, presence: true
  paginates_per 5
  
  
 has_many :impressions, :as=>:impressionable
  
   def impression_count
       impressions.size
   end

   def unique_impression_count
       # impressions.group(:ip_address).size gives => {'127.0.0.1'=>9, '0.0.0.0'=>1}
       # so getting keys from the hash and calculating the number of keys
       impressions.group(:ip_address).size.keys.length #TESTED
   end

   #검색
   # 오류때매 잠깐 주석처리
    # searchable do
    # text :title, :boost => 2
    # text :content
   # end 
   
  # validates_presence_of :title
  # searchable do
  #   text :title
  #   end

end


   

