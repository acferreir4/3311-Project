note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_REGISTER_USER
inherit
	ETF_REGISTER_USER_INTERFACE
		redefine register_user end
create
	make
feature -- command
	register_user(uid: INTEGER_64 ; gid: INTEGER_64)
		require else
			register_user_precond(uid, gid)
    	do
			if not model.is_positive_num (uid) or not model.is_positive_num (gid) then
				model.set_error_flag (0)
			elseif not model.user_exists (uid) then
				model.set_error_flag (4)
			elseif not model.group_exists (gid) then
				model.set_error_flag (5)
			elseif model.user_is_member (uid, gid) then
				model.set_error_flag (6)
			else
				model.register_user (uid, gid)
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
