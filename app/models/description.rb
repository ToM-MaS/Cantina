class Description < ActiveRecord::Base
  has_many :translations, :as => :translatable, :dependent => :destroy
  belongs_to :descriptionable, :polymorphic => true
  
  
end
