;-*- Mode:     Lisp -*-
;;;; Author:   Paul Dietz
;;;; Created:  Sat May 10 09:39:01 2003
;;;; Contains: Tests of SLOT-EXISTS-P

(in-package :cl-test)

;;; This function is also tested incidentally in many other files

(defclass slot-exists-p-class-01 ()
  (a (b :allocation :class) (c :allocation :instance)))

(deftest slot-exists-p.1
  (let ((obj (allocate-instance (find-class 'slot-exists-p-class-01))))
    (notnot-mv (slot-exists-p obj 'a)))
  t)
     
(deftest slot-exists-p.2
  (let ((obj (allocate-instance (find-class 'slot-exists-p-class-01))))
    (notnot-mv (slot-exists-p obj 'b)))
  t)
     
(deftest slot-exists-p.3
  (let ((obj (allocate-instance (find-class 'slot-exists-p-class-01))))
    (notnot-mv (slot-exists-p obj 'c)))
  t)

(deftest slot-exists-p.4
  (let ((obj (allocate-instance (find-class 'slot-exists-p-class-01))))
    (slot-exists-p obj 'd))
  nil)

(deftest slot-exists-p.5
  (let ((obj (allocate-instance (find-class 'slot-exists-p-class-01))))
    (slot-exists-p obj (gensym)))
  nil)

(deftest slot-exists-p.6
  (let ((obj (allocate-instance (find-class 'slot-exists-p-class-01))))
    (slot-exists-p obj nil))
  nil)

(deftest slot-exists-p.7
  (let ((obj (allocate-instance (find-class 'slot-exists-p-class-01))))
    (slot-exists-p obj t))
  nil)

;;; SLOT-EXISTS-P may be called on any object, not just on standard objects

(deftest slot-exists-p.8
  (let ((slot-name (gensym)))
    (loop for x in *universe*
	  when (slot-exists-p x slot-name)
	  collect x))
  nil)

;;; With various types

(defclass slot-exists-p-class-02 ()
  ((a :type t) (b :type nil) (c :type symbol) (d :type cons)
   (e :type float) (f :type single-float) (g :type short-float)
   (h :type double-float) (i :type long-float) (j :type char)
   (k :type base-char) (l :type rational) (m :type ratio) (n :type integer)
   (o :type fixnum) (p :type complex) (q :type condition)))

(deftest slot-exists-p.9
  (let ((obj (allocate-instance (find-class 'slot-exists-p-class-02))))
    (map-slot-exists-p* obj '(a b c d e f g h i j k l m n o p q)))
  (t t t t t t t t t t t t t t t t t))

;;; Inheritance

(defclass slot-exists-p-class-03a ()
  (a b))

(defclass slot-exists-p-class-03b ()
  (a c))

(defclass slot-exists-p-class-03c (slot-exists-p-class-03a slot-exists-p-class-03b)
  (d e))

(deftest slot-exists-p.10
  (let ((obj (allocate-instance (find-class 'slot-exists-p-class-03c))))
    (map-slot-exists-p* obj '(a b c d e f g)))
  (t t t t t nil nil))

;;; SLOT-EXISTS-P is supposed to work on structure objects and condition objects

(defstruct slot-exists-p-struct-01
  a b c)

(deftest slot-exists-p.11
  (let ((obj (make-slot-exists-p-struct-01)))
    (map-slot-exists-p* obj '(a b c z nil)))
  (t t t nil nil))

(deftest slot-exists-p.12
  (let ((obj (make-slot-exists-p-struct-01 :a 1 :b 2 :c 3)))
    (map-slot-exists-p* obj '(a b c z nil)))
  (t t t nil nil))

(defstruct (slot-exists-p-struct-02 (:include slot-exists-p-struct-01))
  d e)
    
(deftest slot-exists-p.13
  (let ((obj (make-slot-exists-p-struct-02)))
    (map-slot-exists-p* obj '(a b c d e f z nil)))
  (t t t t t nil nil nil))

(deftest slot-exists-p.14
  (let ((obj (make-slot-exists-p-struct-02 :a 1 :b 3 :e 5)))
    (map-slot-exists-p* obj '(a b c d e f z nil)))
  (t t t t t nil nil nil))

  
;;; SLOT-EXISTS-P is supposed to work on condition objects, too
;;; (after all, they are objects, and they have slots)

(define-condition slot-exists-p-condition-01 ()
  (a b c))

(deftest slot-exists-p.15
  (let ((obj (make-condition 'slot-exists-p-condition-01)))
    (map-slot-exists-p* obj (list 'a 'b 'c (gensym))))
  (t t t nil))

(define-condition slot-exists-p-condition-02 (slot-exists-p-condition-01)
  (a d e))

(deftest slot-exists-p.16
  (let ((obj (make-condition 'slot-exists-p-condition-02)))
    (map-slot-exists-p* obj (list 'a 'b 'c 'd 'e (gensym))))
  (t t t t t nil))

