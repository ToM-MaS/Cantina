# == Schema Information
# Schema version: 20110113094740
#
# Table name: vcards
#
#  id             :integer         not null, primary key
#  name           :string(255)
#  content        :text
#  position       :integer
#  vcardable_type :string(255)
#  vcardable_id   :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Vcard < ActiveRecord::Base
  belongs_to :vcardable, :polymorphic => true
end
