-------------------------------------------------------------------------------
	MESSENGER					  	    {MESSENGER}
-------------------------------------------------------------------------------

Attributes:

	output:			OUTPUT
	user_list:		HASH_TABLE[USER]
	group_list:		HASH_TABLE[GROUP]
	message_list:		HASH_TABLE[MESSAGE]    -- By virtue of mapping, 
						       -- creates message_id
	
-------------------------------------------------------------------------------
	MESSENGER
-------------------------------------------------------------------------------

Initialization:

	make
	do
		create output.make
		create {HASH_TABLE[USER]}	user_list.make (0)
		create {HASH_TABLE[GROUP]}	group_list.make (0)
		create {HASH_TABLE[MESSAGE]}	message_list.make (0)
	end
	
Commands Planning:

	add_user (uid: INTEGER_64; user_name: STRING)
	local
		l_user: USER
	do
		create l_user.make (uid, user_name)
		user_list.force (l_user)
	end
	
	add_group (gid: INTEGER_64; group_name: STRING)
	local
		l_group: GROUP
	do
		create l_group.make (gid, group_name)
		group_list.force (l_group)
	end
	
	register_user (uid: INTEGER_64; gid: INTEGER_64)
	do			        
		get_group (gid).register_user (uid)
	end
	
	send_message (uid: INTEGER_64; gid: INTEGER_64; txt: STRING)
	local
		l_message: MESSAGE
	do			
		l_message.make (uid, gid, txt)
		message_list.force (l_message)
	end
	
	read_message (uid: INTEGER_64; mid: INTEGER_64)
	do				        
	
	end
	
	delete_message (uid: INTEGER_64; mid: INTEGER_64)
	do				      
	s
	end
	
	set_message_preview (n: INTEGER_64)
	do		
		output.set_preview_length (n)
	end
	
Output Planning:

	out: STRING
	do
		Result := output.print_output
	end
			
Information Export:

	get_user (uid: INTEGER_64): USER
	do
		-- Some across notation with Result
		across 
			user_list as user
		
	end
	
	get_message (mid: INTEGER_64): MESSAGE
	do
		-- Some across notation with Result
	end
	
	get_group (mid: INTEGER_64): GROUP
	do
		-- Some across notation with Result
	end
	
-------------------------------------------------------------------------------
	MESSENGER					     	       {OUTPUT}
-------------------------------------------------------------------------------

	get_user_list: HASH_TABLE[USER]
	do
		Result := user_list
	end
	
	get_group_list: HASH_TABLE[GROUP]
	do
		Result := group_list
	end
	
	get_message_list: HASH_TABLE[MESSAGE]
	do
		Result := message_list
	end
	
-------------------------------------------------------------------------------
	MESSENGER					  	    {MESSENGER}
-------------------------------------------------------------------------------
