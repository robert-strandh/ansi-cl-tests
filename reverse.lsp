;-*- Mode:     Lisp -*-
;;;; Author:   Paul Dietz
;;;; Created:  Tue Aug 20 23:47:28 2002
;;;; Contains: Tests for REVERSE

(in-package :cl-test)

(deftest reverse-list.1
  (reverse nil)
  nil)

(deftest reverse-list.2
  (let ((x '(a b c)))
    (values (reverse x) x))
  (c b a)
  (a b c))

(deftest reverse-vector.1
  (reverse #())
  #())

(deftest reverse-vector.2
  (let ((x #(a b c d e)))
    (values (reverse x) x))
  #(e d c b a)
  #(a b c d e))

(deftest reverse-nonsimple-vector.1
  (let ((x (make-array 0 :fill-pointer t :adjustable t)))
    (reverse x))
  #())

(deftest reverse-nonsimple-vector.2
  (let* ((x (make-array 5 :initial-contents '(1 2 3 4 5)
			:fill-pointer t :adjustable t))
	 (y (reverse x)))
    (values y x))
  #(5 4 3 2 1)
  #(1 2 3 4 5))

(deftest reverse-nonsimple-vector.3
  (let* ((x (make-array 10 :initial-contents '(1 2 3 4 5 6 7 8 9 10)
			:fill-pointer 5))
	 (y (reverse x)))
    y)
  #(5 4 3 2 1))

(deftest reverse-bit-vector.1
  (reverse #*)
  #*)

(deftest reverse-bit-vector.2
  (let ((x #*000110110110))
    (values (reverse x) x))
  #*011011011000
  #*000110110110)

(deftest reverse-bit-vector.3
  (let* ((x (make-array 10 :initial-contents '(0 0 0 1 1 0 1 0 1 0)
			:fill-pointer 5
			:element-type 'bit))
	 (y (reverse x)))
    y)
  #*11000)

(deftest reverse-string.1
  (reverse "")
  "")

(deftest reverse-string.2
  (let ((x "000110110110"))
    (values (reverse x) x))
  "011011011000"
  "000110110110")

(deftest reverse-string.3
  (let* ((x (make-array 10 :initial-contents (coerce "abcdefghij" 'list)
			:fill-pointer 5
			:element-type 'character))
	 (y (reverse x)))
    y)
  "edcba")

(deftest reverse-string.4
  (let* ((x (make-array 10 :initial-contents (coerce "abcdefghij" 'list)
			:fill-pointer 5
			:element-type 'base-char))
	 (y (reverse x)))
    y)
  "edcba")

(deftest reverse-error.1
  (catch-type-error (reverse 'a))
  type-error)

(deftest reverse-error.2
  (catch-type-error (reverse #\a))
  type-error)

(deftest reverse-error.3
  (catch-type-error (reverse 10))
  type-error)

(deftest reverse-error.4
  (catch-type-error (reverse 0.3))
  type-error)

(deftest reverse-error.5
  (catch-type-error (reverse 10/3))
  type-error)

	 





