-------------------------------------------------------------------------------
	OUTPUT						     	       {OUTPUT}
-------------------------------------------------------------------------------

Attributes:

	error_message:		STRING
	status_message: 	STRING
	print_state:		INTEGER_64	   --0 for default, 1 for error
	status_counter:		INTEGER_64
	preview_length:		INTEGER_64
	messenger:		MESSENGER
	
-------------------------------------------------------------------------------
	OUTPUT								 
-------------------------------------------------------------------------------
-- TODO:
--		Receive information on the model from MESSENGER
--			- MESSENGER gives this using "get" queries, called 
--			  during the "out" query in MESSENGER
--			- Build functions and variables to receive this
--		Flesh out the error_flag with the required error messages given


Initialization:
	
	make
	local
		messenger_access :MESSENGER_ACCESS
	do
		status_counter	:= 0
		status_message	:= "OK"
		messenger 	:= messenger_access.m
		create error_message.make_from_empty
	end

Commands Planning:
	
	set_preview_length (a_preview_length: INTEGER_64)
	do
		preview_length := a_preview_length
	end	

	error_flag (a_error_flag: INTEGER)
	do
		inspect a_error_flag
			when 0 then error_message := ""
			when 1 then error_message := ""
		end
		print_state	:= 1
		status_message	:= "ERROR"
	end

Queries Planning:
	
	print_output: STRING
	do
		if print_state = 0 then
			Result := print_default_state
		else
			Result := print_error_state
		end
		internal_reset
	end

-------------------------------------------------------------------------------
	OUTPUT						     	       {OUTPUT}
-------------------------------------------------------------------------------

Internal Commands Planning:

	internal_reset
	do
		print_state	:= 0
		error_message	:= ""
		status_message	:= "OK"
		status_counter	:= status_counter + 1
	end

-------------------------------------------------------------------------------
	OUTPUT						     	       {OUTPUT}
-------------------------------------------------------------------------------

(Internal Query Blocks)
Internal Queries Planning:

	print_status_message: STRING
	do
		create Result.make_from_string("  ")
		Result.append (status_counter.out)
		Result.append (":  ")
		Result.append (status_message)
	end
	
	print_error_message: STRING
	do
		create Result.make_from_string("  ")
		Result.append (error_message)
	end
	
	print_users: STRING
	local
		l_user_list: HASH_TABLE[USER]
	do
		create Result.make_from_string("  ")
		Result.append ("Users:%N")
		l_user_list := messenger.get_user_list
		-- Print
	end
	
	print_groups: STRING
	local
		l_group_list: HASH_TABLE[GROUP]
	do
		create Result.make_from_string("  ")
		Result.append ("Groups:%N")
		l_group_list := messenger.get_group_list
		-- Print
	end
	
	print_registrations: STRING
	local
		l_user_list: HASH_TABLE[USER]
	do
		create Result.make_from_string("  ")
		Result.append ("Registrations:%N")
		l_user_list := messenger.get_user_list
		-- Print
	end
	
	print_all_messages: STRING
	local
		l_message_list: HASH_TABLE[MESSAGE]
	do
		create Result.make_from_string("  ")
		Result.append ("All messages:%N")
		l_message_list := messenger.get_message_list
		-- Print
	end
	
	print_message_state: STRING
	local
		l_user_list: HASH_TABLE[USER]
	do
		create Result.make_from_string("  ")
		Result.append ("Message state:%N")
		l_user_list := messenger.get_user_list
		-- Print based on preview_length var
		across 
			l_user_list as state 
		loop
			across
				state.item.get_user_messages as message
			loop
		end
			
	end
	
-------------------------------------------------------------------------------
	OUTPUT						     	       {OUTPUT}
-------------------------------------------------------------------------------

Cumulative Queries Planning:
	
	print_default_state: STRING
	do
		create Result.make_empty
		Result.append (print_status_message)
		Result.append ("%N")
		Result.append (print_users)
		Result.append ("%N")
		Result.append (print_groups)
		Result.append ("%N")
		Result.append (print_registrations)
		Result.append ("%N")
		Result.append (print_all_messages)
		Result.append ("%N")
		Result.append (print_message_state)
	end
	
	print_error_state: STRING
	do
		create Result.make_empty
		Result.append (print_status_message)
		Result.append ("%N")
		Result.append (print_error_message)
	end
	
	
