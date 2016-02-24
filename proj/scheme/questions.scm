(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cddr x) (cdr (cdr x)))
(define (cadar x) (car (cdr (car x))))

; Some utility functions that you may find useful to implement.
(define (map proc items)
  (if (null? items) nil
  (cons (proc (car items)) (map proc (cdr items)))))

(define (cons-all first rests)
  (if (null? rests) nil
	(cons (cons first (car rests)) (cons-all first (cdr rests)))
	)
  )

(define (zip pairs)
  (list (map car pairs) (map cadr pairs))
  )

;; Problem 18
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN Question 18
  (define (enum-iter s i)
	(if (null? s) nil
	  (cons (list i (car s)) (enum-iter (cdr s) (+ i 1)))
	  )
	)
  (enum-iter s 0)
  )
  ; END Question 18

;; Problem 19
;; List all ways to make change for TOTAL with DENOMS
(define (list-change total denoms)
  ; BEGIN Question 19
  (define (concat x y)
	(if (null? x) y
	  (if (null? (cdr x)) (cons (car x) y)
		(cons (car x) (concat (cdr x) y))
		)
	  )
	)
  (define (make-list total num)
	(if (= total num)
	  (list total)
	  (cons num (make-list (- total num) num))
	  )
	)
  (if (or (null? denoms) (= total 0)) (list nil)
	(if (null? (cdr denoms)) 
	  ; Return or not satisfy
	  (if (= (modulo total (car denoms)) 0)
		(cons (make-list total (car denoms)) nil)
;		(make-list total (car denoms))
		nil
		)
	  ; More
	  (if (< total (car denoms))
		(list-change total (cdr denoms))
		 (let ((one (list-change total (cdr denoms))) (two (list-change (- total (car denoms)) denoms)))
		 (cond
		   ((and (null? one) (null? two)) nil)
		   ((null? one) (cons-all (car denoms) two))
		   ((null? two) one)
		   (else (concat (cons-all (car denoms) two) one))
		   )
		 )
	   )
	  )
	)
  )
  ; END Question 19

;; Problem 20
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (analyze expr)
  (define (analyze-seq subexpr)
	(if (null? subexpr) nil
	  (cons (analyze (car subexpr)) (analyze-seq (cdr subexpr)))
	  )
	)
  (cond ((atom? expr)
         ; BEGIN Question 20
		 expr
         ; END Question 20
         )
        ((quoted? expr)
         ; BEGIN Question 20
		 expr
         ; END Question 20
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN Question 20
		   (cons form (cons params (map analyze body)))
           ; END Question 20
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN Question 20
		   (let ((formals (map car values)) 
				 (args (map analyze (map cadr values))))
			 (cons (list 'lambda formals (analyze (car body))) args)
			 )
           ; END Question 20
           ))
        (else
         ; BEGIN Question 20
		 (if (null? expr) nil
		   (cons (car expr) (analyze-seq (cdr expr)))
		 )
         ; END Question 20
         )))

;; Problem 21 (optional)
;; Draw the hax image using turtle graphics.
(define (hax d k)
  ; BEGIN Question 21
  'REPLACE-THIS-LINE
  )
  ; END Question 21

