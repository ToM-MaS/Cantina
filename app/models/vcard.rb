class Vcard < ActiveRecord::Base
  belongs_to :vcardable, :polymorphic => true
end
