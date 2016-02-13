(library (ikarus command-line)
  (export command-line-arguments command-line)
  (import
    (ikarus system $arg-list)
    (except (ikarus) command-line command-line-arguments))

  (define (command-line) (command-line-arguments))
  (define command-line-arguments
    (make-parameter
      (map (lambda (x)
             (cond
               [(string? x)  x]
               [(bytevector? x) (utf8->string x)]
               [else (die 'command-line "invalid" x)]))
           ($arg-list))
      (lambda (x)
        (if (and (list? x) (andmap string? x))
            x
            (die 'command-list
              "invalid command-line-arguments" x))))))
