(library (psyntax internal)
  (export current-primitive-locations compile-core-expr-to-port expanded->core)
  (import (rnrs) (psyntax compat) (ikarus.compiler))

  (define (expanded->core x) x))
