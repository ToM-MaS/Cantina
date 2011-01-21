xml.instruct!  # <?xml version="1.0" encoding="UTF-8"?>

xml.settings {
	if @phone == nil
		xml.comment! "Phone with the given MAC address not found."  # <!-- a comment -->
	else
		
		xml.tag! 'phone-settings' do
			xml.web_language( 'English', :perm => 'RW' )
			xml.timezone( 'GMT+1', :perm => 'RW' )
			xml.date_us_format( 'off', :perm => 'RW' )
			xml.time_24_format( 'on', :perm => 'RW' )
			
			xml.retry_after_failed_register( '70', :perm => 'RW' )
			xml.encode_display_name( 'on', :perm => 'R' )
			xml.dtmf_payload_type( '101', :perm => 'RW' )
			
			snom_sip_acct_idx = 0
			@phone.sip_accounts.each { |sip_account|
				# The sip_account.position which we get from the database
				# is an arbitrary index but for the Snom we need the index
				# to be from 1 to 4, 7 or 12, depending on the phone model.
				#snom_sip_acct_idx = sip_account.position
				snom_sip_acct_idx += 1
				
				saopts_r  = { :idx => snom_sip_acct_idx, :perm => 'R'  }
				saopts_rw = { :idx => snom_sip_acct_idx, :perm => 'RW' }
								
				xml.comment! "SIP account position #{sip_account.position}"  # <!-- a comment -->
				xml.user_active(            'on'                        , saopts_rw )
				xml.user_pname(             sip_account.auth_user       , saopts_r  )
				xml.user_pass(              sip_account.password        , saopts_r  )
				xml.user_host(              sip_account.registrar       , saopts_r  )
				xml.user_outbound(          sip_account.outbound_proxy  , saopts_r  )
				xml.user_name(              sip_account.user            , saopts_r  )
				xml.user_realname(          sip_account.display_name    , saopts_r  )
				xml.user_idle_text(         sip_account.screen_name     , saopts_r  )
				xml.user_expiry(            sip_account.registration_expiry_time || 3600 , saopts_r )
				xml.user_server_type(       'default'                   , saopts_rw )
				xml.user_send_local_name(   'on'                        , saopts_rw )
				xml.user_dtmf_info(         sip_account.dtmf_mode == 'rfc2833' ? 'off' : 'sip_info_only' , saopts_r )
				xml.user_dp_exp(            ''                          , saopts_rw )
				xml.user_dp_str(            ''                          , saopts_rw )
				xml.user_dp(                ''                          , saopts_rw )
				xml.user_q(                 '1.0'                       , saopts_rw )
				xml.user_full_sdp_answer(   'on'                        , saopts_rw )
				xml.user_failover_identity( 'none'                      , saopts_rw )
				# sip_account.realm
				# sip_account.registrar_port
				# sip_account.outbound_proxy_port
				# sip_account.sip_proxy_port
				# sip_account.sip_proxy
				# sip_account.remote_password
				
				
				# FIXME - read codecs from the database once http://groups.google.com/group/amooma-dev/browse_thread/thread/b126253ccc0419ac has been solved
				xml.comment! "codecs for SIP account position #{sip_account.position}"  # <!-- a comment -->
				# See http://wiki.snom.com/Settings/codec_name
				# (Note: Snom's documentation is wrong.)
				[
					 8,  # G.711 alaw
					 0,  # G.711 ulaw
					 3,  # GSM
					 2,  # G.726-32
					18,  # G.729a
					 9,  # G.722
					 4,  # G.723.1
				].each_with_index {  |codec_num, codec_idx|
					xml.tag! "codec#{1+codec_idx}_name", codec_num, saopts_r
				}
			}
		end
		
		
		xml.comment! "function keys"  # <!-- a comment -->
		xml.tag! 'functionKeys' do
			
			#@phone.phone_keys.each do |phone_key|
			#	xml.fkey("blf #{phone_key.value}", :label => phone_key.label,:idx => phone_key.id, :context => 'active', :perm => 'R')
			#end
			
			softkeys = []
			snom_sip_acct_idx = 0
			@phone.sip_accounts.each { |sip_account|
				#snom_sip_acct_idx = sip_account.position
				snom_sip_acct_idx += 1
				# Let's hope that we get the sip_accounts in the same
				# order as above.
				# Here we know the sip_account .
				sip_account.phone_keys.each { |phone_key|
					# Here we know phone_key.value .
					# Here we know phone_key.phone_model_key.position .
					# Here we know phone_key.phone_key_function_definition.name .
					type = case (phone_key.phone_key_function_definition ? phone_key.phone_key_function_definition.name.downcase : nil)
						when 'blf'              ; 'blf' # or 'dest'
						when 'speed dial'       ; 'speed'
						when 'actionurl'        ; 'url'
						when 'line'             ; 'line'
						when 'phone-spec. fn.'  ; nil  # or 'none'
						when 'label'            ; nil  # or 'none'
						when 'xml'              ; 'xml'
						when 'intercom'         ; 'icom'
						when 'parking'          ; 'orbit'
						when 'recording'        ; 'recorder'
						when 'dtmf'             ; 'dtmf'
						when 'ptt'              ; 'p2t'
						when 'button'           ; 'button'
						when 'presence'         ; 'presence'
						when 'transfer'         ; 'transfer'
						when 'redirect'         ; 'redirect'
						when 'auto-answer'      ; 'autoanswer'
						when 'def. function?'   ; nil  # or 'none'
						else                    ; nil  # or 'none'
							# Someone renamed a PhoneKeyFunctionDefinition.
					end
					softkeys << {
						:pos     => (phone_key.phone_model_key ? phone_key.phone_model_key.position : nil),
						:type    => type,
						:val     => phone_key.value,
						:acctidx => snom_sip_acct_idx,
					}
				}
			}
			puts "---------------------------------------------------------"
			pp softkeys
			puts "---------------------------------------------------------"
			# FIXME: remove log output.
			# TODO: sort the array of hashes by :pos.
			# (0..120).each ...
			# Problem: Currently we can get more than one key per pos,
			# and the pos can be nil.
			
			
		end
		
	end
}


# Local Variables:
# mode: ruby
# End:
