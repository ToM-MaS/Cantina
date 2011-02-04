class ManufacturerTiptelController < ApplicationController
	
	def show
		mac_address = params[:mac_address].upcase.gsub(/[^A-F0-9]/,'')
		@phone = Phone.where(:mac_address => mac_address).first
		
		##### Codec mapping {
    @codec_map = {
      :"ulaw"   => "PCMU",
      :"alaw"   => "PCMA",
      :"g722"   => "G722",
      :"g723"   => "G723_53",
      :"g726"   => "G726-32",
      :"g729"   => "G729",
      :"g726-16" => "G726-16",
      :"g726-24" => "G726-24",
      :"g726-40" => "G726-40",
    }
    @cmapping_map = {
      :"PCMU"    =>  "0",
      :"PCMA"    =>  "8",
      :"G722"    =>  "9",
      :"G723_53" =>  "4",
      :"G726-32" =>  "2",
      :"G729"    => "18",
      :"G726-16" =>  "112",
      :"G726-24"  =>  "102",
      :"G726-40" => "104"
    }
		##### Codec mapping }
    #### key and dtmf map
    @key_map = {
      :"BLF" => "16",
      :"Speed dial" => "13",
      :"Action  Url" => "17",
      :"Line" => "15"
    }
    @dtmf_map = {
      :"rfc2833" => "1",
      :"inband" => "0",
      :"info" => "2"
    }
    
    ####
		if ! @phone.nil?
			@phone.provisioning_log_entries.create(:succeeded => true, :memo => "Phone got config")
			@phone.update_attributes(:ip_address => request.remote_ip)
			
			respond_to { |format|
				format.txt
			}
		else
			#respond_to { |format|
			#	format.html
			#}
			render(
				:status => 404,
				:layout => false,
				:content_type => 'text/plain',
				:text => "<!-- Phone #{mac_address.inspect} not found. -->",
			)
		end
	end
	
	def index
		mfc = Manufacturer.where(:ieee_name => "XIAMEN YEALINK NETWORK TECHNOLOGY CO.,LTD").first
		@phones = mfc ? mfc.phones : []
		
		respond_to { |format|
			format.html # index.html.erb
			format.xml  { render :xml => @phones }
		}
	end
	
end
