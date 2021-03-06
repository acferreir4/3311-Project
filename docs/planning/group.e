---------------------------------------------------------------------
	GROUP						      {GROUP}
---------------------------------------------------------------------

Attributes:

	group_id:		INTEGER_64
	group_name:		STRING
	group_members:		ARRAY[USER_ID]
	
---------------------------------------------------------------------
	GROUP							
---------------------------------------------------------------------

Initialization:

	make (a_group_id: INTEGER_64; a_group_name: STRING)
	do
		group_id	:= a_group_id
		group_name	:= a_group_name
		create group_members.make (0)
	end

Commands Planning:

	register_user (uid: INTEGER_64)
	do
		group_members.force (uid)
	end
	
	
