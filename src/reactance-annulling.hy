(import math)

(defn angular-frequency [f]
  (* 2 math.pi f))

(defn calc-omega-0 [f-l f-h]
  """Calculate the system resonance frequency
  Arguments:
  f-l: the lower corner frequency of system
  f-h: the upper corner frequency of system"""
  (let ((omega-l (angular-frequency f-l))
         (omega-h (angular-frequency f-h)))
    (math.sqrt (* omega-l omega-h))))

(defn calc-T [f-c v-as s-t alpha]
  """Calculate the optimal T value
  Arguments:
  f-c -- The cutoff frequency of the horn
  v-as -- The volume of air having the same
          acoustic compliance as the driver
          suspension
  s-t -- The area of the throat
  alpha -- parameter involving resonance
           frequencies"""
  (let ((omega-c (angular-frequency f-c))
         (c 344))
    (/ (* omega-c v-as)
       (* c s-t (+ 1 alpha)))))
  
