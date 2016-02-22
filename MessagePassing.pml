/*
Message Passing

	Here is an example where one process places a message in a mailbox,
	while the other reads those messages, if none are there it blocks
*/
	
	proctype senderProcess(chan mailBox){
		
		mailBox!0;
		mailBox!1;
		mailBox!2;
		mailBox!3;
		mailBox!4;
	}

	proctype receiverProcess(chan mailBox){
		int message = -1;
		
		do /* Blocks and waits for message if empty*/
		:: mailBox?message ->
			if
			::	(message == 0) -> printf("This");
			::	(message == 1) -> printf("is");
			::	(message == 2) -> printf("just");
			::	(message == 3) -> printf("a");
			::	(message == 4) -> printf("Test");
			fi
		:: (message == 4) -> break
		od
	
	}

	init {
		/* A channel that can hold 4 integer messages at a time*/
		chan mailBox = [4] of { int };
		run receiverProcess(mailBox); run senderProcess(mailBox)
	}
