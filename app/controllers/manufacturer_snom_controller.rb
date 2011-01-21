class ManufacturerSnomController < ApplicationController
def show
  if params[:mac_address].nil?
      @phone = Phone.find(params[:id])
    else
      mac_address = params[:mac_address].upcase.gsub(/[^A-F0-9]/,'')
      @phone = Phone.where(:mac_address => mac_address).first
      
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  #{ render :xml => @phone }
    end
end

def index
    @phones = Manufacturer.where(:ieee_name => "SNOM Technology AG").first.phones

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @phones }
    end
  end
end
