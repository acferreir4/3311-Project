note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	MESSENGER

inherit
	ANY
		redefine
			out
		end

create {MESSENGER_ACCESS}
	make

feature {NONE} -- Initialization
	make
		do
			user_list_key 		:= 1
			group_list_key		:= 1
			message_list_key	:= 1

			create output.make
			create user_list.make (0)
			create group_list.make (0)
			create message_list.make (0)
		end

feature {MESSENGER} -- Attributes

	output: 			OUTPUT
	user_list:			HASH_TABLE[USER, INTEGER_64]
	group_list:			HASH_TABLE[GROUP, INTEGER_64]
	message_list:		HASH_TABLE[MESSAGE, INTEGER_64]
	user_list_key:		INTEGER_64
	group_list_key:		INTEGER_64
	message_list_key:	INTEGER_64

feature -- Visible Commands

	reset
		do
			make
		end

	add_group (a_gid: INTEGER_64; a_group_name: STRING)
		local
			l_group: GROUP
		do
			create l_group.make (a_gid, a_group_name)
			group_list.force (l_group, group_list_key)
			group_list_key := group_list_key + 1
		end

	add_user (a_uid: INTEGER_64; a_user_name: STRING)
		local
			l_user: USER
		do
			create l_user.make (a_uid, a_user_name)
			user_list.force (l_user, user_list_key)
			user_list_key := user_list_key + 1
		end

	register_user (a_uid: INTEGER_64; a_gid: INTEGER_64)
		do
			get_group (a_gid).register_user (a_uid)
		end

	send_message (a_uid: INTEGER_64; a_gid: INTEGER_64; a_txt: STRING)
		local
			l_message: MESSAGE
		do
			create l_message.make (a_uid, a_gid, a_txt)
			message_list.force (l_message, message_list_key)
			message_list_key := message_list_key + 1
		end

	read_message (a_uid: INTEGER_64; a_mid: INTEGER_64)
		do

		end

	delete_message (a_uid: INTEGER_64; a_mid: INTEGER_64)
		do

		end

	set_message_preview (a_n: INTEGER_64)
		do
			output.set_preview_length (a_n)
		end

	list_groups
		do
			-- Defer this task to OUTPUT
		end

	list_new_messages (a_uid: INTEGER_64)
		do
			-- Defer this task to OUTPUT
		end

	list_old_messages (a_uid: INTEGER_64)
		do
			-- Defer this task to OUTPUT
		end

	list_users
		do
			-- Defer this task to OUTPUT
		end

feature -- Visible Queries

	out: STRING
		do
			Result := output.print_output
		end

feature -- Information Queries						(YET TO HIDE)

	get_user (a_uid: INTEGER_64): USER
		local
			l_user: USER
		do
			create l_user.make (0, "")				-- VEVI Compiler

			across
				user_list as user
			loop
				if user.item.get_id = a_uid then
					l_user := user.item
				end
			end

			Result := l_user
		end

--	get_message (a_mid: INTEGER_64): MESSAGE
--		do
--			Not sure if necessary atm...
--		end

	get_group (a_gid: INTEGER_64): GROUP
		local
			l_group: GROUP
		do
			create l_group.make (0, "")				-- VEVI Compiler

			across
				group_list as group
			loop
				if group.item.get_id = a_gid then
					l_group := group.item
				end
			end

			Result := l_group
		end

feature {OUTPUT} -- Output Information Queries

	get_user_list: HASH_TABLE[USER, INTEGER_64]
		do
			Result := user_list
		end

	get_group_list: HASH_TABLE[GROUP, INTEGER_64]
		do
			Result := group_list
		end

	get_message_list: HASH_TABLE[MESSAGE, INTEGER_64]
		do
			Result := message_list
		end

feature -- Defensive Checks

	is_positive_num (a_num: INTEGER_64): BOOLEAN
	do
		Result := a_num.is_greater (0)
	end

	is_unused_uid (a_uid: INTEGER_64): BOOLEAN
	do
		Result := across user_list as user all user.item.get_id /= a_uid end
	end

	is_unused_gid (a_gid: INTEGER_64): BOOLEAN
	do
		Result := across group_list as group all group.item.get_id /= a_gid end
	end

	is_valid_name (a_name: STRING): BOOLEAN
	do
		Result := a_name.at (1).is_alpha
	end

	user_exists (a_uid: INTEGER_64): BOOLEAN
	do
		Result := true
	end

	group_exists (a_gid: INTEGER_64): BOOLEAN
	do
		Result := true
	end

	registration_exists (a_uid: INTEGER_64; a_gid: INTEGER_64): BOOLEAN
	do
		Result := true
	end

	is_empty_msg (a_msg: STRING): BOOLEAN
	do
		Result := a_msg.count.is_greater (0)
	end

	user_authorized_send (a_uid: INTEGER_64; a_gid: INTEGER_64): BOOLEAN
	do
		Result := true
	end

	message_exists (a_mid: INTEGER_64): BOOLEAN
	do
		Result := true
	end

	user_authorized_access (a_uid: INTEGER_64; a_mid: INTEGER_64): BOOLEAN
	do
		Result := true
	end

	message_is_read (a_uid: INTEGER_64; a_mid: INTEGER_64): BOOLEAN
	do
		Result := true
	end

	message_deletable
	do
		
	end

end
