note
	description: "Summary description for {OUTPUT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OUTPUT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		local
			model_access : MESSENGER_ACCESS
		do
			model := model_access.m
		end

feature
	model: MESSENGER
end
