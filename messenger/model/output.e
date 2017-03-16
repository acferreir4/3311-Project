note
	description: "Summary description for {OUTPUT}."
	author: "DNSheng"
	date: "$Date$"
	revision: "$Revision$"

class
	OUTPUT

create
	make

feature {NONE} -- Initialization

	make
		local
			messenger_access: MESSENGER_ACCESS
		do
			status_counter	:= 0
			status_message	:= "OK"
			messenger	:= messenger_access.m
			create error_message.make_empty
		end

feature {OUTPUT} -- Attributes

	messenger:	MESSENGER
	error_message:	STRING
	status_message:	STRING
	print_state:	INTEGER_64
	status_counter:	INTEGER_64
	preview_length:	INTEGER_64

feature -- Visible Commands

	set_preview_length (a_preview_length: INTEGER_64)
	do
		preview_length := a_preview_length
	end

	error_flag (a_error_flag: INTEGER)
	do
		inspect a_error_flag
			when  0 then error_message := "ID must be a positive integer."
			when  1 then error_message := "ID already in use"
			when  2 then error_message := "User name must start with a letter."
			when  3 then error_message := "Group name must start with a letter."
			when  4 then error_message := "User with this ID does not exist."
			when  5 then error_message := "Group with this ID does not exist."
			when  6 then error_message := "This registration already exists."
			when  7 then error_message := "A message may not be an empty string."
			when  8 then error_message := "User not authorized to send messages to the specified group."
			when  9 then error_message := "Message with this ID does not exist."
			when 10 then error_message := "User not authorized to access this message."
			when 11 then error_message := "Message has already been read. See 'list_old_messages'."
			when 12 then error_message := "Message with this ID not found in old/read messages."
			when 13 then error_message := "Message length must be greater than zero."
		end
		print_state	:= 1
		status_message	:= "ERROR"
	end

feature -- Visible Queries

	print_output: STRING
	do
		inspect print_state
			when 0 then Result := print_default_state
			when 1 then Result := print_error_state
			when 2 then Result := list_groups
			when 3 then Result := list_new_messages
			when 4 then Result := list_old_messages
			when 5 then Result := list_users
		end
		internal_reset
	end

feature {OUTPUT} -- Internal Commands

	internal_reset
	do
		print_state	:= 0
		error_message	:= ""
		status_message	:= "OK"
		status_counter	:= status_counter + 1
	end

feature {OUTPUT} -- Internal Printing Queries

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
		l_user_list: HASH_TABLE[USER, INTEGER_64]
	do
		create Result.make_from_string("  ")
		Result.append ("Users:%N")
		l_user_list := messenger.get_user_list
		-- Print
	end

	print_groups: STRING
	local
		l_group_list: HASH_TABLE[GROUP, INTEGER_64]
	do
		create Result.make_from_string("  ")
		create Result.make_from_string("  ")
		Result.append ("Groups:%N")
		l_group_list := messenger.get_group_list
		-- Print
	end

	print_registrations: STRING
	local
		l_user_list: HASH_TABLE[USER, INTEGER_64]
	do
		create Result.make_from_string("  ")
		Result.append ("Registrations:%N")
		l_user_list := messenger.get_user_list
		-- Print
	end

	print_all_messages: STRING
	local
		l_message_list: HASH_TABLE[MESSAGE, INTEGER_64]
	do
		create Result.make_from_string("  ")
		Result.append ("All messages:%N")
		l_message_list := messenger.get_message_list
		-- Print
	end

	print_message_state: STRING
	local
		l_user_list: HASH_TABLE[USER, INTEGER_64]
	do
		create Result.make_from_string("  ")
		Result.append ("Message state:%N")
		l_user_list := messenger.get_user_list
		-- Print based on preview_length var
	end

feature {OUTPUT} -- Main Printing Queries

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
		end

	list_users: STRING
		do
			create Result.make_empty
			-- Alphabetically sorted
		end

	list_groups: STRING
		do
			create Result.make_empty
			-- Alphabetically sorted
		end

	list_new_messages: STRING
		do
			create Result.make_empty
		end

	list_old_messages: STRING
		do
			create Result.make_empty
		end
end
