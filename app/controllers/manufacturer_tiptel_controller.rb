class ManufacturerTiptelController < ApplicationController
	
	def show
		mac_address = params[:mac_address].upcase.gsub(/[^A-F0-9]/,'')
		@phone = Phone.where(:mac_address => mac_address).first
		
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
