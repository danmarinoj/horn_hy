(import thiele_small_conversion *)

(defn test-calc-m-ms []
  (let [m-md (* 1.96 (** 10 -3)) ; convert to kg
        s-d (* 43 (** 10 -4)) ; convert cm^2 to m^2
        expected-result 0.002122717271602312]
    (assert (= (calc-m-ms m-md s-d)
               expected-result))))

(defn test-em-ts-f-s []
  (let [m-md (* 1.96 (** 10 -3)) ; convert to kg
        s-d (* 43 (** 10 -4)) ; convert cm^2 to m^2
        c-ms (* 4.5 (** 10 -5))
        expected-result 514.9532435152422]
    (assert (= (em->ts-f-s m-md c-ms s-d)
               expected-result))))

(defn test-em-ts-q-es []
  (let [r-e 6.4
        f-s 514.9532435152422
        bl 16.74
        c-ms (* 4.5 (** 10 -5))
        expected-result 0.15685879939405226]
    (assert (= (em->ts-q-es r-e f-s bl c-ms)
               expected-result))))

(defn test-em-ts-q-ms []
  (let [f-s 514.9532435152422
        r-ms 1.0
        c-ms (* 4.5 (** 10 -5))
        expected-result 6.868150764543236]
    (assert (= (em->ts-q-ms f-s r-ms c-ms)
               expected-result))))

(defn test-calc-q-ts []
  (let [q-es 0.15685879939405226
        q-ms 6.868150764543236
        expected-result 0.1533563581911746]
    (assert (= (calc-q-ts q-es q-ms)
               expected-result))))

(defn test-em-ts-v-as []
  (let [c-ms (* 4.5 (** 10 -5))
        s-d (* 43 (** 10 -4))
        expected-result 0.00011864606990400002] ;?????
    (assert (= (em->ts-v-as c-ms s-d)
               expected-result))))
