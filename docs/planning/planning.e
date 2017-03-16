System:

	Set of USERs:
		HASH[USER]:
				user_id:		INTEGER_64
				user_name:		STRING
				user_messages:		ARRAY[TUPLE [MESSAGE_ID, STATUS]]

	Set of GROUPs:
		HASH[GROUP]:
				group_id:		INTEGER_64
				group_name:		STRING
				group_members:		ARRAY[USER_ID]
				
	Sort HASH[USER] and HASH[GROUP] by name (alphabetically)       <- OUTSOURCE TO OUTPUT CLASS
	
	Set of MESSAGEs:
		HASH[MESSAGE]:
				message_sender:		INTEGER_64
				message_group:		INTEGER_64
				message_content:	STRING
				
CLASSES REQUIRED:

	MESSENGER
		- Handles changes to the model
		- Stores USERs, GROUPs
		- Sends calls to the OUTPUT
	USER
		- Template for every user created
	GROUP
		- Template for every group created
	OUTPUT
		- Creates output for every change or call to MESSENGER
			- Errors
			- "list_" calls
			- Generic "ok" messages after a change to MESSENGER
		- Thus, OUTPUT must be able to get system data from MESSENGER
			- Done through protected "get_"{OUTPUT} queries
	MESSAGE
		- Template for every message created
	
	

Observations:

	Users can belong to multiple groups
		- Either store user list in a group, or group list in a user
		- Probably more secure to store a user list in a group
		
	Groups and users cannot be deleted
	
	Only messages can be deleted
		- Deletion changes user status from read/unread => unavailable
		- Message stays intact
		
	Messages are stored in the MESSENGER in a hash
		- Users have a hash mapping message_id -> status
			- "status" refers to: read, unread, unavailable
			
	MESSENGER calls to OUTPUT should be simple
		- However, OUTPUT needs information about attributes in MESSENGER
		- Thus, we can either have:
			- OUTPUT having a local messenger access
				- Requires a new local variable for almost every printing query
			- MODEL directly exports information to OUTPUT in every print call
				- Makes print in MODEL more complex
			

