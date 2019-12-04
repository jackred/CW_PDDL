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
   (scan_collected ?p - planet)
   (collected ?co - collect_object)
   (carry ?p - people)
   (high_radiation ?p - planet)
   (landed ?e - engine ?p - planet)
   (first_antenna ?p - planet)
   (second_antenna ?p - planet)
   (communicated_result)
   (used ?so - space_object)
   (parked ?e - engine)
   (probe ?e - engine)
   (mav ?e -  engine)
   (lander ?e -  engine)
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
	    (not (no_shield))
	    (not (hungry ?n))
	    (not (hungry ?e))
	    (collected ?p)
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
	    (not (= ?r1 ?r2))
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
	    (not (= ?r1 ?r2)) 
	    )
	   :effect
	   (and
	    (not (location ?p ?r1))
	    (location ?p ?r2)
	    )
	   )
 
  
  (:action eva
	   :parameters
	   (?e1 ?e2 - engineer ?e - engine ?sr - space_region)
	   :precondition
	   (and
	    (not (communicated_result))
	    (location ?e1 launch_bay)
	    (location ?e2 launch_bay)
	    (not (damaged ?e))
	    (not (hungry ?e1))
	    (not (hungry ?e2))
	    (damaged spacecraft)
	    (mav ?e)
	    (forall (?n - nebula) (not(contain ?sr ?n)))
	    (space_location ?sr)
	    )
	   :effect
	   (and
	    (not (damaged spacecraft))
	    )
	   )
  
  (:action collect_plasma_on_nebula
	   :parameters
	   (?e - engine ?en - engineer ?sr - space_region ?n - nebula)
	   :precondition
	   (and
	    (not (communicated_result))
	    (probe ?e)
	    (location ?en launch_bay)
	    (not (hungry ?en))
	    (not (damaged ?e))
	    (not (used ?n))
	    (contain ?sr ?n)
	    (not (asteroids ?sr))
	    (space_location ?sr)
	    )
	   :effect
	   (and
	    (stored_plasma launch_bay)
	    )
	   )

  (:action collect_fuel_on_moon
	   :parameters
	   (?e - engine ?en - engineer ?sr - space_region ?m - moon)
	   :precondition
	   (and
	    (not (communicated_result))
	    (probe ?e)
	    (location ?en launch_bay)
	    (not (hungry ?en))
	    (not (damaged ?e))
	    (not (asteroids ?sr))
	    (not (used ?m))
	    (contain ?sr ?m)
	    (space_location ?sr)
	    )
	   :effect
	   (and
	    (stored_fuel launch_bay)
	    )
	   )
  
  (:action analyse_planet
	   :parameters
	   (?e - engine ?en - engineer ?sr - space_region ?pl - planet)
	   :precondition
	   (and
	    (not (communicated_result))
	    (probe ?e)
	    (location ?en launch_bay)
	    (not (hungry ?en))
	    (not (damaged ?e))
	    (not (asteroids ?sr))
	    (not (used ?pl))
	    (contain ?sr ?pl)
	    (space_location ?sr)
	    )
	   :effect
	   (and
	    (used ?pl)
	    )
	   )

  (:action land_on_planet
	   :parameters
	   (?e - engine ?en - engineer ?sr - space_region ?pl - planet)
	   :precondition
	   (and
	    (not (communicated_result))
	    (lander ?e)
	    (location ?en launch_bay)
	    (not (hungry ?en))
	    (not (damaged ?e))
	    (contain ?sr ?pl)
	    (used ?pl)
	    (space_location ?sr)
	    )
	   :effect
	   (and
	    (landed ?e ?pl)
	    )
	   )

  (:action plant_antenna
	   :parameters
	   (?e - engine ?pl - planet)
	   :precondition
	   (and
	    (not (damaged ?e))
	    (not (communicated_result))
	    (landed ?e ?pl)
	    (lander ?e)
	    )
	   :effect
	   (and
	    (first_antenna ?pl)
	    )
	   )

  (:action plant_antenna
	   :parameters
	   (?e - engine ?pl - planet)
	   :precondition
	   (and
	    (not (damaged ?e))
	    (not (communicated_result))
	    (landed ?e ?pl)
	    (lander ?e)
	    (first_antenna ?pl)
	    (high_radiation ?pl)
	    )
	   :effect
	   (and
	    (second_antenna ?pl)
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
	    (location captain bridge)
	    (not (hungry ?n))
	    (not (hungry captain))
	    (space_location ?sr1)
	    (not (space_location ?sr2))
	    (not (damaged spacecraft))
	    (or
	     (infinite_fuel)
	     (collected ?f)
	     )
	    (not (asteroids ?sr2))
	    )
	   :effect
	   (and
	    (space_location ?sr2)
	    (not (space_location ?sr1))
	    ; (when (and (asteroids ?sr2) (not (shield)) (not (infinite_shield))) (damaged spacecraft))
	    ; (when (and (asteroids ?sr2) (shield) (not (infinite_shield))) (not (shield)))
	    (forall (?x - people) (when (and (not (infinite_food)) (not (hungry ?x))) (hungry ?x)))
	    (not (collected ?f))
	    )
	   )

  
(:action move_to_another_space
	   :parameters
	   (?n - navigator ?sr1 ?sr2 - space_region ?f - fuel)
	   :precondition
	   (and
	    (not (communicated_result))
	    (location ?n bridge)
	    (location captain bridge)
	    (not (hungry ?n))
	    (not (hungry captain))
	    (space_location ?sr1)
	    (not (space_location ?sr2))
	    (not (damaged spacecraft))
	    (or
	     (infinite_fuel)
	     (collected ?f)
	     )
	    (asteroids ?sr2)
	    (or
	     (shield)
	     (infinite_shield))
	    )
	   :effect
	   (and
	    (space_location ?sr2)
	    (not (space_location ?sr1))
	    (not (shield))
	    (forall (?x - people) (when (and (not (infinite_food)) (not (hungry ?x))) (hungry ?x)))
	    (not (collected ?f))
	    )
	   )

(:action move_to_another_space
	   :parameters
	   (?n - navigator ?sr1 ?sr2 - space_region ?f - fuel)
	   :precondition
	   (and
	    (not (communicated_result))
	    (location ?n bridge)
	    (location captain bridge)
	    (not (hungry ?n))
	    (not (hungry captain))
	    (space_location ?sr1)
	    (not (space_location ?sr2))
	    (not (damaged spacecraft))
	    (or
	     (infinite_fuel)
	     (collected ?f)
	     )
	    (asteroids ?sr2)
	    (not (shield))
	    )
	   :effect
	   (and
	    (space_location ?sr2)
	    (not (space_location ?sr1))
	    (damaged spacecraft)
	    (forall (?x - people) (when (and (not (infinite_food)) (not (hungry ?x))) (hungry ?x)))
	    (not (collected ?f))
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
