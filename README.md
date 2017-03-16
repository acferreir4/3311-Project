# 3311-Project

A simple messaging program. Current planning is in the docs/ folder.

TODO:
	Connect Control to Model

	Change ARRAYED_LIST for user_list and group_list back to HASH_TABLE
		- For printing purposes

	Move almost all printing from OUTPUT to MESSENGER
		- CL runs give void safety exceptions when passing the lists
			- get_user_list
			- get_group_list
			- get_message_list
		- GUI doesn't for some reason, likely an ETF problem
		- Issue occurs during printing after "add_user" or "add_group"
			- Basically, during "print_default_state"

	Refactor OUTPUT to ERROR_HANDLER
	
	Acceptance Tests (To be done later)
