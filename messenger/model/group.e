note
	description: "Summary description for {GROUP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GROUP

create
	make

feature {NONE} -- Initialization

	make (a_group_id: INTEGER_64; a_group_name: STRING)
		do
			group_id	:= a_group_id
			group_name	:= a_group_name
			create {ARRAYED_LIST[INTEGER_64]} group_members.make (0)
		end

feature {GROUP} -- Attributes

	group_id:		INTEGER_64
	group_name:		STRING
	group_members:	LIST[INTEGER_64]

feature -- Visible Commands

	register_user (a_uid: INTEGER_64)
	do
		group_members.force (a_uid)
	end

feature -- Visible Queries

	get_id: INTEGER_64
		do
			Result := group_id
		end

	get_name: STRING
		do
			Result := group_name
		end

	get_members: LIST[INTEGER_64]
		do
			Result := group_members
		end

end
