(library (ikarus system time-and-date)
  (export current-time time? time-second time-nanosecond
          time-gmt-offset)
  (import
    (except (ikarus) time current-time time? time-second
            time-nanosecond time-gmt-offset))

  (define-struct time (msecs secs usecs))
                  ;;; mega/seconds/micros

  (define (current-time)
    (foreign-call "ikrt_current_time" (make-time 0 0 0)))

  (define (time-second x)
    (if (time? x)
        (+ (* (time-msecs x) #e10e5)
           (time-secs x))
        (die 'time-second "not a time" x)))

  (define (time-nanosecond x)
    (if (time? x)
        (* (time-usecs x) 1000)
        (die 'time-nanosecond "not a time" x)))

  (define (time-gmt-offset x)
    (if (time? x)
        (foreign-call "ikrt_gmt_offset" x)
        (die 'time-gmt-offset "not a time" x)))
  )
