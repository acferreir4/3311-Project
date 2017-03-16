note
	description: "Summary description for {USER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	USER

create
	make

feature {NONE} -- Initialization

	make (a_user_id: INTEGER_64; a_user_name: STRING)
		do
				user_id 	:= a_user_id
				user_name 	:= a_user_name
				create user_messages.make (0)
		end

feature {USER} -- Features

	user_id: 		INTEGER_64
	user_name: 		STRING
	user_messages:	HASH_TABLE[STRING, INTEGER_64]

feature -- Visible Queries

	get_id: INTEGER_64
		do
			Result := user_id
		end

	get_name: STRING
		do
			Result := user_name
		end

	get_messages: HASH_TABLE[STRING, INTEGER_64]
		do
			Result := user_messages
		end

feature -- Visible Commands

	read_message (a_message_id: INTEGER_64)
		do
			user_messages.at (a_message_id) := "read"
		end

	add_message (a_message_id: INTEGER_64)
		do
			user_messages.force ("unread", a_message_id)
		end

	delete_message (a_message_id: INTEGER_64)
		do
			user_messages.remove (a_message_id)
		end

end
