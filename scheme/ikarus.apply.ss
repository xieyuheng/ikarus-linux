(library (ikarus apply)
  (export apply)
  (import
   (except (ikarus) apply)
   (ikarus system $pairs)
   (ikarus system $stack))

  (define apply
    (let ()
      (define (err f ls)
        (if (procedure? f)
          (die 'apply "not a list" ls)
          (die 'apply "not a procedure" f)))
      (define (fixandgo f a0 a1 ls p d)
        (cond
         [(null? ($cdr d))
          (let ([last ($car d)])
            ($set-cdr! p last)
            (if (and (procedure? f) (list? last))
              ($$apply f a0 a1 ls)
              (err f last)))]
         [else (fixandgo f a0 a1 ls d ($cdr d))]))
      (define apply
        (case-lambda
         [(f ls)
          (if (and (procedure? f) (list? ls))
            ($$apply f ls)
            (err f ls))]
         [(f a0 ls)
          (if (and (procedure? f) (list? ls))
            ($$apply f a0 ls)
            (err f ls))]
         [(f a0 a1 ls)
          (if (and (procedure? f) (list? ls))
            ($$apply f a0 a1 ls)
            (err f ls))]
         [(f a0 a1 . ls)
          (fixandgo f a0 a1 ls ls ($cdr ls))]))
      apply)))
