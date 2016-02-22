/*
Proctype is a process
*/
	proctype print(byte selection)
	{	
		if
		::	(selection == 1) -> printf("Hello ");
		::	(selection == 2) -> printf("World! \n");
		fi
	}

	init {
		run print(1);
		run print(2);
	}
