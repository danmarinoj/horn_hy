(import math)

(defn bend-curve-reparam [t t-min r]
  """Reparametrization for the curved part
  Arguments:
  t -- parameter distance from throat
  t-min -- distance at the start of curve
  r -- radius of curvature of the bend"""
  (/ (- t t-min) r))

(defn bend-curve [t r center-point t-min]
  """Center curve for the bend y-z coordinates
  Arguments:
  t -- parameter distance from throat
  r -- radius of curvature of the bend
  center-point -- center of the curve
  t-min -- distance at the start of curve"""
  (let [center-x (get center-point 0)
        center-y (get center-point 1)]
    [(- center-x
        (* r (math.cos
               (bend-curve-reparam t t-min r))))
     (+ center-y
        (* r (math.sin
               (bend-curve-reparam t t-min r))))]))

(defn center-curve [height r length]
  """Function giving the curved axis of the horn
  Arguments:
  height -- height of vertical part of axis
  r -- radius of curvature of the bend
  length -- length of horizontal part of axis
  """
  (lambda (t)
          (let [curve-length (* (/ math.pi 2) r)
                total-length (+ height
                                curve-length
                                length)]
            ;; throat to bend case
            (if (< t height)
                (let [x-axis (- total-length r)
                      y-init (* -1
                                (+ r height))]
                  [x-axis (+ y-init t)])
                ;; curve and curve to mouth case
                (if (< (+ height curve-length))
                    (let [center-point
                          [(- total-length
                              length)
                           (* -1 r)]]
                      (bend-curve t r
                                  center-point
                                  height))
                    [0 t])))))
