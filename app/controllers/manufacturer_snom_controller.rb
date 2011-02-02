class ManufacturerSnomController < ApplicationController
def show
  mac_address = params[:mac_address].upcase.gsub(/[^A-F0-9]/,'')
  @phone = Phone.where(:mac_address => mac_address).first
  
  if ! @phone.nil?
    @phone.provisioning_log_entries.create(:succeeded => true, :memo => "Phone got config")
    @phone.update_attributes(:ip_address => request.remote_ip)
    respond_to do |format|
      format.xml 
    end
  else
    respond_to do |format|
      format.html
    end 
  end
end



def index
    mfc = Manufacturer.where(:ieee_name => "SNOM Technology AG").first
    @phones = mfc ? mfc.phones : []

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @phones }
    end
  end
end
