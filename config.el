;;; private/stella/config.el -*- lexical-binding: t; -*-

;; evil key-bindings via hlissner
(when (featurep! :feature evil)
  (load! +bindings)  ; my key bindings
;  (load! +commands)) ; my custom ex commands
  )

;(setq doom-font (font-spec :family "Source Code Pro" :size 16))

;; set Chinese fonts not using chinese layer, same to chinese-fonts-setup, cnfonts
(set-frame-font "Source Code Pro")
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset (font-spec :family "Source Han Sans CN" :size 20)))

;; set face-attribute font, disabling in default theme
(set-face-attribute 'font-lock-function-name-face nil :weight 'bold)
(set-face-attribute 'font-lock-type-face nil :weight 'semi-bold :slant 'italic)
(set-face-attribute 'font-lock-comment-face nil :slant 'italic)
;; (set-face-attribute 'font-lock-string-face nil :foreground '"forest green")

;; ace-pinyin
(def-package! ace-pinyin
  :config
  ;; (setq ace-pinyin-use-avy nil) ;; uncomment if you want to use `ace-jump-mode
  (ace-pinyin-global-mode +1)
  ;; (setq ace-pinyin-simplified-chinese-only-p nil)
  )

;; bing-dict
(def-package! bing-dict
  :config
  (setq bing-dict-show-thesaurus 'both)
  ;; (setq bing-dict-pronunciation-style 'uk)
  )

;; pangu-spacing
(def-package! pangu-spacing
  :config
  (global-pangu-spacing-mode 1)
  ;; (setq pangu-spacing-real-insert-separtor t)
  )

(add-hook! (org-mode markdown-mode)
  (set (make-local-variable 'pangu-spacing-real-insert-separtor) t)
  )

(add-hook! LaTeX-mode
  (setq truncate-lines nil)  ;; truncate lines ignore words
  )

;; -*- key bindings

(map!

 :n ";" #'comment-line
 :v ";" #'comment-or-uncomment-region
 :n "C-j" #'doom/newline-and-indent
 :n "M-g" #'magit-status
 :n "f" #'evil-avy-goto-char

 (:leader

   (:desc "Previous Buffer" :nv "TAB" #'doom/previous-buffer)

   (:desc "buffer" :prefix "b"
     :desc "Switch buffer" :n "b" #'switch-to-buffer)

   ;; (:desc "git" :prefix "g"
   ;;   :desc "Git status" :n "s" #'magit-status)

   (:desc "help" :prefix "h"
     :n "h" help-map
     :desc "Bing Dict" :nv "b" #'bing-dict-brief)

   (:desc "window" :prefix "w"
     :desc "Max Window" :n "m" #'delete-other-windows)

   )

 (:after org
   (:map org-mode-map
     :nv "C-e" #'evil-end-of-visual-line
     :nv "j" #'evil-next-visual-line
     :nv "k" #'evil-previous-visual-line))

 )
