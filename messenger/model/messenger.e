note
	description: "A default business model."
	author: "DNSheng"
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
			user_list_key		:= 1
			group_list_key		:= 1
			message_list_key	:= 1

			create output.make
			create {ARRAYED_LIST[TUPLE [user: USER; user_key: INTEGER_64]]} user_list.make (1)
			create {ARRAYED_LIST[TUPLE [group: GROUP; group_key: INTEGER_64]]} group_list.make (1)
			create message_list.make (1)
		end

feature -- Attributes

	output:					OUTPUT
	user_list:				LIST[TUPLE [user: USER; user_key: INTEGER_64]]						-- Hash tables, for easy ordinary printing format
	group_list:				LIST[TUPLE [group: GROUP; group_key: INTEGER_64]]							-- Ordinary: Print ordered by INTEGER_64 increasing
	message_list:			HASH_TABLE[MESSAGE, INTEGER_64]					-- List: Print ordered by X.name alphabetically
	user_list_key:			INTEGER_64
	group_list_key:			INTEGER_64
	message_list_key:		INTEGER_64

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

	register_user (a_uid, a_gid: INTEGER_64)
		do
			get_group (a_gid).register_user (a_uid)
		end

	send_message (a_uid, a_gid: INTEGER_64; a_txt: STRING)
		local
			l_message: MESSAGE
		do
			create l_message.make (a_uid, a_gid, a_txt)
			message_list.force (l_message, message_list_key)
			message_list_key := message_list_key + 1
		end

	read_message (a_uid, a_mid: INTEGER_64)
		do
			get_user (a_uid).read_message (a_mid)
		end

	delete_message (a_uid, a_mid: INTEGER_64)
		do
			get_user (a_uid).delete_message (a_mid)
		end

	set_message_preview (a_n: INTEGER_64)
		do
			output.set_preview_length (a_n)
		end

	list_groups
		do
			output.set_print_state (3)
		end

	list_new_messages (a_uid: INTEGER_64)
		do
			output.set_print_state (4)
		end

	list_old_messages (a_uid: INTEGER_64)
		do
			output.set_print_state (5)
		end

	list_users
		do
			output.set_print_state (6)
		end

	set_error_flag (error_flag: INTEGER)
		do
			output.error_flag (error_flag)
		end

feature -- Visible Queries

	out: STRING
		do
			Result := output.print_output
			-- Having the printing implementation here works, yet
			-- exporting it to OUTPUT causes an exception, where
			-- get_user_list returns void
		end

feature -- Information Queries						(YET TO HIDE)

	get_user (a_uid: INTEGER_64): USER
		local
			l_user: USER
		do
			create l_user.make (0, "")				-- VEVI Compiler

			across
				user_list as usr
			loop
				if usr.item.user.get_id = a_uid then
					l_user := usr.item.user
				end
			end

			Result := l_user
		end

	get_group (a_gid: INTEGER_64): GROUP
		local
			l_group: GROUP
		do
			create l_group.make (0, "")				-- VEVI Compiler

			across
				group_list as grp
			loop
				if grp.item.group.get_id = a_gid then
					l_group := grp.item.group
				end
			end

			Result := l_group
		end

feature {OUTPUT} -- Output Information Queries

	get_user_list: LIST[TUPLE [USER, INTEGER_64]]
		local
			l_user_list: LIST[TUPLE [USER, INTEGER_64]]
		do
			l_user_list := user_list
			Result := l_user_list
		end

	get_group_list: LIST[TUPLE [GROUP, INTEGER_64]]
		do
			Result := group_list
		end

	get_message_list: HASH_TABLE[MESSAGE, INTEGER_64]
		do
			Result := message_list
		end

feature {ETF_COMMAND} -- Defensive Checks

	is_positive_num (a_num: INTEGER_64): BOOLEAN
	do
		Result := a_num.as_integer_32 > 0
	end

	is_unused_uid (a_uid: INTEGER_64): BOOLEAN
	do
		Result := across user_list as usr all usr.item.user.get_id /= a_uid end
	end

	is_unused_gid (a_gid: INTEGER_64): BOOLEAN
	do
		Result := across group_list as grp all grp.item.group.get_id /= a_gid end
	end

	is_valid_name (a_name: STRING): BOOLEAN
	do
		Result := not a_name.is_empty and a_name.at (1).is_alpha
	end

	user_exists (a_uid: INTEGER_64): BOOLEAN
	do
		Result := across user_list as usr some usr.item.user.get_id = a_uid end
	end

	group_exists (a_gid: INTEGER_64): BOOLEAN
	do
		Result := across group_list as grp some grp.item.group.get_id = a_gid end
	end

	user_is_member (a_uid, a_gid: INTEGER_64): BOOLEAN
	do
		Result := get_group (a_gid).is_a_member (a_uid)
	end

	is_empty_msg (a_msg: STRING): BOOLEAN
	do
		Result := a_msg.count.is_greater (0)
	end

	user_authorized_send (a_uid, a_gid: INTEGER_64): BOOLEAN
	do
		Result := user_is_member (a_uid, a_gid)
	end

	message_exists (a_mid: INTEGER_64): BOOLEAN
	do
		Result := message_list.has (a_mid)
	end

	user_authorized_access (a_uid, a_mid: INTEGER_64): BOOLEAN
	do
		Result := get_user (a_uid).has_message (a_mid)
	end

	message_was_read (a_uid, a_mid: INTEGER_64): BOOLEAN
	do
		Result := get_user (a_uid).message_was_read (a_mid)
	end

	message_deletable (a_uid, a_mid: INTEGER_64): BOOLEAN
	do
		Result := get_user (a_uid).message_deletable (a_mid)
	end

	appropriate_msg_length (a_message: STRING): BOOLEAN
	do
		Result := a_message.count.is_greater (0)
	end

end
