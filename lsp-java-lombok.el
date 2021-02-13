;;; lsp-java-lombok.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2021 Kevin Ziegler
;;
;; Author: Kevin Ziegler <https://github.com/kevinziegler>
;; Maintainer: Kevin Ziegler <ziegler.kevin@heb.com>
;; Created: February 12, 2021
;; Modified: February 12, 2021
;; Version: 0.0.1
;; Homepage: https://github.com/kevinziegler/lsp-java-lombok
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

;;; lsp-java-lombok --- Set up Lombok for LSP
;;; Commentary:
;;; Helper library for setting up lombok with LSP-java
;;; Code:
(require 'lsp-java)

(defvar lsp-java-lombok-jar-url "https://projectlombok.org/downloads/lombok.jar"
  "Source URL for downloading the Lombok JAR.")

(defvar lsp-java-lombok-jar-path (concat user-emacs-directory "lombok.jar")
  "Path on disk for the Lombok jar.")

(defvar lsp-java-lombok-enabled nil
  "Indicates the LSP server should be started with Lombok.")

(defun lsp-java-lombok-download-jar ()
  "Download lombok jar for use with LSP."
  (url-copy-file lsp-java-lombok-jar-url lsp-java-lombok-jar-path))

(defun lsp-java-lombok-vmarg ()
  "Create JVM startup args to load Lombok with the LSP server."
  (concat "-javaagent:" lsp-java-lombok-jar-path))

(defun lsp-java-lombok-append-vmargs ()
  "Apply lombok args to lsp-java-vmargs."
  (setq lsp-java-vmargs (append lsp-java-vmargs (lsp-java-lombok-vmarg))))

(defun lsp-java-lombok-setup ()
  "Download Lombok if it has not been downloaded already."
  (when (not (file-exists-p lsp-java-lombok-jar-path))
    (message "Could not find lombok for lsp-java.  Downloading...")
    (lsp-java-lombok-download-jar)))

(defun lsp-java-lombok-init ()
  "Initialize lsp-java-lombok."
  (when lsp-java-lombok-enabled
    (lsp-java-lombok-setup)
    (lsp-java-lombok-append-vmargs)))

(provide 'lsp-java-lombok)
;;; lsp-java-lombok.el ends here
