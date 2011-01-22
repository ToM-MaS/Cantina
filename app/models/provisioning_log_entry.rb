# == Schema Information
# Schema version: 20110121121114
#
# Table name: provisioning_log_entries
#
#  id         :integer         not null, primary key
#  phone_id   :integer
#  memo       :string(255)
#  succeeded  :boolean
#  created_at :datetime
#  updated_at :datetime
#

class ProvisioningLogEntry < ActiveRecord::Base
  belongs_to :phone
  
  # TODO testing
end
