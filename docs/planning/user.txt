---------------------------------------------------------------------
	USER						       {USER}
---------------------------------------------------------------------

Attributes:

	user_id:		INTEGER_64
	user_name:		STRING
	user_messages:		LIST[TUPLE [message_id: INTEGER_64; status: STRING]]
	
---------------------------------------------------------------------
	USER								 
---------------------------------------------------------------------

Initialization:
	
	make (a_user_id: INTEGER_64; a_user_name: STRING)
	do
		user_id		:= a_user_id
		user_name	:= a_user_names
		create {ARRAYED_LIST[TUPLE [message_id: INTEGER_64; status: STRING]]} user_messages.make (0)
	end

Commands Planning:

	
Queries Planning:


