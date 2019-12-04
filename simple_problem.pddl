; -*- Mode: PDDL; tab-width: 2
; vim:set et sts=4 ts=4 tw=80:
; This Source Code Form is subject to the terms of the MIT License.
; If a copy of the ML was not distributed with this
; file, You can obtain one at https://opensource.org/licenses/MIT

; author: JackRed <jackred@tuta.io>

(define (problem problem1)
  (:domain spacecraft)

  (:objects
      dorm1 hub - room
      e1 - engineer
      na1 - navigator
      sc1 - science_officer
      lich - space_region
      draugr - planet
      n1 - nebula
      p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 l1 - engine
      pla1 - plasma
  )

  (:init
   ; engine are onboard
   (parked p1)
   (parked p2)
   (parked p3)
   (parked p4)
   (parked p5)
   (parked p6)
   (parked p7)
   (parked p8)
   (parked p9)
   (parked p10)
   (parked l1)
   ; declare state of engine
   (probe p1)
   (probe p2)
   (probe p3)
   (probe p4)
   (probe p5)
   (probe p6)
   (probe p7)
   (probe p8)
   (probe p9)
   (probe p10)
   (lander l1)

   ; simple problem, ignore fuel and food
   (infinite_fuel)
   (infinite_food)
   (no_canon)
   (no_shield)
   
   ; location of the people in the spacecraft
   (location captain bridge)
   (location na1 dorm1)
   (location e1 dorm1)
   (location sc1 dorm1)

   ; path between rooms
   ; centered around hub
   (path dorm1 hub)
   (path kitchen bridge)
   (path bridge kitchen)
   (path kitchen hub)
   (path hub kitchen)
   (path hub dorm1)
   (path hub bridge)
   (path bridge hub)
   (path launch_bay hub)
   (path hub launch_bay)
   (path hub science_lab)
   (path science_lab hub)

   ; teleporter cause it's fancy
   (teleporter launch_bay kitchen)
   (teleporter kitchen launch_bay)

   ; what solar system contains what nebla / planet / moon
   (contain lich draugr)
   (contain lich n1)

   ; start in solar_system
   (space_location solar_system)
      
  )

  (:goal
   (and
    ; collect scan on draugr (land lander and contact spacecraft)
    (scan_collected draugr)
    ; collect plasma on nebula and analyse it
    (collected pla1)
    ; communicate the result to earth
    (communicated_result)
    )
   )
  )