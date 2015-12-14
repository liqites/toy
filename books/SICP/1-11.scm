(define (f n)
  (if (< n 4)
      n
      (f-iter 1 2 3 4 n)
      )
  )

(define (f-iter a b c count max-count)
  (if (> count max-count)
      c
      (f-iter b c (+ a b c) (+ count 1) max-count)
      )
  )
