class Folder < ActiveRecord::Base
    belongs_to :user
    has_many :registers
    has_many :carts, through: :registers
    
    has_many :register2s
    has_many :purchases, through: :register2s
end
