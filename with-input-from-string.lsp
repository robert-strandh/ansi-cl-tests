;-*- Mode:     Lisp -*-
;;;; Author:   Paul Dietz
;;;; Created:  Sat Feb 14 20:13:02 2004
;;;; Contains: Tests of WITH-INPUT-FROM-STRING

(in-package :cl-test)

(deftest with-input-from-string.1
  (with-input-from-string
   (s "abc")
   (values (read-char s) (read-char s) (read-char s) (read-char s nil :eof)))
  #\a #\b #\c :eof)

(deftest with-input-from-string.2
  (with-input-from-string (s "abc"))
  nil)

(deftest with-input-from-string.3
  (with-input-from-string (s "abc") (declare (optimize speed)))
  nil)

(deftest with-input-from-string.4
  (with-input-from-string
   (s "abc")
   (declare (optimize safety))
   (read-char s)
   (read-char s))
  #\b)

(deftest with-input-from-string.5
  (let ((i nil))
    (values
     (with-input-from-string
      (s "abc" :index i))
     i))
  nil 0)

(deftest with-input-from-string.6
  (let ((i (list nil)))
    (values
     (with-input-from-string
      (s "abc" :index (car i)))
     i))
  nil (0))

(deftest with-input-from-string.7
  (let ((i nil))
    (values
     (with-input-from-string
      (s "abc" :index i)
      (list i (read-char s) i (read-char s) i))
     i))
  (nil #\a nil #\b nil) 2)

(deftest with-input-from-string.9
  (with-input-from-string
   (s "abc")
   (values
    (notnot (typep s 'stream))
    (notnot (typep s 'string-stream))
    (notnot (open-stream-p s))
    (notnot (input-stream-p s))
    (output-stream-p s)))
  t t t t nil)

(deftest with-input-from-string.10
  :notes (:nil-vectors-are-strings)
  (with-input-from-string
   (s (make-array 0 :element-type nil))
   (values
    (notnot (typep s 'stream))
    (notnot (typep s 'string-stream))
    (notnot (open-stream-p s))
    (notnot (input-stream-p s))
    (output-stream-p s)))
  t t t t nil)

(deftest with-input-from-string.11
  (with-input-from-string
   (s (make-array 3 :element-type 'character :initial-contents "abc"))
   (values
    (notnot (typep s 'stream))
    (notnot (typep s 'string-stream))
    (notnot (open-stream-p s))
    (notnot (input-stream-p s))
    (output-stream-p s)
    (read-line s)))
  t t t t nil "abc")

(deftest with-input-from-string.12
  (with-input-from-string
   (s (make-array 3 :element-type 'base-char :initial-contents "abc"))
   (values
    (notnot (typep s 'stream))
    (notnot (typep s 'string-stream))
    (notnot (open-stream-p s))
    (notnot (input-stream-p s))
    (output-stream-p s)
    (read-line s)))
  t t t t nil "abc")

(deftest with-input-from-string.13
  (with-input-from-string
   (s "abcdef" :start 2)
   (values
    (notnot (typep s 'stream))
    (notnot (typep s 'string-stream))
    (notnot (open-stream-p s))
    (notnot (input-stream-p s))
    (output-stream-p s)
    (read-line s)))
  t t t t nil "cdef")

(deftest with-input-from-string.14
  (with-input-from-string
   (s "abcdef" :end 3)
   (values
    (notnot (typep s 'stream))
    (notnot (typep s 'string-stream))
    (notnot (open-stream-p s))
    (notnot (input-stream-p s))
    (output-stream-p s)
    (read-line s)))
  t t t t nil "abc")

(deftest with-input-from-string.15
  (with-input-from-string
   (s "abcdef" :start 1 :end 5)
   (values
    (notnot (typep s 'stream))
    (notnot (typep s 'string-stream))
    (notnot (open-stream-p s))
    (notnot (input-stream-p s))
    (output-stream-p s)
    (read-line s)))
  t t t t nil "bcde")

(deftest with-input-from-string.16
  (with-input-from-string
   (s "abcdef" :start 1 :end nil)
   (values
    (notnot (typep s 'stream))
    (notnot (typep s 'string-stream))
    (notnot (open-stream-p s))
    (notnot (input-stream-p s))
    (output-stream-p s)
    (read-line s)))
  t t t t nil "bcdef")

(deftest with-input-from-string.17
  (let ((i 2))
    (values
     (with-input-from-string
      (s "abcdef" :index i :start i)
      (read-char s))
     i))
  #\c 3)

;;; Test that there is no implicit tagbody

(deftest with-input-from-string.18
  (block done
    (tagbody
     (with-input-from-string
      (s "abc")
      (go 1)
      1
      (return-from done :bad))
     1
     (return-from done :good)))
  :good)

;;; FIXME: Add more tests on specialized strings.

