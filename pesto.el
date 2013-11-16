;;; pesto.el --- Generic emacs global minor mode for sharing utils

;; Copyright (C) 2013 Patrik Kårlin

;; Author: Patrik Kårlin <patrik.karlin@gmail.com>
;; Version: 1.0.0
;; Keywords: emacs utils

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

(defun pesto-mark-line-and-down ()
  (interactive)
  (message "marking line")
  (unless mark-active
    (move-beginning-of-line 1)
    (set-mark-command nil))
  (next-line)
  (move-beginning-of-line 1))

(defun pesto-move-to-begining-of-code ()
  (interactive)
  (move-beginning-of-line 1)
  (indent-according-to-mode))

(defun pesto-insert-and-indent-after ()
  (interactive)
  (message "inserting line after")
  (move-end-of-line 1)
  (newline)
  (indent-according-to-mode))

(defun pesto-insert-and-indent-before ()
  (interactive)
  (message "inserting line before")
  (previous-line)
  (move-end-of-line 1)
  (newline)
  (indent-according-to-mode))

(defun pesto-copy-line-and-insert-after ()
  (interactive)
  (message "Coppy line and insert after")
  (let ((c (current-column)))
    (save-excursion
      (kill-whole-line)
      (yank)
      (yank))
    (next-line)
    (move-to-column c)))

(defvar pesto-mode-keymap (make-sparse-keymap))

(define-key pesto-mode-keymap (kbd "C-t")     'pesto-mark-line-and-down)
(define-key pesto-mode-keymap (kbd "C-a")     'pesto-move-to-begining-of-code)
(define-key pesto-mode-keymap (kbd "C-l")     'pesto-insert-and-indent-before)
(define-key pesto-mode-keymap (kbd "C-ö")     'pesto-insert-and-indent-after)
(define-key pesto-mode-keymap (kbd "C-c C-f") 'pesto-copy-line-and-insert-after)

(define-minor-mode pesto-mode
  :keymap pesto-mode-keymap)

(define-global-minor-mode pesto-globalized-mode pesto-mode
  (lambda () (pesto-mode 1)))

(provide 'pesto)
