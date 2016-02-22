/*
 	Channel operations

	Here is an example of the predefined operations for the channels
	
	~ len  - a function that takes a channel and gives the number of messages it holds
	~ full - Tests if it's full
	~ nfull - Tests if it's Not full
	~ empty - Tests if it's empty
	~ nEmpty - Tests if it's not empty
*/

	int totalCount = 10; /* process 100 messages */
	
	proctype senderProcess(chan mailBox){	
		
		int message = 0;
		
		do
		::	empty(mailBox) -> /* When the mailBox is empty, fill it up*/
		atomic
			{
				do
				:: nfull(mailBox) -> mailBox!message
				:: full(mailBox) -> break
				od
			}
		:: (totalCount == 0) -> break
		od
		
	}

	proctype receiverProcess(chan mailBox){
		int message = -1;
		
		do /* Blocks and waits for message if empty*/
		:: full(mailBox) -> 
		atomic
			{
				do
				:: mailBox?message -> totalCount--
					if
					::	(len(mailBox) == 4) -> printf("This");
					::	(len(mailBox) == 3) -> printf("is");
					::	(len(mailBox) == 2) -> printf("just");
					::	(len(mailBox) == 1) -> printf("a");
					::	(len(mailBox) == 0) -> printf("Test");
					fi
				:: empty(mailBox) -> break
				od
			}
		:: (totalCount == 0) -> break
		od
	
	}

	init {
		/* A channel that can hold 4 integer messages at a time*/
		chan mailBox = [5] of { int };
		run receiverProcess(mailBox); run senderProcess(mailBox)
	}
