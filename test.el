(require 'ert)

(ert-deftest lsp-java-lombok/test-jar-file-with-nil-version ()
  "Filename has no version information when version is nil."
  (setq-local lsp-java-lombok/version nil)
  (should (equal  "lombok.jar" (lsp-java-lombok/jar-file))))

(ert-deftest lsp-java-lombok/test-jar-file-with-version ()
  "Filename includes version when version is set."
  (setq-local lsp-java-lombok/version "1.0")
  (should (equal  "lombok-1.0.jar" (lsp-java-lombok/jar-file))))

(ert-deftest lsp-java-lombok/test-download-jar ()
  "Downloads correct Lombok jar from configured url to configured path."
  (setq-local lsp-java-lombok/jar-url-base "https://test.com")
  (setq-local lsp-java-lombok/dir "/test/path")
  (setq-local lsp-java-lombok/version "1.0")
  (cl-flet ((url-copy-file (src dest)
                           (should (equal src "https://test.com/lombok-1.0.jar"))
                           (should (equal dest "/test/path/lombok-1.0.jar")))
            (lsp-java-lombok/download-jar))))

(ert-deftest lsp-java-lombok/append-vmargs-in-home-dir ()
  "VM arg for Lombok is added correctly and resolving the path."
  (setq-local lsp-java-vmargs '(foo))
  (setq-local user-emacs-directory "~/test/lombok/")
  (lsp-java-lombok/append-vmargs)
  (should (equal
           lsp-java-vmargs
           (list 'foo (concat "-javaagent:" (getenv "HOME") "/test/lombok/lombok.jar"))))
  )
