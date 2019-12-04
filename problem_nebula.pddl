; -*- Mode: PDDL; tab-width: 2
; vim:set et sts=4 ts=4 tw=80:
; This Source Code Form is subject to the terms of the MIT License.
; If a copy of the ML was not distributed with this
; file, You can obtain one at https://opensource.org/licenses/MIT

; author: JackRed <jackred@tuta.io>

(define (problem problem1)
  (:domain spacecraft)

  (:objects
      dorm1 dorm2 restroom1 hub - room
      e1 e2 e3 e4 - engineer
      na1 na2 - navigator
      sc1 sc2 - science_officer
      alpha_centauri lich helvetios kepler64b - space_region
      earth mars draugr dimidium proxima_centauri_b ph1 - planet
      n1 n2 n3 n4 n5 n6 - nebula
      p1 p2 p3 p4 mv1 l1 l2 l3 - engine
      pla1 pla2 pla3 pla4 pla5 - plasma
  )

  (:init

   (no_shield)
   (no_canon)
   (infinite_food)
   (infinite_fuel)
   
   (parked p1)
   (parked p2)
   (parked p3)
   (parked mv1)
   (parked l1)
   (parked l2)
   (parked l3)
   (probe p1)
   (probe p2)
   (probe p3)
   (probe p4)
   (mav mv1)
   (lander l1)
   (lander l2)
   (lander l3)

   (location captain restroom1)
   (location na1 dorm1)
   (location na2 dorm1)
   (location e1 dorm2)
   (location e2 dorm2)
   (location e3 dorm2)
   (location e4 dorm2)
   (location sc1 restroom1)
   (location sc2 restroom1)
   
   (path dorm1 restroom1)
   (path dorm2 restroom1)
   (path restroom1 dorm1)
   (path restroom1 dorm2)
   (path kitchen bridge)
   (path bridge kitchen)
   (path kitchen hub)
   (path hub kitchen)
   (path hub restroom1)
   (path restroom1 hub)
   (path hub bridge)
   (path bridge hub)
   (path launch_bay hub)
   (path hub launch_bay)
   (path hub science_lab)
   (path science_lab hub)
   (teleporter restroom1 bridge)
   (teleporter launch_bay kitchen)
   (teleporter kitchen launch_bay)
   
   (contain solar_system earth)
   (contain solar_system mars)
   (contain solar_system n6)
   (contain helvetios dimidium)
   (contain helvetios n3)
   (high_radiation dimidium)
   (contain lich draugr)
   (contain lich n1)
   (contain lich n2)
   (contain alpha_centauri n4)
   (contain alpha_centauri n5)
   (contain alpha_centauri proxima_centauri_b)
   (contain kepler64b ph1)
   (high_radiation ph1)
   (space_location solar_system)
      
  )

  (:goal
      (and
	   (collected pla1)
	   (collected pla2)
	   (collected pla3)
	   (collected pla4)
	   (collected pla5)
	   (communicated_result)
	   )
      )
  )