# == Schema Information
# Schema version: 20110113200244
#
# Table name: descriptions
#
#  id                   :integer         not null, primary key
#  name                 :string(255)
#  descriptionable_type :string(255)
#  descriptionable_id   :integer
#  created_at           :datetime
#  updated_at           :datetime
#

class Description < ActiveRecord::Base
  has_many :translations, :as => :translatable, :dependent => :destroy
  belongs_to :descriptionable, :polymorphic => true
  
  #TODO: Validations
end
