note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ADD_USER
inherit
	ETF_ADD_USER_INTERFACE
		redefine add_user end
create
	make
feature -- command
	add_user(uid: INTEGER_64 ; user_name: STRING)
		require else
			add_user_precond(uid, user_name)
    	do
			if not model.is_positive_num (uid) then
				model.set_error_flag (0)
			elseif not model.is_unused_uid (uid) then
				model.set_error_flag (1)
			elseif not model.is_valid_name (user_name) then
				model.set_error_flag (2)
			else
				model.add_user (uid, user_name)
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
