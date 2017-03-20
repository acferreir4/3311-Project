hi dan
# 3311-Project

A simple messaging program. Current planning is in the docs/ folder.

TODO:

	Finish printing queries and sorting
		- Sort either before printing or after every entry
		- Normally print by sorted user_id
		- List commands print sorted by user_name

	Acceptance Tests (To be done later)

Notes:

	Originally there was an OUTPUT class
		- Handled errors and general printing
		- Received information to print from MESSENGER
		- Running from CL gave void safety exceptions
			- get_user_list
			- get_group_list
			- get_message_list
		- Running from GUI didn't give exceptions
			- Thus, likely an ETF problem
