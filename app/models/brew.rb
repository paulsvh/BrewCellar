class Brew < ActiveRecord::Base
    validates_presence_of :brewery, :beer_name
    belongs_to :user
end