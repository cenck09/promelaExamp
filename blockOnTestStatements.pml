
/*
Blocking on test statements
*/
	byte mutex = 0;
	
	proctype shouldBlock()
	{		
		printf("ShouldBlock should block on (mutex==1) until shouldRun finishes");
		(mutex == 1)
		printf("ShouldBlock ran");
	}
	
	proctype shouldRun(){
		printf("ShouldRun ran");
		mutex = 1;
	}
	
	init {
		run shouldBlock(); run shouldRun()
	}
