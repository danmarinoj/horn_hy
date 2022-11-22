(import math)

(defn x-0 [f-c]
  """Reference distance
  Arguments:
  f-c -- cutoff frequency"""
  (let [c 344]
    (/ c
       (* 2 math.pi f-c))))

(defn hypex [f-c T r-t]
  """Hypex function for horn
  Arguments:
  f-c -- cutoff frequency
  T -- hypex parameter
  r-t --radius of throat"""
  (lambda (x)
          (* r-t
             (+ (math.cosh (/ x (x-0 f-c)))
                (* T (math.sinh
                       (/ x (x-0 f-c))))))))
