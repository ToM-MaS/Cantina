class ManufacturerAastraController < ApplicationController

def show
        mac_address = params[:mac_address].upcase.gsub(/[^A-F0-9]/,'')
      @phone = Phone.where(:mac_address => mac_address).first
      


    respond_to do |format|
      format.txt
    end
end

def index
    mfc = Manufacturer.where(:ieee_name => "DeTeWe-Deutsche Telephonwerke").first
    @phones = mfc ? mfc.phones : []

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @phones }
    end
  end

end
