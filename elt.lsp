;-*- Mode:     Lisp -*-
;;;; Author:   Paul Dietz
;;;; Created:  Sat Oct 12 19:38:29 2002
;;;; Contains: Tests of ELT

(in-package :cl-test)

(declaim (optimize (safety 3)))

(defun safe-elt (x n)
  (handler-case
   (elt x n)
   (type-error () 'type-error)
   (error (c) c)))

;; elt on lists

(deftest elt-1 (safe-elt nil 0) type-error)
(deftest elt-1a (safe-elt nil -10) type-error)
(deftest elt-2 (safe-elt nil 1000000) type-error)
(deftest elt-3 (safe-elt '(a b c d e) 0) a)
(deftest elt-4 (safe-elt '(a b c d e) 2) c)
(deftest elt-5 (safe-elt '(a b c d e) 4) e)
(deftest elt-5a (safe-elt '(a b c d e) -4) type-error)
(deftest elt-6
  (let ((x (make-int-list 1000)))
    (not (not
	  (every
	   #'(lambda (i)
	       (eql i (safe-elt x i)))
	   x))))
  t)

(deftest elt-7
  (let* ((x (list 'a 'b 'c 'd))
	 (y (setf (elt x 0) 'e)))
    (list x y))
  ((e b c d) e))

(deftest elt-8
  (let* ((x (list 'a 'b 'c 'd))
	 (y (setf (elt x 1) 'e)))
    (list x y))
  ((a e c d) e))

(deftest elt-9
  (let* ((x (list 'a 'b 'c 'd))
	 (y (setf (elt x 3) 'e)))
    (list x y))
  ((a b c e) e))

(deftest elt-10
  (handler-case
   (let ((x (list 'a 'b 'c)))
     (setf (elt x 4) 'd))
   (type-error () 'type-error)
   (error (c) c))
  type-error)

(deftest elt-11
  (let ((x (list 'a 'b 'c 'd 'e)))
    (let ((y (loop for c on x collect c)))
      (setf (elt x 2) 'f)
      (not
       (not
	(every #'eq
	       y
	       (loop for c on x collect c))))))
  t)

(deftest elt-12
  (let ((x (make-int-list 100000)))
    (safe-elt x 90000))
  90000)

(deftest elt-13
  (let ((x (make-int-list 100000)))
    (setf (elt x 80000) 'foo)
    (list (safe-elt x 79999)
	  (safe-elt x 80000)
	  (safe-elt x 80001)))
  (79999 foo 80001))


;; Special case to test error handling as dictated by new
;; CL standard
(deftest elt-14
  (let ((x (list 'a 'b 'c)))
    (safe-elt x 10))
  type-error)

(deftest elt-15
  (let ((x (list 'a 'b 'c)))
    (safe-elt x 'a))
  type-error)

(deftest elt-16
  (let ((x (list 'a 'b 'c)))
    (safe-elt x 10.0))
  type-error)

(deftest elt-17
  (let ((x (list 'a 'b 'c)))
    (safe-elt x -1))
  type-error)

(deftest elt-18
  (let ((x (list 'a 'b 'c)))
    (safe-elt x -100000000000000000))
  type-error)

(deftest elt-19
  (let ((x (list 'a 'b 'c)))
    (safe-elt x #\w))
  type-error)

(deftest elt-v-1
  (handler-case
   (elt (make-array '(0)) 0)
   (type-error () 'type-error)
   (error (c) c))
  type-error)

;; (deftest elt-v-2 (elt (make-array '(1)) 0) nil)  ;; actually undefined
(deftest elt-v-3 (elt (make-array '(5) :initial-contents '(a b c d e)) 0)
  a)
(deftest elt-v-4 (elt (make-array '(5) :initial-contents '(a b c d e)) 2)
  c)
(deftest elt-v-5 (elt (make-array '(5) :initial-contents '(a b c d e)) 4)
  e)

(defun elt-v-6-body ()
  (let ((x (make-int-list 1000)))
    (let ((a (make-array '(1000) :initial-contents x)))
      (loop
	  for i from 0 to 999 do
	    (unless (eql i (elt a i)) (return nil))
	  finally (return t)))))

(deftest elt-v-6
    (elt-v-6-body)
  t)

(deftest elt-v-7
  (let* ((x (make-array '(4) :initial-contents (list 'a 'b 'c 'd)))
	 (y (setf (elt x 0) 'e)))
    (list (elt x 0) (elt x 1) (elt x 2) (elt x 3) y))
  (e b c d e))

(deftest elt-v-8
  (let* ((x (make-array '(4) :initial-contents (list 'a 'b 'c 'd)))
	 (y (setf (elt x 1) 'e)))
    (list (elt x 0) (elt x 1) (elt x 2) (elt x 3) y))
  (a e c d e))

(deftest elt-v-9
  (let* ((x (make-array '(4) :initial-contents (list 'a 'b 'c 'd)))
	 (y (setf (elt x 3) 'e)))
    (list (elt x 0) (elt x 1) (elt x 2) (elt x 3) y))
  (a b c e e))

(deftest elt-v-10
  (handler-case
   (let ((x (make-array '(3) :initial-contents (list 'a 'b 'c))))
     (setf (elt x 4) 'd))
   (type-error () 'type-error)
   (error (c) c))
  type-error)

(deftest elt-v-11
  (handler-case
   (let ((x (make-array '(3) :initial-contents (list 'a 'b 'c))))
     (setf (elt x -100) 'd))
   (type-error () 'type-error)
   (error (c) c))
  type-error)

(deftest elt-v-12
    (let ((x (make-int-array 100000)))
      (elt x 90000))
  90000)

(deftest elt-v-13
  (let ((x (make-int-array 100000)))
    (setf (elt x 80000) 'foo)
    (list (elt x 79999)
	  (elt x 80000)
	  (elt x 80001)))
  (79999 foo 80001))

;;;  Adjustable arrays

(defun make-adj-array (n &key initial-contents)
  (if initial-contents
      (make-array n :adjustable t :initial-contents initial-contents)
    (make-array n :adjustable t)))

(deftest elt-adj-array-1
  (handler-case
   (elt (make-adj-array '(0)) 0)
   (type-error () 'type-error)
   (error (c) c))
  type-error)

;;; (deftest elt-adj-array-2 (elt (make-adj-array '(1)) 0) nil) ;; actually undefined 

(deftest elt-adj-array-3
 (elt (make-adj-array '(5) :initial-contents '(a b c d e)) 0)
  a)

(deftest elt-adj-array-4
 (elt (make-adj-array '(5) :initial-contents '(a b c d e)) 2)
  c)

(deftest elt-adj-array-5
 (elt (make-adj-array '(5) :initial-contents '(a b c d e)) 4)
  e)

(defun elt-adj-array-6-body ()
  (let ((x (make-int-list 1000)))
    (let ((a (make-adj-array '(1000) :initial-contents x)))
      (loop
	  for i from 0 to 999 do
	    (unless (eql i (elt a i)) (return nil))
	  finally (return t)))))

(deftest elt-adj-array-6
    (elt-adj-array-6-body)
  t)

(deftest elt-adj-array-7
  (let* ((x (make-adj-array '(4) :initial-contents (list 'a 'b 'c 'd)))
	 (y (setf (elt x 0) 'e)))
    (list (elt x 0) (elt x 1) (elt x 2) (elt x 3) y))
  (e b c d e))

(deftest elt-adj-array-8
  (let* ((x (make-adj-array '(4) :initial-contents (list 'a 'b 'c 'd)))
	 (y (setf (elt x 1) 'e)))
    (list (elt x 0) (elt x 1) (elt x 2) (elt x 3) y))
  (a e c d e))

(deftest elt-adj-array-9
  (let* ((x (make-adj-array '(4) :initial-contents (list 'a 'b 'c 'd)))
	 (y (setf (elt x 3) 'e)))
    (list (elt x 0) (elt x 1) (elt x 2) (elt x 3) y))
  (a b c e e))

(deftest elt-adj-array-10
  (handler-case
   (let ((x (make-adj-array '(3) :initial-contents (list 'a 'b 'c))))
     (setf (elt x 4) 'd))
   (type-error () 'type-error)
   (error (c) c))
  type-error)

(deftest elt-adj-array-11
  (handler-case
   (let ((x (make-adj-array '(3) :initial-contents (list 'a 'b 'c))))
     (setf (elt x -100) 'd))
   (type-error () 'type-error)
   (error (c) c))
  type-error)

(deftest elt-adj-array-12
    (let ((x (make-int-array 100000 #'make-adj-array)))
      (elt x 90000))
  90000)

(deftest elt-adj-array-13
    (let ((x (make-int-array 100000 #'make-adj-array)))
    (setf (elt x 80000) 'foo)
    (list (elt x 79999)
	  (elt x 80000)
	  (elt x 80001)))
  (79999 foo 80001))

;; displaced arrays

(defvar *displaced* nil)
(setf *displaced* (make-int-array 100000))

(defun make-displaced-array (n displacement)
  (make-array n :displaced-to *displaced*
	      :displaced-index-offset displacement))

(deftest elt-displaced-array-1 
  (handler-case
   (elt (make-displaced-array '(0) 100) 0)
   (type-error () 'type-error)
   (error (c) c))
  type-error)

(deftest elt-displaced-array-2
  (elt (make-displaced-array '(1) 100) 0)
  100)

(deftest elt-displaced-array-3
  (elt (make-displaced-array '(5) 100) 4)
  104)

#|
(deftest elt-displaced-array-4
  (handler-case
   (make-displaced-array '(100) 100000)
   (type-error () 'type-error)
   (error (c) c))
  type-error)
|#

#|
(deftest elt-displaced-array-5
  (handler-case
   (make-displaced-array '(100) (- 100000 50))
   (type-error () 'type-error)
   (error (c) c))
  type-error)
|#