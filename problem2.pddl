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
      e1 e2 - engineer
      na1 - navigator
      sc1 - science_officer
      g1 - gunner
      alpha_centauri - space_region
      proxima_centauri_b - planet
      n1 - nebula
      p1 p2 p3 p4 mv1 l1 - engine
      pla1 - plasma
  )

  (:init

   (shield)
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

   (collected pla1)
   
   (location captain restroom1)
   (location na1 dorm1)
   (location e1 dorm2)
   (location e2 dorm2)
   (location sc1 restroom1)
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
   (asteroids alpha_centauri)
   (contain alpha_centauri proxima_centauri_b)
   (space_location solar_system)
      
  )

  (:goal
      (and
       (scan_collected proxima_centauri_b)
       (communicated_result)
       )
      )
  )