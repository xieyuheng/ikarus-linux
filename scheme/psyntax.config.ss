(library (psyntax config)
  (export if-wants-define-record if-wants-define-struct
          if-wants-case-lambda
          if-wants-letrec* if-wants-global-defines
          if-wants-library-letrec*
          base-of-interaction-library)
  (import (rnrs))

  (define (base-of-interaction-library) '(ikarus))

  (define-syntax define-option
    (syntax-rules ()
      ((_ name #t)
       (define-syntax name
         (syntax-rules ()
           ((_ sk fk) sk))))
      ((_ name #f)
       (define-syntax name
         (syntax-rules ()
           ((_ sk fk) fk))))))


  (define-option if-wants-define-record  #t)
  (define-option if-wants-define-struct  #t)
  ;;; define-record is an ikarus-specific extension.
  ;;; should be disabled for all other implementations
  ;;; the source is included to illustrate how
  ;;; implementation-specific extensions can be added
  ;;; to the expander

  (define-option if-wants-global-defines #f)
  ;;; If the implementation requires that all global
  ;;; variables be defined before they're set!ed,
  ;;; then enabling this option causes the expander
  ;;; to produce (define <global> '#f) for every
  ;;; exported identifiers.  If the option is disabled,
  ;;; then the global definitions are suppressed.

  (define-option if-wants-case-lambda    #t)
  ;;; Implementations that support case-lambda natively
  ;;; should have the next option enabled.  Disabling
  ;;; wants-case-lambda causes the expander to produce
  ;;; ugly, inefficient, but correct code by expanding
  ;;; case-lambda into explicit dispatch code.

  (define-option if-wants-letrec*        #t)
  ;;; If the implementation has built-in support for
  ;;; efficient letrec* (ikarus, chez), then this option
  ;;; should be enabled.  Disabling the option expands
  ;;; (letrec* ((lhs* rhs*) ...) body) into
  ;;; (let ((lhs* #f) ...) (set! lhs* rhs*) ... body)

  (define-option if-wants-library-letrec* #t)

)
