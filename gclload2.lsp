;;; Load individual test files

;;; Tests of symbols
(load "cl-symbols.lsp")

;;; Tests of evaluation and compilation
(load "compile.lsp")

;;; Tests of data and control flow

(load "places.lsp")
(load "call-arguments-limit.lsp")
(load "constantly.lsp")
(load "complement.lsp")
(load "defconstant.lsp")
(load "defparameter.lsp")
(load "defvar.lsp")
(load "destructuring-bind.lsp")
(load "fboundp.lsp")
(load "flet.lsp")
(load "fmakunbound.lsp")
(load "funcall.lsp")
(load "function.lsp")
(load "functionp.lsp")
(load "labels.lsp")
(load "lambda-list-keywords.lsp")
(load "lambda-parameters-limit.lsp")
(load "macrolet.lsp")

;;; Tests of conses

(load "cons-test-01.lsp")
(load "cons-test-02.lsp")
(load "cons-test-03.lsp")
(load "cons-test-04.lsp")
(load "cons-test-05.lsp")
(load "cons-test-06.lsp")
(load "cons-test-07.lsp")
(load "cons-test-08.lsp")
(load "cons-test-09.lsp")
(load "cons-test-10.lsp")
(load "cons-test-11.lsp")
(load "cons-test-12.lsp")
(load "cons-test-13.lsp")
(load "cons-test-14.lsp")
(load "cons-test-15.lsp")
(load "cons-test-16.lsp")
(load "cons-test-17.lsp")
(load "cons-test-18.lsp")
(load "cons-test-19.lsp")
(load "cons-test-20.lsp")
(load "cons-test-21.lsp")
(load "cons-test-22.lsp")
(load "cons-test-23.lsp")
(load "cons-test-24.lsp")
(load "cons-test-25.lsp")

;;; Tests of packages

(load "packages.lsp")

;;; Tests of sequences

;;; (load "copy-seq.lsp")
;;; (load "elt.lsp")
;;; (load "fill.lsp")
(load "fill-strings.lsp")
(load "make-sequence.lsp")
;;; (load "subseq.lsp")
(load "map.lsp")
(load "map-into.lsp")
(load "reduce.lsp")
(load "count.lsp")
(load "count-if.lsp")
(load "count-if-not.lsp")
(load "reverse.lsp")
(load "nreverse.lsp")
(load "sort.lsp")
(load "find.lsp")
(load "find-if.lsp")
(load "find-if-not.lsp")
(load "position.lsp")
(compile-and-load "search-aux.lsp")
(load "search-list.lsp")
(load "search-vector.lsp")
(load "search-bitvector.lsp")
(load "search-string.lsp")
(load "mismatch.lsp")
(load "replace.lsp")
(load "substitute.lsp")
(load "substitute-if.lsp")
(load "substitute-if-not.lsp")
(load "nsubstitute.lsp")
(load "nsubstitute-if.lsp")
(load "nsubstitute-if-not.lsp")
(load "concatenate.lsp")
(load "merge.lsp")
(compile-and-load "remove-aux.lsp")
(load "remove.lsp")  ;; also related funs
(compile-and-load "remove-duplicates-aux.lsp")
(load "remove-duplicates.lsp")  ;; also delete-duplicates

;;; Tests of structures

(load "structure-00.lsp")
(load "structures-01.lsp")
(load "structures-02.lsp")

;;; Tests of types and classes

(load "types-and-class.lsp")

;;; Tests of the reader

(load "reader-test.lsp")

;;; Tests of strings

(load "char-schar.lsp")
(load "string.lsp")
(load "string-upcase.lsp")
(load "string-downcase.lsp")
(load "string-capitalize.lsp")
(load "nstring-upcase.lsp")
(load "nstring-downcase.lsp")
(load "nstring-capitalize.lsp")
(load "string-trim.lsp")
(load "string-left-trim.lsp")
(load "string-right-trim.lsp")

;;; Tests of string comparison functions
(compile-and-load "string-aux.lsp")
(load "string-comparisons.lsp")
(load "make-string.lsp")

;;; Tests for character functions
(compile-and-load "char-aux.lsp")
(load "character.lsp")
(load "char-compare.lsp")
