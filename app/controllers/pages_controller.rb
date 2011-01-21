class PagesController < ApplicationController
  def index
    @number_of_manufacturers = Manufacturer.count
    @number_of_phone_models = PhoneModel.count
    @number_of_phones = Phone.count
    
    @popular_phones_models = Phone.count(:group => :phone_model_id, :limit => 5).keys.collect{|x| PhoneModel.find(x)}
    @popular_manufacturers = Phone.joins(:phone_model).count(:group => :manufacturer_id).keys.collect{|x| Manufacturer.find(x)}
  end

end
