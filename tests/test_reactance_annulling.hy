(import reactance_annulling *)

(defn test-angular-frequency []
  (let [f 300
        expected-result 3141.592653589793]
    (assert (=
              (angular-frequency 500)
              expected-result))))

(defn test-calc-omega-0 []
  (let [f-l 500
        f-h 3000
        expected-result 7695.2989809711835]
    (assert (= (calc-omega-0 f-l f-h)
               expected-result))))

(defn test-calc-q-tc []
  (let [f-l 500
        f-h 3000
        expected-result 0.34992710611188255]
    (assert (= (calc-q-tc f-l f-h)
               expected-result))))

(defn test-alpha []
  (let [omega-0 7695.2989809711835
        f-s 514.9532435152422
        expected-result 4.656602526040135]
    (assert (= (calc-alpha omega-0 f-s)
               expected-result))))

(defn test-calc-q-lc []
  (let [alpha 4.656602526040135
        q-es 0.15685879939405226
        q-ms 6.868150764543236
        f-l 500
        f-h 2000
        expected-result 10]
    (print (calc-q-lc alpha q-es q-ms f-l f-h))
    (assert (= (calc-q-lc alpha q-es q-ms f-l f-h)
               expected-result))))

;; (defn test-calc-q-lc []
;;   (let [alpha
;;         q-es
;;         q-ms
;;         f-l
;;         f-h]

;; (defn test-optimal-throat-area []
;;   (let [f-l 500
;;         f-h 3000
;;         m-ms 0.002122717271602312
;;         c-ms (* 4.5 (** 10 -5))
;;         r-e 6.4
;;         bl 16.74
;;         r-ms 1.0
;;         s-d (* 43 (** 10 -4))
;;         expected-result 10]
;;     (print (optimal-throat-area f-l f-h m-ms c-ms r-e bl r-ms s-d))))
