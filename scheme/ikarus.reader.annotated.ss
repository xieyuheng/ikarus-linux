(library (ikarus.reader.annotated)
  (export read-source-file read-library-source-file read-script-source-file)
  (import
    (except (ikarus) read-annotated read-script-annotated)
    (only (ikarus.reader) read-annotated read-script-annotated)
    (only (ikarus.io) open-string-input-port/id))

  (define (annotated-port file-name)
    (open-string-input-port/id
      (with-input-from-file file-name
        (lambda ()
          (let ([x (get-string-all (current-input-port))])
            (if (eof-object? x) "" x))))
      file-name))

  (define (read-library-source-file file-name)
    (read-annotated (annotated-port file-name)))

  (define (read-source-file file-name)
    (let ([p (annotated-port file-name)])
      (let f ()
        (let ([x (read-annotated p)])
          (if (eof-object? x)
              '()
              (cons x (f)))))))

  (define (read-script-source-file file-name)
    (let ([p (annotated-port file-name)])
      (let ([x (read-script-annotated p)])
        (if (eof-object? x)
            (begin (close-input-port p) '())
            (cons x
              (let f ()
                (let ([x (read-annotated p)])
                  (cond
                    [(eof-object? x)
                     (close-input-port p)
                     '()]
                    [else (cons x (f))]))))))))
)
