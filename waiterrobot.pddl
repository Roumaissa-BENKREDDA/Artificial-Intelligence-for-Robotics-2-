;;; DOMAIN FILE ;;;
(define (domain waiterrobot)

	; ****** Specify the requirements for this domain ******
	(:requirements  :typing 		; Use type hierarchies for objects
			:durative-actions 	; Use actions with durations
			:negative-preconditions ; Allow negative preconditions
			:fluents 		; Use fluent predicates
			:duration-inequalities  ; Allow inequalities on durations
	)
	
	; ****** Define the object types used in this domain ******
	(:types
		gripper location order -object	; Objects of type gripper, location, and order are defined
		counter table -location		; define counter and table as subtype of
	)
	
	; ****** Define the predicates ******
	(:predicates
		(order ?drink -order ?location -location) ; the order and its location
		(prepare_order )	; preparing the order
		(free_gripper) 			; gripper is free
		(path ?li ?lf -location) 	; from initial to end position
		(position ?location -location)  	; position of the waiter robot
		(drink ?table -table ?drink -order); the drink and the corresponding table
		(carry_order ?drink -order)	; carry the order
		(to_clean ?table -table)	; need to clean the table
		(cleaning ?table)		; cleaning the table
		(cleaned ?table)		; cleaned process is done
		(tray)			   	; Carrying the tray
		(trayp)				; prepare the tray
		(trayb)				; tray at the bar
		(trayr)				; the tray is ready to be carried
		(trayc)				; carry the tray
	)
	
	; ****** Define functions ******
	(:functions
		(speed_of_robot) 		; speed of the robot
		(drinks_in_tray)		; the number of drinks in the tray
		(to_serve)	; the drinks that are ready to be served
		(distance ?li ?lf -location)	; distance between initial and final position
		(time_to_prepare ?drink -order) ; time needed to prepare the order
		(time_to_clean ?table -table)	; time needed to clean the table
	)
	
	; ---------------- Durative actions ---------------- ;
	
	; ****** Move the robot ******
	(:durative-action move_robot
		:parameters (?li ?lf -location)
		; calculate the duration needed to go from initial to final position
		:duration (= ?duration (/(distance ?li ?lf)(speed_of_robot)))
		:condition (and
			(at start(position ?li)) ; robot at the initial position
			(at start(path ?li ?lf)) ; path from initial and final position
		)
		:effect (and
			(at start (not(position ?li))) ; robot not at the initial position
			(at end (position ?lf))	       ; robot at final position
			(at end (not(position ?li)))
		)
	)
	
	; ****** Prepare the order ******
	(:durative-action prepare-order
		; Parameters for the action
		:parameters (?drink -order ?table -table ?counter -counter)
		; Duration of the action changes from hot to cold drink
		:duration (=?duration (time_to_prepare ?drink))
		; below are preconditions for the action
		:condition (and
			(at start(drink ?table ?drink))
			; Order is not already being prepared
			(at start(not(prepare_order)))
		)
		;below are effects of the action
		:effect(and
			; begin Order preparation 
			(at start(prepare_order))
			(at end(not(prepare_order)))
			(at end(order ?drink ?counter))
			; Increment the number of orders to be served
			; drink is ready to be served 
			(at end (increase (to_serve) 1))
		)
	)


	
	; ****** Clean the table ******
	(:durative-action clean
		:parameters (?table -table)
		:condition(and
			; The robot robot is positioned at the table to be cleaned 
			(at start(position ?table))
			(at start(not(trayc)))
			(at start(not(trayp)))
			(at start(not(trayr)))
			; The gripper is free
			(at start(free_gripper))
			; The table is marked it should be cleaned noww
			(at start(to_clean ?table))
		)
		;below are effects of the action
		:effect (and
			; The table is no longer marked to be cleaned
			(at start(not(to_clean ?table)))
			; The table is cleaned
			(at end(cleaned ?table))
			(at end(not(to_clean ?table)))
		)
	)
	
	
	; ---------------- Simple actions ---------------- ;
	; NO DURATIVE ACTIONS
			
	; ****** Take drink ******
	(:action take-drink
		; Parameters for the action
		:parameters (?drink -order ?counter -counter)
		;below are preconditions for the action
		:precondition (and
			(trayb)
			(not (trayc))
			(not (trayp))
			; The robot is positioned at the counter to be able to take the drink
			(position ?counter)
			(< (drinks_in_tray) 1) 
			; The gripper is free
			(free_gripper)
			; There are drink/s the be served 
			(> (to_serve) 0)
			(order ?drink ?counter)
			; note rrobot can carry only one drink with its gripers 
			(< (to_serve) 2)
			; the robot is not carrying anything
			(not (carry_order ?drink))
		)
		; below are effects of the action
		:effect (and
			; The drink no more at the counter
			(not (order ?drink ?counter))
			; speed 2 because robot is using tray
			(assign (speed_of_robot) 2)
			(not (free_gripper))
			; The robot is carrying the drink
			(carry_order ?drink)
			(decrease (to_serve) 1)
		)
	)




	
	; ****** Serve the order ******
	; This action serves an order to a specific table
		
    	(:action serve-order
        	:parameters (?drink - order ?table - table)
        	:precondition (and
			; tray not busy
        		(not (trayc))
			; robots grippers are free
        		(not (free_gripper))
        		(drink ?table ?drink)
			 ; The robot is positioned at the table to serve the order
        		(position ?table)
			; the robot is holding the drinks
        		(carry_order ?drink)
        	)
        	:effect (and
			 ; The robot's gripper is free after serving the order
        		(free_gripper)
			; order is marked served at set table 
        		(order ?drink ?table)
			; not carrying order anymore
        		(not (carry_order ?drink))         		
        	)
	)





	
	; ****** take_last_order ******
	(:action take_last_order
        	:parameters (?drink - order ?counter - counter)
        	:precondition (and 
			;tray not busy
        		(not (trayc))
			; Robot is positioned at counter
        		(position ?counter)
        		(order ?drink ?counter)
        		(trayb)
        		(trayp)
			; robots grippers are free
        		(free_gripper)
			; there are drinks to serve!!
            		(> (to_serve) 0)
            		(not (carry_order ?drink))
			; tray can carry up to 3 drinks 
            		(< (drinks_in_tray) 3)
        	)
        	:effect (and
        		(trayr)
        		(not (order ?drink ?counter))
			; decrease # of drinks to serve
        		(decrease (to_serve) 1)
			; increase # of drinks on tray
        		(increase (drinks_in_tray) 1)
        		(carry_order ?drink)
        		(not (trayp))
			; robtos grippers are free 
            		(free_gripper)
        	)
	)
	


	
	; ****** Prepare tray ******
	; note speed of robot decreases when he is using the tray
	(:action prepare-tray
        	:parameters (?drink - order ?counter -counter)
        	:precondition (and 
			; The robot is at the counter
        		(position ?counter)
        		(order ?drink ?counter)
			; robots grippers are free
        		(free_gripper)
			; there are drink/s to be served!!
        		(> (to_serve) 1)
			; the order is not carried yet 
            		(not (carry_order ?drink))
			; less than 3 drinks on tray max capacity 3
            		(< (drinks_in_tray) 3)
            		(trayb)
            		(not (trayc))
        	)
        	:effect (and
			; robot carries order 
        		(carry_order ?drink)
			; order no more on counter 
        		(not (order ?drink ?counter))
			; decrease # of drinks to serve
        		(decrease (to_serve) 1)
			; increase # of drinks on tray
        		(increase (drinks_in_tray) 1)
        		(trayp)
		)  
	)	






    	
	; ****** Serve tray order ******
	(:action serve-tray-order
        	:parameters (?drink - order ?table - table)
        	:precondition (and 
			; robots grippers must be not free
        		(not (free_gripper))
			; at least 1 drink on tray
        		(> (drinks_in_tray) 0)
			; robto carrying order
        		(carry_order ?drink)
        		(not (trayb))
			; robot at the table 
        		(position ?table)
			; drink at the respective table 
        		(drink ?table ?drink)
            		(trayc)
        	)
        	:effect (and
			; robots grippers not free yet 
        		(not (free_gripper))
        		(order ?drink ?table)
            		(decrease (drinks_in_tray) 1)
            		(not (carry_order ?drink))
            	)
	)



	
	; ****** Take tray ******
	(:action take-tray
        	:parameters (?counter - counter)
        	:precondition (and
			; robots grippers must be free
        		(free_gripper)
			; robot at counter 
        		(position ?counter)
        		(not(trayp))
        		(trayr)
        		(trayb)	
        	)
        	:effect (and 
        		(not (trayb))
        		(not (trayp))
			; robot carry tray
        		(not (free_gripper))
        		(not (trayr))
			; speed of robot is now 1 because he is carrying the tray
        		(assign (speed_of_robot) 1)
        		(trayc)
        	)
    	) 
	





	; ****** Serve tray ******
	(:action serve-tray
        	:parameters (?counter - counter)
        	:precondition (and
        		(trayc)
			; robots grippers are busy
        		(not (free_gripper))	
        		(position ?counter)
			; less than 1 drink on tray 
        		(< (drinks_in_tray) 1)
        	)
        	:effect (and
			; robot not using tray
        		(not (trayc))
			; robot speed 2 because he is NOT carrying the tray
        		(assign (speed_of_robot) 2)
        		(trayb)
			; robots grippers arr free
            		(free_gripper)
            	)
    	)	
	
)		
