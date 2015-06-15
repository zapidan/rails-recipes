class Review < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :chef
  validates :chef_id,   presence: true
  validates :recipe_id, presence: true
  validates :body,      presence: true,  length: { minimum: 5, maximum: 500 }
end