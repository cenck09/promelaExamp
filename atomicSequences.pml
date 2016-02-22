
/*
Atomic sequences
*/
	byte mutex = 1;

	proctype First()
	{	atomic {
		  (mutex==1) -> printf("First!"); mutex = mutex+1
		}
	}

	proctype Last()
	{	atomic {
		  (mutex==2) -> printf("Last..."); mutex = mutex-1
		}
	}

	init
	{	run Last(); run First()
	}
