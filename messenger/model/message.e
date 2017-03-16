note
	description: "Summary description for {MESSAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MESSAGE

create
	make

feature {NONE} -- Initialization

	make (a_message_sender: INTEGER_64; a_group_id: INTEGER_64; a_message_content: STRING)
		do
			message_group	:= a_group_id
			message_sender	:= a_message_sender
			message_content	:= a_message_content
		end

feature {MESSAGE} -- Attributes

	message_group:		INTEGER_64
	message_sender:		INTEGER_64
	message_content:	STRING


end
