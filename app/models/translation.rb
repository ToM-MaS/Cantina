# == Schema Information
# Schema version: 20110119105502
#
# Table name: translations
#
#  id                :integer         not null, primary key
#  value             :string(255)
#  language_id       :integer
#  translatable_type :string(255)
#  translatable_id   :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class Translation < ActiveRecord::Base
  belongs_to :language
  belongs_to :translatable, :polymorphic => true
  
  #TODO: Validations (polymorphic association)
end
