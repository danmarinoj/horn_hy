(import thiele_small_conversion *)

(defn test-calc-mm-s []
  (let [mm-d 1.96
        s-d 43]
    (assert (= (calc-mm-s mm-d s-d)
               expected-result))))
