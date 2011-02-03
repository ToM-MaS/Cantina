class ManufacturerAastraController < ApplicationController
	
	def show
		mac_address = params[:mac_address].upcase.gsub(/[^A-F0-9]/,'')
		@phone = Phone.where(:mac_address => mac_address).first
		
		##### Codec mapping {
		@supported_codecs = {
			'alaw'     =>   8,  # G711a/8000 G711a (8K)
			'ulaw'     =>   0,  # G711u/8000 G711u (8K)
			'g722'     =>   9,  # G722/8000 G722
			'g726'     =>  98,  # G726-16/8000 G726-16
			'g726-24'  =>  97,  # G726-24/8000 G726-24
			'g726-32'  => 115,  # G726-32/8000 G726-32
			'g726-40'  =>  96,  # G726-40/8000 G726-40
			'g729'     =>  18,  # G729/8000 G729
			'bv16'     => 106,  # BV16/8000 BV16 (8K)
			'bv32'     => 107,  # BV32/16000 BV32 (16K)
			'ulaw-16k' => 110,  # G711u/16000 G711u (16K)
			'alaw-16k' => 111,  # G711a/16000 G711a (16K)
			'l16'      => 113,  # L16/16000 L16 (16K)
			'l16-8k'   => 112,  # L16/8000 L16 (8K)
		}
		##### Codec mapping }
		
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
		mfc = Manufacturer.where(:ieee_name => "DeTeWe-Deutsche Telephonwerke").first
		@phones = mfc ? mfc.phones : []
		
		respond_to { |format|
			format.html # index.html.erb
			format.xml  { render :xml => @phones }
		}
	end
	
end
