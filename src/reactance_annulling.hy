(import math)
(import thiele_small_conversion *)

(defn angular-frequency [f]
  (* 2 math.pi f))

(defn calc-omega-0 [f-l f-h]
  """Calculate the system resonance frequency
  Arguments:
  f-l -- Lower corner frequency of system
  f-h -- Upper corner frequency of system"""
  (let [omega-l (angular-frequency f-l)
        omega-h (angular-frequency f-h)]
    (math.sqrt (* omega-l omega-h))))

(defn calc-q-tc [f-l f-h]
  """Calculate the system Q
  Arguments:
  f-l -- Lower corner frequency of system
  f-h -- Upper corner frequency of system"""
  (let [omega-l (angular-frequency f-l)
        omega-h (angular-frequency f-h)
        omega-0 (calc-omega-0 f-l f-h)]
    (/ omega-0 (+ omega-l omega-h))))

(defn calc-alpha [omega-0 f-s]
  """Useful constant
  Arguments:
  omega-0 -- System resonance frequency
  f-s     -- Resonance frequency of the driver
  """
  (let [omega-s (angular-frequency f-s)]
    (- (** (/ omega-0 omega-s) 2) 1)))

(defn calc-q-lc [alpha q-es q-ms f-l f-h]
  """Acoustical load
  Arguments:
  alpha -- useful constant
  q-es  -- Damping by electrical resistance
  q-ms  -- Damping by mechanical resistance
  f-l   -- Lower corner frequency of system
  f-h   -- Upper corner frequency of system
  """
  (let [q-tc (calc-q-tc f-l f-h)
        q-ec (* (math.sqrt (+ alpha 1)) q-es)
        q-mc (* (math.sqrt (+ alpha 1)) q-ms)]
    ;; check that q-ec < q-tc
    (if (not (< q-ec q-tc))
        (print (+ "Q_ec is not less than Q_tc\n"
                  "Q_ec=" (str q-ec)
                  ", Q_tc=" (str q-tc)))
        (print "Valid parameters"))
    (/ 1 (- (- (/ 1 q-tc) (/ 1 q-ec)) (/ 1 q-mc)))))

(defn optimal-throat-area [f-l f-h m-ms c-ms r-e
                           bl r-ms s-d]
  """The optimal throat area for hypex computed
     using reactance anulling
  Arguments:
  f-l  -- Lower corner frequency of system
  f-h  -- Upper corner frequency of system
  m-ms -- Mass of the driver diaphragm and voice-coil
          assembly, including acoustic load (kg)
  c-ms -- Compliance of the driver's suspension (m/N)
  r-e  -- Resistance of voice coil (ohms)
  bl   -- Force on coil by magnet times current (T*m)
  r-ms -- Mechanical resistance of drivers suspension
          (N*s/m)
  s-d  -- Piston area of diaphram (m^2)"""
  (let [c 344
        f-s (em->ts-f-s m-ms c-ms)
        omega-0 (calc-omega-0 f-l f-h)
        alpha (calc-alpha omega-0 f-s)
        q-es (em->ts-q-es r-e f-s bl c-ms)
        q-ms (em->ts-q-ms f-s r-ms c-ms)
        q-lc (calc-q-lc alpha q-es q-ms f-l f-h)
        v-as (em->ts-v-as c-ms s-d)]
    (/ (* omega-0 q-lc v-as) (* (+ alpha 1) c))))

(defn optimal-T [f-c f-l f-h m-ms c-ms r-e
                 bl r-ms s-d]
  """The optimal T value for hypex computed
     using reactance anulling
  Arguments:
  f-c  -- The cutoff frequency of the horn
  f-l  -- Lower corner frequency of system
  f-h  -- Upper corner frequency of system
  m-ms -- Mass of the driver diaphragm and voice-coil
          assembly, including acoustic load (kg)
  c-ms -- Compliance of the driver's suspension (m/N)
  r-e  -- Resistance of voice coil (ohms)
  bl   -- Force on coil by magnet times current (T*m)
  r-ms -- Mechanical resistance of drivers suspension
          (N*s/m)
  s-d  -- Piston area of diaphram (m^2)"""
  (let [omega-c (angular-frequency f-c)
        c 344
        f-s (em->ts-f-s m-ms c-ms sd)
        omega-0 (calc-omega-0 f-l f-h)
        alpha (calc-alpha omega-0 f-s)
        v-as (em->ts-v-as c-ms s-d)
        s-t (optimal-throat-area f-l f-h m-ms c-ms
                                 r-e bl r-ms s-d)]
    (/ (* omega-c v-as)
       (* c s-t (+ 1 alpha)))))
