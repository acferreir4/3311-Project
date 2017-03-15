note
	description: "Summary description for {USER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	USER

create
	make

feature {NONE} -- Initialization

	make (a_user_name: STRING; a_user_id: INTEGER_64)
			-- Initialization for `Current'.
		do
				user_name := a_user_name
				user_id := a_User_id
		end

feature {USER} -- Features

	user_name: STRING
	user_id: INTEGER_64

feature

	print_message: STRING
	do
		create Result.make_empty
	end
end
