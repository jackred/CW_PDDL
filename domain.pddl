; -*- Mode: PDDL; tab-width: 2
; vim:set et sts=4 ts=4 tw=80:
; This Source Code Form is subject to the terms of the MIT License.
; If a copy of the ML was not distributed with this
; file, You can obtain one at https://opensource.org/licenses/MIT

; author: JackRed <jackred@tuta.io>

(define (domain spacecraft)
  (:requirements
   :strips :equality
   )
  (:types
   habilitated navigator gunner science_officer - people
   engineer - habilitated
   planet nebula moon - space_object
   plasma fuel - collect_object
   people
   room
   collect_object
   planet
   space_region
   space_object
   engine
   )
  (:constants 
   bridge kitchen science_lab launch_bay - room
   captain - habilitated
   spacecraft - engine
   solar_system - space_region
   df - fuel
   )
  
  (:predicates
   (location ?p - people ?r - room)
   (path ?r1 ?r2 - room)
   (teleporter ?r1 ?r2 - room)
   (space_location ?sr - space_region)
   (damaged ?x - engine)
   (asteroids ?sr - space_region)
   (contain ?sr - space_region ?so - space_object)
   (hungry ?p - people)
   (stored_plasma ?r - room)
   (stored_fuel ?r - room)
   (scanned ?p - planet)
   (scan_collected ?p - planet)
   (collected ?co - collect_object)
   (carry ?p - people)
   (high_radiation ?p - planet)
   (landed ?e - engine ?p - planet)
   (first_antenna ?p - planet)
   (second_antenna ?p - planet)
   (communicated_result)
   (ordered ?sr - space_region)
   (order)
   (used ?so - space_object)
   (has_plasma ?e - engine)
   (has_fuel ?e - engine)
   (has_scan ?e - engine ?pl - planet)
   (deployed ?sr - space_region ?e -  engine)
   (parked ?e - engine)
   (probe ?e - engine)
   (mav ?e -  engine)
   (lander ?e -  engine)
   (in_mav ?en - engineer)
   (shield)
   (infinite_food)
   (infinite_fuel)
   (infinite_shield)
   (no_canon)
   (no_shield)
   )


  (:action shoot_asteroids
	   :parameters
	   (?g - gunner ?p - plasma ?sr - space_region)
	   :precondition
	   (and
	    (not (communicated_result))
            (location ?g bridge)
	    (not (hungry ?g))
	    (space_location ?sr)
	    (asteroids ?sr)
	    (collected ?p)
	    (not (no_canon))
	    )
	   :effect
	   (and
	    (not (collected ?p))
	    (not (asteroids ?sr))
	    )
	   )
  
  (:action activate_shield
	   :parameters
	   (?n - navigator ?e - engineer ?p - plasma)
	   :precondition
	   (and
	    (not (communicated_result))
            (location ?n bridge)
	    (location ?e bridge)
	    (not (shield))
	    (not (hungry ?n))
	    (not (hungry ?e))
	    (collected ?p)
	    (not (no_shield))
	    )
	   :effect
	   (and
	    (shield)
	    (not (collected ?p))
	    )
	   )
  
  (:action move_room
	   :parameters
	   (?p - people ?r1 ?r2 - room)
	   :precondition
	   (and
	    (not (communicated_result))
            (location ?p ?r1)
            (path ?r1 ?r2)
            (not (= ?r1 ?r2)) ; useless cause no path between the same room
	    )
	   :effect
	   (and
            (not (location ?p ?r1))
            (location ?p ?r2)
	    )
	   )

  (:action eat
	   :parameters
	   (?p - people)
	   :precondition
	   (and
	    (not (communicated_result))
            (location ?p kitchen)
            (hungry ?p)
	    )
	   :effect
	   (and
            (not (hungry ?p))
	    )
	   )

  (:action add_fuel
	   :parameters
	   (?e - engineer ?f - fuel)
	   :precondition
	   (and
	    (not (communicated_result))
            (location ?e launch_bay)
            (not (hungry ?e))
	    (stored_fuel launch_bay)
	    (not (collected ?f))
	    )
	   :effect
	   (and
	    (not (stored_fuel launch_bay))
	    (collected ?f)
	    )
	   )
  
  (:action carry_plasma
	   :parameters
	   (?so - science_officer)
	   :precondition
	   (and
	    (not (communicated_result))
            (stored_plasma launch_bay)
            (location ?so launch_bay)
            (not (hungry ?so))
	    )
	   :effect
	   (and
            (carry ?so)
            (not (stored_plasma launch_bay))
	    )
	   )

  (:action analyse_plasma
	   :parameters
	   (?so - science_officer ?p - plasma)
	   :precondition
	   (and
	    (not (communicated_result))
            (carry ?so)
            (location ?so science_lab)
            (not (hungry ?so))
            (not (collected ?p))
	    )
	   :effect
	   (and
            (collected ?p)
            (not (carry ?so))
	    )
	   )



  (:action teleport
	   :parameters
	   (?p - habilitated ?r1 ?r2 - room)
	   :precondition
	   (and
	    (not (communicated_result))
            (location ?p ?r1)
            (teleporter ?r1 ?r2)
            (not (= ?r1 ?r2)) ; useless cause no teleporter between the same room
	    )
	   :effect
	   (and
            (not (location ?p ?r1))
            (location ?p ?r2)
	    )
	   )


  (:action deploy_vehicle
	   :parameters
	   (?e -  engine ?en - engineer ?sr - space_region)
	   :precondition
	   (and
	    (not (communicated_result))
	    (parked ?e)
            (not (damaged ?e))
            (not (hungry ?en))
            (location ?en launch_bay)
            (space_location ?sr)
	    )
	   :effect
	   (and
            (when (and (asteroids ?sr) (probe ?e)) (damaged ?e))
	    (forall (?n - nebula) (when (and (contain ?sr ?n) (mav ?e)) (damaged ?e)))
	    (deployed ?sr ?e)
	    (not (parked ?e))
	    )
	   )

  (:action retrieve_vehicle
	   :parameters
	   (?e -  engine ?e1 - engineer ?sr - space_region)
	   :precondition
	   (and
	    (not (communicated_result))
            (not (damaged ?e))
            (not (hungry ?e1))
            (location ?e1 launch_bay)
            (space_location ?sr)
	    (deployed ?sr ?e)
	    (not (parked ?e))
	    )
	   :effect
	   (and
	    (not (deployed ?sr ?e))
	    (parked ?e)
	    (when (and (has_plasma ?e) (probe ?e)) (and (stored_plasma launch_bay) (not (has_plasma ?e))))
	    (when (and (has_fuel ?e) (probe ?e)) (and (stored_fuel launch_bay) (not (has_fuel ?e))))
	    (forall (?pl - planet)
		    (when (and (has_scan ?e ?pl) (probe ?e)) (used ?pl))
		    )
	    )
	   )

  (:action get_in_mav
	   :parameters
	   (?en - engineer ?e - engine)
	   :precondition
	   (and
	    (not (communicated_result))
            (location ?en launch_bay)
	    (parked ?e)
            (not (in_mav ?en))
            (not (damaged ?e))
            (not (hungry ?en))
	    )
	   :effect
	   (and
	    (not (location ?en launch_bay))
	    (in_mav ?en)
	    )
	   )
  
  (:action get_out_mav
	   :parameters
	   (?en - engineer ?e - engine)
	   :precondition
	   (and
	    (not (communicated_result))
            (in_mav ?en)
	    (parked ?e)
	    )
	   :effect
	   (and
	    (location ?en launch_bay)
	    (not (in_mav ?en))
	    )
	   )
  
  (:action eva
	   :parameters
	   (?e1 ?e2 - engineer ?e - engine ?sr - space_region)
	   :precondition
	   (and
	    (not (communicated_result))
            (location ?e1 launch_bay)
            (in_mav ?e2)
	    (deployed ?sr ?e)
            (not (damaged ?e))
            (not (hungry ?e1))
            (not (hungry ?e2))
            (damaged spacecraft)
            (space_location ?sr)
	    )
	   :effect
	   (and
            (not (damaged spacecraft))
	    )
	   )
  
  (:action collect_plasma_on_nebula
	   :parameters
	   (?e - engine ?sr - space_region ?n - nebula)
	   :precondition
	   (and
	    (not (communicated_result))
	    (probe ?e)
	    (deployed ?sr ?e)
            (not (damaged ?e))
            (not (used ?n))
            (contain ?sr ?n)
	    )
	   :effect
	   (and
            (used ?n)
	    (has_plasma ?e)
	    )
	   )

  (:action collect_fuel_on_moon
	   :parameters
	   (?e - engine ?sr - space_region ?m - moon)
	   :precondition
	   (and
	    (not (communicated_result))
	    (probe ?e)
	    (deployed ?sr ?e)
            (not (damaged ?e))
            (not (used ?m))
            (contain ?sr ?m)
	    )
	   :effect
	   (and
            (used ?m)
	    (has_fuel ?e)
	    )
	   )
  
  (:action analyse_planet
	   :parameters
	   (?e - engine ?sr - space_region ?pl - planet)
	   :precondition
	   (and
	    (not (communicated_result))
	    (probe ?e)
	    (deployed ?sr ?e)
            (not (damaged ?e))
	    (not (used ?pl))
            (contain ?sr ?pl)
	    )
	   :effect
	   (and
	    (has_scan ?e ?pl)
	    )
	   )

  (:action land_on_planet
	   :parameters
	   (?e - engine ?sr - space_region ?pl - planet)
	   :precondition
	   (and
	    (not (communicated_result))
	    (lander ?e)
	    (deployed ?sr ?e)
            (not (damaged ?e)) 
            (contain ?sr ?pl)
	    )
	   :effect
	   (and
            (when (not(used ?pl)) (damaged ?e)) 
            (when (used ?pl) (landed ?e ?pl))
	    (not (deployed ?sr ?e))
	    )
	   )

  (:action plant_antenna
	   :parameters
	   (?e - engine ?pl - planet)
	   :precondition
	   (and
	    (not (communicated_result))
	    (not (damaged ?e))
	    (landed ?e ?pl)
	    (or
	     (not (first_antenna ?pl))
	     (and
	      (first_antenna ?pl)
	      (high_radiation ?pl)
	      (not (second_antenna ?pl))
	      )
	     )
	    )
	   :effect
	   (and
	    (when (first_antenna ?pl) (second_antenna ?pl))
	    (when (not (first_antenna ?pl)) (first_antenna ?pl))
	    )
	   )


  (:action scan_planet
	   :parameters
	   (?e - engine ?pl - planet)
	   :precondition
	   (and
	    (not (communicated_result))
	    (not (damaged ?e))
	    (landed ?e ?pl)
	    (not (scanned ?pl))
	    )
	   :effect
	   (and
	    (scanned ?pl)
	    )
	   )

  (:action collect_scan
	   :parameters
	   (?e - engine ?sr - space_region ?pl - planet)
	   :precondition
	   (and
	    (not (communicated_result))
	    (not (damaged ?e))
	    (landed ?e ?pl)
	    (scanned ?pl)
	    (space_location ?sr)
	    (contain ?sr ?pl)
	    (first_antenna ?pl)
	    (or
	     (and
	      (high_radiation ?pl) ; is there a better way than yes or no
	      (second_antenna ?pl)
	      )
	     (not (high_radiation ?pl))
	     )
	    )
	   :effect
	   (and
            (scan_collected ?pl)
	    )
	   )


  (:action move_to_another_space
	   :parameters
	   (?n - navigator ?sr1 ?sr2 - space_region ?f - fuel)
	   :precondition
	   (and
	    (not (communicated_result))
            (location ?n bridge)
            (not (hungry ?n))
            (space_location ?sr1)
            (not (space_location ?sr2))
	    (ordered ?sr2)
	    (not (damaged spacecraft))
	    (or
	     (infinite_fuel)
	     (collected ?f)
	     )
	    )
	   :effect
	   (and
	    (not (ordered ?sr2))
	    (not (order))
	    (space_location ?sr2)
	    (not (space_location ?sr1))
	    (when (and (asteroids ?sr2) (not (shield)) (not (infinite_shield))) (damaged spacecraft))
	    (when (and (asteroids ?sr2) (shield) (not (infinite_shield))) (not (shield)))
	    (forall (?x - people) (when (and (not (infinite_food)) (not (hungry ?x))) (hungry ?x)))
	    (when (not (infinite_fuel)) (not (collected ?f)))
	    )
	   )



  (:action order_to_move_to_another_space
	   :parameters
	   (?n - navigator ?sr - space_region)
	   :precondition
	   (and
	    (not (communicated_result))
            (location captain bridge)
	    (not (order))
	    (location ?n bridge)
            (not (hungry ?n))
            (not (hungry captain))
            (not (space_location ?sr))
	    )
	   :effect
	   (and
	    (ordered ?sr)
	    (order)
	    )
	   )


  (:action communicate_result
	   :parameters
	   (?na - navigator)
	   :precondition
	   (and
            (location ?na bridge)
            (not (hungry ?na))
            (space_location solar_system)
	    )
	   :effect
	   (and
	    (communicated_result)
	    )
	   )

  )
