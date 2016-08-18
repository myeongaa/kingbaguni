class Purchase < ActiveRecord::Base
    belongs_to :user
    
    has_many :register2s
    has_many :folders, through: :register2s
end
