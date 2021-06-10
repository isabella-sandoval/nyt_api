class Search < ApplicationRecord
    validates_uniqueness_of :title, presence: true 
    validates :author, presence:true
end
