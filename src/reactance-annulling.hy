(import math)

(defn calc-omega-0 [f-l f-h]
  """Calculate the system resonance frequency
  Arguments:
  f-l: the lower corner frequency of system
  f-h: the upper corner frequency of system"""
  (let ((omega-l (* 2 math.pi f-l))
         (omega-h (* 2 math.pi f-h)))
    (math.sqrt (* omega-l omega-h))))
