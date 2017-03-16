---------------------------------------------------------------------
	MESSAGE						    {MESSAGE}
---------------------------------------------------------------------

Attributes:

	message_sender:		INTEGER_64
	message_group:		INTEGER_64
	message_content:	STRING
	
---------------------------------------------------------------------
	MESSAGE							
---------------------------------------------------------------------

Initialization:

	make (a_message_sender: INTEGER_64; a_group_id: INTEGER_64; a_message_content: STRING)
	do
		message_sender	:= a_message_sender
		message_group	:= a_message_group
		message_content	:= a_message_content
