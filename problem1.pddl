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
      g1 - gunner
      alpha_centauri lich helvetios kepler64b - space_region
      earth mars draugr dimidium proxima_centauri_b ph1 - planet
      n1 n2 n3 n4 n5 - nebula
      m1 m2 m3 m4 m5 - moon
      f1 f2 f3 f4 f5 - fuel
      p1 p2 p3 p4 mv1 l1 l2 l3 - engine
      pla1 pla2 pla3 - plasma
  )

  (:init

   (shield)
   
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

   (collected f1)
   (collected f2)
   
   (location captain restroom1)
   (location na1 dorm1)
   (location na2 dorm1)
   (location e1 dorm2)
   (location e2 dorm2)
   (location e3 dorm2)
   (location e4 dorm2)
   (location sc1 restroom1)
   (location sc2 restroom1)
   (location g1 restroom1)
   
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
   (contain solar_system m1)
   (contain helvetios dimidium)
   (contain helvetios m4)
   (contain helvetios n3)
   (high_radiation dimidium)
   (contain lich draugr)
   (contain lich n1)
   (contain lich n2)
   (asteroids alpha_centauri)
   (contain alpha_centauri n4)
   (contain alpha_centauri n5)
   (contain alpha_centauri proxima_centauri_b)
   (contain alpha_centauri m2)
   (contain alpha_centauri m3)
   (contain kepler64b ph1)
   (high_radiation ph1)
   (space_location solar_system)
      
  )

  (:goal
      (and
	   (used mars)
	   (scan_collected draugr)
	   (scan_collected dimidium)
	   (scan_collected proxima_centauri_b)
	   (scan_collected ph1)
	   (communicated_result)
	   )
      )
  )