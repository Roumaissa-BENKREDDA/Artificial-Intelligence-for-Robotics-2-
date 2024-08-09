(define (problem waiterrobot_p2)
	(:domain waiterrobot)
	(:objects
		c1 c2 w1 w2 - order
		; for this problem there are 4 drinks
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
		; 2 COLD DRINKS AND 2 HOT DRINKS FOR CLIENTS
		(= (time_to_prepare c1) 3)
		(= (time_to_prepare c2) 3)
		(= (time_to_prepare w1) 5)
		(= (time_to_prepare w2) 5)
		; how fast robot can move 
		(= (speed_of_robot) 2)

		

		; respective time to clean each of the tables from 1 to 4 
		(= (time_to_clean t1) 2)
		(= (time_to_clean t2) 2)
		(= (time_to_clean t3) 4)
		(= (time_to_clean t4) 2)
	

		; --------- Assignment of drinks for each table --------- ;
		; 2 COLD DRINKS AND 2 HOT DRINKS FOR CLIENTS
		; WHO ASKED WHAT 
		;drink 1 and drink 2, drink 3 and drink 4 are by asked in table 3
		(drink t3 c1)
		(drink t3 c2)
		(drink t3 w1)
		(drink t3 w2)


		; --------- Tables that need to be cleaned --------- ;
		; table 1 should be cleaned. 
		(to_clean t1)

		


	)

	;OBJECTIVE >> 2 cold drinks and 2 hot drinks served and tables 1 cleaned. 
	(:goal
		(and

		    (cleaned t1)
		    (order w1 t3)
		    (order w2 t3)
		    (order c1 t3)
		    (order c2 t3)

		    
		)
	)

	(:metric minimize
		(total-time)
	)
)
