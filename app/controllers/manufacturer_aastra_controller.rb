class ManufacturerAastraController < ApplicationController

  def show
    @mac_address = params[:mac_address]
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
