;-*- Mode:     Lisp -*-
;;;; Author:   Paul Dietz
;;;; Created:  Mon Jan 13 15:13:07 2003
;;;; Contains: Tests of APPLY

(in-package :cl-test)

;;; Error cases

(deftest apply.error.1
  (classify-error (apply))
  program-error)

(deftest apply.error.2
  (classify-error (apply #'cons))
  program-error)

(deftest apply.error.3
  (classify-error (apply #'cons nil))
  program-error)

;;; Non-error cases

(deftest apply.1
  (apply #'cons 'a 'b nil)
  (a . b))

(deftest apply.2
  (apply #'cons 'a '(b))
  (a . b))

(deftest apply.3
  (apply #'cons '(a b))
  (a . b))

(deftest apply.4
  (let ((zeros (make-list (min 10000 (1- call-arguments-limit))
			  :initial-element 1)))
    (apply #'+ zeros))
  #.(min 10000 (1- call-arguments-limit)))

(deftest apply.5
  (apply 'cons '(a b))
  (a . b))
