(import math)

(defn angular-frequency [f]
  (* 2 math.pi f))

(defn calc-omega-0 [f-l f-h]
  """Calculate the system resonance frequency
  Arguments:
  f-l -- Lower corner frequency of system
  f-h -- Upper corner frequency of system"""
  (let ((omega-l (angular-frequency f-l))
         (omega-h (angular-frequency f-h)))
    (math.sqrt (* omega-l omega-h))))

(defn calc-q-tc [f-l f-h]
  """Calculate the system Q
  Arguments:
  f-l -- Lower corner frequency of system
  f-h -- Upper corner frequency of system"""
  (let ((omega-l (angular-frequency f-l))
         (omega-h (angular-frequency f-h))
        (omega-0 (calc-omega-0 f-l f-h)))
    (/ omega-0 (+ omega-l omega-h))))

(defn calc-alpha [omega-0 f-s]
  """Useful constant
  omega-0 -- System resonance frequency
  f-s     -- Resonance frequency of the driver
  """
  (let ((omega-s (angular-frequency f-s)))
    (- (** (/ omega-0 omega-s) 2) 1)))

(defn calc-q-lc [alpha q-es q-ms f-l f-h]
  """Acoustical load
  alpha -- useful constant
  q-es  -- Damping by electrical resistance
  q-ms  -- Damping by mechanical resistance
  f-l   -- Lower corner frequency of system
  f-h   -- Upper corner frequency of system
  """
  (let ((q-tc (calc-q-tc f-l f-h))
         ;; electrical loss factor
         (q-ec (* (math.sqrt (+ alpha 1)) q-es))
        (q-mc (* (math.sqrt (+ alpha 1)) q-ms)))
    (/ 1 (- (- (/ 1 q-tc) (/ 1 q-ec)) q-mc))))

(defn optimal-throat-area []
  

(defn calc-T [f-c v-as s-t alpha]
  """Calculate the optimal T value
  Arguments:
  f-c   -- The cutoff frequency of the horn
  v-as  -- The volume of air having the same
           acoustic compliance as the driver
           suspension
  s-t   -- The area of the throat
  alpha -- parameter involving resonance
           frequencies"""
  (let ((omega-c (angular-frequency f-c))
         (c 344))
    (/ (* omega-c v-as)
       (* c s-t (+ 1 alpha)))))
