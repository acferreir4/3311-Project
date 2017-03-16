note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_SEND_MESSAGE
inherit
	ETF_SEND_MESSAGE_INTERFACE
		redefine send_message end
create
	make
feature -- command
	send_message(uid: INTEGER_64 ; gid: INTEGER_64 ; txt: STRING)
		require else
			send_message_precond(uid, gid, txt)
    	do
			if not model.is_positive_num (uid) or not model.is_positive_num (gid) then
				model.set_error_flag (0)
			elseif not model.user_exists (uid) then
				model.set_error_flag (4)
			elseif not model.group_exists (gid) then
				model.set_error_flag (5)
			elseif not model.appropriate_msg_length (txt) then
				model.set_error_flag (7)
			elseif not model.user_authorized_send (uid, gid) then
				model.set_error_flag (8)
			else
				model.send_message (uid, gid, txt)
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
