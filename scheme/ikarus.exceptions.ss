(library (ikarus exceptions)
  (export with-exception-handler raise raise-continuable
    error warning assertion-violation die)
  (import
    (only (rnrs) condition make-non-continuable-violation
          make-message-condition make-error make-who-condition
          make-irritants-condition make-assertion-violation)
    (except (ikarus)
      with-exception-handler raise raise-continuable
      error warning assertion-violation die))

  (define handlers
    (make-parameter
      (list
        (lambda (x)
          (display "Unhandled exception:\n" (console-error-port))
          (print-condition x (console-error-port))
          (when (serious-condition? x)
            (exit -1)))
        (lambda args (exit -1)))))

  (define (with-exception-handler handler proc2)
    (unless (procedure? handler)
      (assertion-violation 'with-exception-handler
        "handler is not a procedure" handler))
    (unless (procedure? proc2)
      (assertion-violation 'with-exception-handler "not a procedure" proc2))
    (parameterize ([handlers (cons handler (handlers))])
      (proc2)))

  (define (raise-continuable x)
    (let ([h* (handlers)])
      (let ([h (car h*)] [h* (cdr h*)])
        (parameterize ([handlers h*])
          (h x)))))

  (define (raise x)
    (let ([h* (handlers)])
      (let ([h (car h*)] [h* (cdr h*)])
        (parameterize ([handlers h*])
          (h x)
          (raise
            (condition
              (make-non-continuable-violation)
              (make-message-condition "handler returned")))))))

  (define (err who* raise* cond* who msg irritants)
    (unless (string? msg)
      (assertion-violation who* "message is not a string" msg))
    (raise*
       (condition
         (cond*)
         (if who (make-who-condition who) (condition))
         (make-message-condition msg)
         (make-irritants-condition irritants))))

  (define (error who msg . irritants)
    (err 'error raise make-error who msg irritants))
  (define (assertion-violation who msg . irritants)
    (err 'assertion-violation raise make-assertion-violation who msg irritants))
  (define (warning who msg . irritants)
    (err 'warning raise-continuable make-warning who msg irritants))
  (define (die who msg . irritants)
    (err 'die raise make-assertion-violation who msg irritants))

)
