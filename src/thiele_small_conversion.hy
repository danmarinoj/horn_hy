(import math)

(defn calc-m-ms [m-md s-d]
  """Calculate m-ms using m-md
  Arguments:
  mm-d -- Total moving mass: voice coil + diaphragm
  s-d  -- The surface area of the diaphragm
          (this is used to calculate r)
  """
  (let [r (math.sqrt (/ s-d math.pi))
        rho-0 1.205]
    (+ m-md (/ (* 8 (** r 3) rho-0) 3))))

(defn em->ts-f-s [m-md c-ms s-d]
  """Convert to the resonance frequency of driver
  Arguments:
  m-md -- Mass of the driver diaphragm and voice-coil
          assembly (kg)
  c-ms -- Compliance of the driver's suspension (m/N)
  s-d  -- Surface area of the diaphragm (m^2)
  """
  (let [m-ms (calc-m-ms m-md s-d)]
    (/ 1
     (* 2 math.pi (math.sqrt (* m-ms c-ms))))))

(defn em->ts-q-es [r-e f-s bl c-ms]
  """Convert to the damping by electrical resistance
  Arguments:
  r-e  -- Resistance of voice coil (ohms)
  f-s  -- Resonance frequency of driver (hz)
  bl   -- Force on coil by magnet times current (T*m)
  c-ms -- Compliance of the drivers suspension (m/N)
  """
  (/ r-e
     (* 2 math.pi f-s (** bl 2) c-ms)))

(defn em->ts-q-ms [f-s r-ms c-ms]
  """Convert to the damping by mechanical resistance
  Arguments:
  f-s  -- Resonance frequency of driver (hz)
  r-ms -- Mechanical resistance of drivers suspension
          (N*s/m)
  c-ms -- Compliance of the drivers suspension (m/N)
  """
  (/ 1
     (* 2 math.pi  f-s r-ms c-ms)))

(defn calc-q-ts [q-es q-ms]
  """The total Q of the circuit including both
     electric and mechanical losses
  Arguments:
  q-es -- Damping by electrical resistance
  q-ms -- Damping by mechanical resistance"""
  (/ (* q-es q-ms) (+ q-es q-ms)))

(defn em->ts-v-as [c-ms s-d]
  """Convert to the volume of air having the same
     acoustic compliance as the driver suspension
  Arguments:
  c-ms -- Compliance of the drivers suspension (m/N)
  s-d  -- Piston area of diaphram (m^2)"""
  (let [rho-0 1.205    ; density of air (kg/m^3)
        c 344]         ; the speed of sound
    (* rho-0 (** c 2) c-ms (** s-d 2))))
