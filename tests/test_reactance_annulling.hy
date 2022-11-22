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

;; (defn test-calc-alpha []
;;   )
