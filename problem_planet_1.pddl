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
      helvetios lich alpha_centauri kepler64b - space_region
      dimidium draugr phobetor poltergeist earth mars ph1 proxima_centauri_b - planet
      p1 l1 l2 l3 l4 l5 l6 l7 l8 - engine
  )

  (:init
   ; engine are onboard
   (parked p1)
   (parked l1)
   (parked l2)
   (parked l3)
   (parked l4)
   (parked l5)
   (parked l6)
   (parked l7)
   (parked l8)
   
   ; declare state of engine
   (probe p1)
   (lander l1)
   (lander l2)
   (lander l3)
   (lander l4)
   (lander l5)
   (lander l6)
   (lander l7)
   (lander l8)
   
   ; simple problem, ignore fuel and food, no canon
   (infinite_fuel)
   (infinite_food)
   (no_canon)
   (no_shield)
   
   ; location of the people in the spacecraft
   (location captain bridge)
   (location na1 dorm1)
   (location e1 dorm1)

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
   (contain solar_system earth)
   (contain solar_system mars)
   (contain helvetios dimidium)
   (high_radiation dimidium)
   (contain lich draugr)
   (contain lich phobetor)
   (contain lich poltergeist)
   (contain alpha_centauri proxima_centauri_b)
   (contain kepler64b ph1)
   (high_radiation ph1)

   ; start in solar_system

   (space_location solar_system)
      
  )

  (:goal
   (and
    ; collect scan on planets (land lander and contact spacecraft)
    (scan_collected dimidium)
    (scan_collected draugr)
    (scan_collected phobetor)
    (scan_collected poltergeist)
    (scan_collected proxima_centauri_b)
    (scan_collected earth)
    (scan_collected mars)
    (scan_collected ph1)
    ; communicate the result to earth
    (communicated_result)
    )
   )
  )