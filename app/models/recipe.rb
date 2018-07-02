class Recipe < ApplicationRecord

  belongs_to :user

  mount_uploader :image, ImageUploader
  has_many :ingredients
  has_many :directions
  	accepts_nested_attributes_for :ingredients,
  															reject_if: proc { |attributes| attributes['name'].blank? },
  															allow_destroy: true
 	  accepts_nested_attributes_for :directions,
  															reject_if: proc { |attributes| attributes['step'].blank? },
  															allow_destroy: true


  		validates :title, :description, :image, presence: true
  		#validates_acceptance_of :image

end
