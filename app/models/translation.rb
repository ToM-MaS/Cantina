class Translation < ActiveRecord::Base
  belongs_to :language
  belongs_to :translatable, :polymorphic => true
  
end
