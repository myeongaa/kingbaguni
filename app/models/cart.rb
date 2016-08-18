class Cart < ActiveRecord::Base
    belongs_to :user
    has_many :registers
    has_many :folders, through: :registers
end