note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_DELETE_MESSAGE
inherit
	ETF_DELETE_MESSAGE_INTERFACE
		redefine delete_message end
create
	make
feature -- command
	delete_message(uid: INTEGER_64 ; mid: INTEGER_64)
		require else
			delete_message_precond(uid, mid)
    	do
			if not model.is_positive_num (uid) or not model.is_positive_num (mid) then
				model.set_error_flag (0)
			elseif not model.user_exists (uid) then
				model.set_error_flag (4)
			elseif not model.message_exists (mid) then
				model.set_error_flag (9)
			elseif not model.message_deletable (uid, mid) then
				model.set_error_flag (12)
			else
				model.delete_message (uid, mid)
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
