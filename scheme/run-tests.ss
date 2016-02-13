#!../src/ikarus -b ikarus.boot --r6rs-script

(import (ikarus))

(define test-libraries '(
  lists strings bytevectors hashtables fixnums bignums numerics
  bitwise enums pointers sorting io fasl reader case-folding
  parse-flonums string-to-number bignum-to-flonum div-and-mod
  fldiv-and-mod unicode normalization repl set-position guardians
  symbol-table scribble))

(define (run-test-from-library x)
  (printf "[testing ~a] ..." x)
  (eval '(run-tests) (environment `(tests ,x)))
  (printf " OK\n"))

(apply
  (case-lambda
    [(script) (for-each run-test-from-library test-libraries)]
    [(script . test-name*)
     (let ([test-name* (map string->symbol test-name*)])
       (for-each
         (lambda (x)
           (unless (memq x test-libraries)
             (error script "invalid test name" x)))
         test-name*)
       (for-each run-test-from-library test-name*))])
  (command-line))


(printf "Happy Happy Joy Joy\n")
