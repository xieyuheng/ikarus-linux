(library (psyntax compat)
  (export define-record make-parameter parameterize format gensym
          eval-core symbol-value set-symbol-value!
          make-struct-type read-annotated
          annotation? annotation-expression annotation-source
          annotation-stripped
          read-library-source-file
          library-version-mismatch-warning
          library-stale-warning
          file-locator-resolution-error
          label-binding set-label-binding! remove-location
          make-source-position-condition)
  (import
    (only (ikarus.compiler) eval-core)
    (only (ikarus.reader.annotated) read-library-source-file)
    (ikarus))

  (define (library-version-mismatch-warning name depname filename)
    (fprintf (current-error-port)
        "WARNING: library ~s has an inconsistent dependency \
         on library ~s; file ~s will be recompiled from \
         source.\n"
       name depname filename))

  (define (library-stale-warning name filename)
    (fprintf (current-error-port)
       "WARNING: library ~s is stale; file ~s will be recompiled from source.\n"
       name filename))

  (define (file-locator-resolution-error libname failed-list pending-list)
    (define-condition-type &library-resolution &condition
       make-library-resolution-condition
       library-resolution-condition?
       (library condition-library)
       (files condition-files))
    (define-condition-type &imported-from &condition
       make-imported-from-condition imported-from-condition?
       (importing-library importing-library))

    (raise
      (apply condition (make-error)
        (make-who-condition 'expander)
        (make-message-condition
          "cannot locate library in library-path")
        (make-library-resolution-condition
          libname failed-list)
        (map make-imported-from-condition pending-list))))

  (define-syntax define-record
    (syntax-rules ()
      [(_ name (field* ...) printer)
       (begin
         (define-struct name (field* ...))
         (module ()
            (set-rtd-printer! (type-descriptor name)
              printer)))]
      [(_ name (field* ...))
       (define-struct name (field* ...))]))

  (define (set-label-binding! label binding)
    (set-symbol-value! label binding))

  (define (label-binding label)
    (and (symbol-bound? label) (symbol-value label)))

  (define (remove-location x)
    (import (ikarus system $symbols))
    ($unintern-gensym x)))
