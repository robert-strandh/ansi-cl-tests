;-*- Mode:     Lisp -*-
;;;; Author:   Paul Dietz
;;;; Created:  Wed Sep  3 06:57:22 2003
;;;; Contains: Aux. functions for testing GCD

(in-package :cl-test)

(defun my-gcd (x y)
  (cond
   ((< x 0)
    (my-gcd (- x) y))
   ((< y 0)
    (my-gcd x (- y)))
   ((<= x y)
    (my-gcd* x y))
   (t
    (my-gcd* y x))))

(defun my-gcd* (x y)
  ;;; 0 <= x <= y
  (loop
   (when (zerop x) (return y))
   (psetq x (mod y x)
	  y x)))

  