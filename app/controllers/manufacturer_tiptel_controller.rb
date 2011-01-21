class ManufacturerTiptelController < ApplicationController
def show
  if params[:mac_address].nil?
      @phone = Phone.find(params[:id])
    else
      mac_address = params[:mac_address].upcase.gsub(/[^A-F0-9]/,'')
      @phone = Phone.where(:mac_address => mac_address).first
      
    end

    respond_to do |format|
      format.txt
    end
end

def index
    mfc = Manufacturer.where(:ieee_name => "XIAMEN YEALINK NETWORK TECHNOLOGY CO.,LTD").first
    @phones = mfc ? mfc.phones : []

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @phones }
    end
  end
end
