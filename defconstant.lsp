;-*- Mode:     Lisp -*-
;;;; Author:   Paul Dietz
;;;; Created:  Thu Oct 10 23:05:39 2002
;;;; Contains: Tests of DEFCONSTANT

(in-package :cl-test)

(defconstant test-constant-1  17)

(deftest defconstant.1
  (symbol-value 'test-constant-1)
  17)

(deftest defconstant.2
  (not (constantp 'test-constant-1))
  nil)

(deftest defconstant.3
  (documentation 'test-constant-1 'variable)
  nil)

(defconstant test-constant-2  'a
  (if (boundp test-constant-2) test-constant-2
    "This is the documentation."))

(deftest defconstant.4
  (documentation 'test-constant-2 'variable)
  "This is the documentation.")

(deftest defconstant.5
  (defconstant test-constant-3 0)
  test-constant-3)




