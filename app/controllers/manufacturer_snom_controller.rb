class ManufacturerSnomController < ApplicationController
def show
  if params[:mac_address].nil?
      @phone = Phone.find(params[:id])
    else
      mac_address = params[:mac_address].upcase.gsub(/[^A-F0-9]/,'')
      @phone = Phone.where(:mac_address => mac_address).first
      
      # send "404 Not Found" if phone with the given MAC address does not exists {
      if @phone.nil?
        render(
          :status => 404,
          :layout => false,
          :content_type => 'text/plain',
          :text => "<!-- Phone #{mac_address.inspect} not found. -->",
        )
        return
      end
      # send "404 Not Found" if phone with the given MAC address does not exists }
      
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  #{ render :xml => @phone }
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
