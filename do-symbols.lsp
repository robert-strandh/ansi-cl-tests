;-*- Mode:     Lisp -*-
;;;; Author:   Paul Dietz
;;;; Created:  Sat Feb 21 18:24:59 2004
;;;; Contains: Tests of DO-SYMBOLS

(in-package :cl-test)
(declaim (optimize (safety 3)))

(deftest do-symbols.1
  (equalt
   (remove-duplicates
    (sort-symbols (let ((all nil))
		    (do-symbols (x "B" all) (push x all)))))
   (list (find-symbol "BAR" "B")
	 (find-symbol "FOO" "A")))
  t)

;;
;; Test up some test packages
;;

(defun collect-symbols (pkg)
  (remove-duplicates
   (sort-symbols
    (let ((all nil))
      (do-symbols (x pkg all) (push x all))))))

(deftest do-symbols.2
    (collect-symbols "DS1")
  (DS1:A DS1:B DS1::C DS1::D))

(deftest do-symbols.3
    (collect-symbols "DS2")
  (DS2:A DS2::E DS2::F DS2:G DS2:H))

(deftest do-symbols.4
  (collect-symbols "DS3")
  (DS1:A DS3:B DS2:G DS2:H DS3:I DS3:J DS3:K DS3::L DS3::M))

(deftest do-symbols.5
  (remove-duplicates
   (collect-symbols "DS4")
   :test #'(lambda (x y)
	     (and (eqt x y)
		  (not (eqt x 'DS4::B)))))
  (DS1:A DS1:B DS2::F DS3:G DS3:I DS3:J DS3:K DS4::X DS4::Y DS4::Z))


;; Test that do-symbols works without
;; a return value (and that the default return value is nil)

(deftest do-symbols.6
  (do-symbols (s "DS1") (declare (ignore s)) t)
  nil)

;; Test that do-symbols works without a package being specified

(deftest do-symbols.7
  (let ((x nil)
	(*package* (find-package "DS1")))
    (declare (special *package*))
    (list
     (do-symbols (s) (push s x))
     (sort-symbols x)))
  (nil (DS1:A DS1:B DS1::C DS1::D)))

;; Test that the tags work in the tagbody,
;;  and that multiple statements work

(deftest do-symbols.8
  (handler-case
   (let ((x nil))
     (list
      (do-symbols
       (s "DS1")
       (when (equalt (symbol-name s) "C") (go bar))
       (push s x)
       (go foo)
       bar
       (push t x)
       foo)
      (sort-symbols x)))
   (error (c) c))
  (NIL (DS1:A DS1:B DS1::D T)))

(def-macro-test do-symbols.error.1
  (do-symbols (x "CL")))
