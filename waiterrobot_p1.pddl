(define (problem waiterrobot_p1)
	(:domain waiterrobot)
	(:objects
		c1 c2 - order
		; for this problem there are only 2 drinks 
		drink1 drink2 - drink
		t1 t2 t3 t4 - table
		counter - counter       
	)

	(:init

	; initialization 
		; tray is not carrying any drink 
		; robot is idle 
		; thre grippers of the robot are free
		; the barista is free 

	(trayb)

			(path t1 t3)
	(path t3 t2)
	(path t1 t4)    (path t4 t2)
	
	(path t2 t3)     (path t2 t4)
	
	(path t4 t1) 	(path t4 t3)
	(path t1 t2)	(path t1 counter)
	(path t3 t1)	(path t4 t1)
	(path counter t2) (path counter t1)
	(path counter t2) (path t2 counter)
	
	(position counter)
	

	(free_gripper)


	; --------- distances --------- ;
	; DEFINE LAYOUT 
	; this is unchanged between the problems 
	; the distance between the tables is defined and given in the assignment 

		(= (distance counter t1) 2)
		(= (distance t1 counter) 2)
		(= (distance counter t2) 2)
		(= (distance t2 counter) 2)
		(= (distance t1 t2) 1)
		(= (distance t2 t1) 1)
		(= (distance t1 t3) 1)
		(= (distance t3 t1) 1)
		(= (distance t1 t4) 1)
		(= (distance t4 t1) 1)
		(= (distance t2 t4) 1)
		(= (distance t4 t2) 1)
		(= (distance t2 t3) 1)
		(= (distance t3 t2) 1)
		(= (distance t3 t4) 1)
		(= (distance t4 t3) 1)

		; tray is free 
		(= (drinks_in_tray) 0)
		(= (to_serve) 0)
		; cold drinks takes 3 unit times to prepare 
		; hot drinks take 5 unit times to prepare 
		; client asked 2 cold drinks 
		(= (time_to_prepare c1) 3)
		(= (time_to_prepare c2) 3)
		; how fast robot can move 
		(= (speed_of_robot) 2)

		; respective time to clean each of the tables from 1 to 4 
		(= (time_to_clean t1) 2)
		(= (time_to_clean t2) 2)
		(= (time_to_clean t3) 4)
		(= (time_to_clean t4) 2)
	
	
		; --------- Assignment of drinks for each table --------- ;
		; 2 COLD DRINKS FOR CLIENT 

		(drink t2 c1)
		(drink t2 c2)
		
		; --------- Tables that need to be cleaned --------- ;
		; tables 3 and 4 should be cleaned. 

		(to_clean t3)
		(to_clean t4)
		
	)
	;OBJECTIVE >> 2 cold drinks served and tables 3 and 4 cleaned.
	(:goal
		(and
		    (order c1 t2)
		    (order c2 t2)

		    (cleaned t3)
		    (cleaned t4)
		)
	)

	(:metric minimize
		(total-time)
	)
)
