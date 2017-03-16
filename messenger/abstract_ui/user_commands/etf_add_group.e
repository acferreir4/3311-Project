note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ADD_GROUP
inherit
	ETF_ADD_GROUP_INTERFACE
		redefine add_group end
create
	make
feature -- command
	add_group(gid: INTEGER_64 ; group_name: STRING)
		require else
			add_group_precond(gid, group_name)
    	do
    		if not model.is_positive_num (gid) then
				model.set_error_flag (0)
			elseif not model.is_unused_gid (gid) then
				model.set_error_flag (1)
			elseif not model.is_valid_name (group_name) then
				model.set_error_flag (3)
			else
				model.add_group (gid, group_name)
    		end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
