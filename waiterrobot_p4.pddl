(define (problem waiterrobot_p4)
	(:domain waiterrobot)
	(:objects
		t1 t2 t3 t4 - table
		counter - counter
		c1 c2 c3 c4 w1 w2 w3 w4 - order
		; for this problem there are 8 drinks 
	)
	(:init

		; initialization 
		; tray is not carrying any drink 
		; robot is at counter to start off 
		; robot is idle 
		; thre grippers of the robot are free
		; tray is free 
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
		; 4 COLD DRINKS AND 4 HOT DRINKS FOR CLIENTS 
		(= (time_to_prepare c1) 3)
		(= (time_to_prepare c2) 3)
		(= (time_to_prepare c3) 3)
		(= (time_to_prepare c4) 3)
		(= (time_to_prepare w1) 5)
		(= (time_to_prepare w2) 5)
		(= (time_to_prepare w3) 5)
		(= (time_to_prepare w4) 5)
		; how fast robot can move 
		(= (speed_of_robot) 2)
		



		
		; respective time to clean each of the tables from 1 to 4 
		(= (time_to_clean t1) 2)
		(= (time_to_clean t2) 2)
		(= (time_to_clean t3) 4)
		(= (time_to_clean t4) 2)

		; --------- Assignment of drinks for each table --------- ;
		; 4 COLD DRINKS AND 4 HOT DRINKS FOR CLIENTS
		; WHO ASKED WHAT 
		;drink 1 and drink 2 are by asked in table 1
		;drink 3 and drink 4 are by asked in table 4
		;drink 5 and drink 6 are by asked in table 3
		;drink 7 and drink 8 are by asked in table 3

		(drink t1 c1)
		(drink t1 c2)
		(drink t4 c3)
		(drink t4 c4)
		(drink t3 w1)
		(drink t3 w2)
		(drink t3 w3)
		(drink t3 w4)


		; --------- Tables that need to be cleaned --------- ;
		; tables 4 should be cleaned. 
		(to_clean t4)

		
		
		

		

		
	)
	;OBJECTIVE >> 4 cold drinks and 4 hot drinks served and table 4 cleaned. 
	(:goal
		(and
		    (order c1 t1)
		    (order c2 t1)
		    (order c3 t4)
		    (order c4 t4)
		    (order w1 t3)
		    (order w2 t3)
		    (order w3 t3)
		    (order w4 t3)

		    (cleaned t4)
		)
	)

	(:metric minimize
		(total-time)
	)
)
