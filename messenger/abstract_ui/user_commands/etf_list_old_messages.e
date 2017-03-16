note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_LIST_OLD_MESSAGES
inherit
	ETF_LIST_OLD_MESSAGES_INTERFACE
		redefine list_old_messages end
create
	make
feature -- command
	list_old_messages(uid: INTEGER_64)
		require else
			list_old_messages_precond(uid)
    	do
			if not model.is_positive_num (uid) then
				model.set_error_flag (0)
			elseif not model.user_exists (uid) then
				model.set_error_flag (4)
			else
				model.list_old_messages (uid)
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
