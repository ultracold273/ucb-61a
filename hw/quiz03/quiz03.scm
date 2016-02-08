; Load this file into an interactive session with:
; python3 scheme -load quiz03.scm

; Filter (from lab) takes a predicate procedure f and a list s. It returns a
; new list containing only elements x in s for which (f x) is a true value.
(define (filter f s)
    (cond ((null? s) '())
          ((f (car s)) (cons (car s) (filter f (cdr s))))
          (else (filter f (cdr s))))
)

; All takes a predicate procedure f and a list s. It returns whether (f x) is
; a true value for every element x in s.
(define (all f s)
  (if (null? s)
	#t
    (and (f (car s)) (all f (cdr s)))
	)
)

; Every takes a two-argument predicate g and a list s. It returns a new list
; containing only elements x in s for which (g x y) is true for every y in s.
(define (every g s)
  (define (every-iter g s sa)
	(if (null? sa) nil
	  (if (all (lambda (y) (g (car sa) y)) s)
	    (cons (car sa) (every-iter g s (cdr sa)))
	    (every-iter g s (cdr sa))
	    )
	  )
	)
  (every-iter g s s)
)

; Return a minimum card.
(define (min hand) (car (every <= hand)))

; Fimp returns the card played under the fimping strategy in Cucumber.
(define (fimp hand highest)
  (if (all (lambda (x) (< x highest)) hand)
	(min hand)
	(min (filter (lambda (x) (>= x highest)) hand))
	)
)


; Legal returns pairs of (card . control) for all legal plays in Cucumber.
(define (legal hand highest)
  (define least (min hand))
  (define minall (all (lambda (x) (< x highest)) hand))
  (define (result hand)
    (if (null? hand) nil (begin
        (define card (car hand))
		(if (or (= card least) (>= card highest))
		  (if minall
			(cond 
			  ((= card least) (cons (cons card #f) (result (cdr hand))))
			  (else (cons (cons card #f) (result (cdr hand))))
		      )
			(cond
			  ((>= card highest) (cons (cons card #t) (result (cdr hand))))
			  (else (cons (cons card #f) (result (cdr hand))))
			  )
			)
		  (result (cdr hand))
		  ))))
  (result hand))


