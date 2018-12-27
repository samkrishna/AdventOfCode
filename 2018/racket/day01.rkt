#lang debug br
(require racket/set)

(define fp (open-input-file "../inputs/day01.txt"))

(define frequencies
  (map string->number (port->lines fp)))

(define (★)
  (apply + frequencies))

(define (★★)
  (for/fold ([last-sum 0]
             [sums (set)]
             #:result last-sum)
            ([freq (in-cycle frequencies)]
             #:break (set-member? sums last-sum))
    (values (+ freq last-sum) (set-add sums last-sum))))

(module+ test
  (require rackunit)
  (check-equal? (time (★)) 547)
  (check-equal? (time (★★)) 76414))
