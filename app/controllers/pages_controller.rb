class PagesController < ApplicationController
  def index
    @number_of_manufacturers = Manufacturer.count
    @number_of_phone_models = PhoneModel.count
    @number_of_phones = Phone.count
  end

end
