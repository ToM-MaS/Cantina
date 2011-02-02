class ManufacturerTiptelController < ApplicationController
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
    
    # Codec mapping {
    @codec_map = {
      :"ulaw"  => "PCMU",
      :"alaw"  => "PCMA",
      :"g722"  => "G722",
      :"g723"  => "G723_53",
      :"g726"  => "G726-32",
      :"g729"  => "G729",
      :"nouse1" => "G726-16",
      :"nouse2" => "G726-24",
      :"nouse3" => "G726-40"
    }
    @cmapping_map = {
      :"PCMU"    => "0",
      :"PCMA"    => "8",
      :"G722"    => "9",
      :"G723_53" => "4",
      :"G726-32" => "2",
      :"G729"    => "18"
    }
    # Codec mapping }
    
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
