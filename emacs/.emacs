(setq load-path (cons (expand-file-name "~/.emacs.d")
 load-path))
;配色方案
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")
(require 'color-theme)
(color-theme-initialize)
(color-theme-dark-blue2)
;charcoal Black、Midnight、subtle Hacker
;; 背景和字体颜色
(set-foreground-color "gainsboro")
(set-background-color "grey30")
(set-border-color "black")
;; 语法高亮显示，区域选择，二次选择 ;;前景和背景色
(set-face-foreground 'highlight "white")
(set-face-background 'highlight "blue")
(set-face-foreground 'region "cyan")
(set-face-background 'region "blue")
(set-face-foreground 'secondary-selection "skyblue")
(set-face-background 'secondary-selection "darkblue")
;不要那个如此大的工具条
(tool-bar-mode -1)
;;禁用滚动栏，用鼠标滚轮代替
(scroll-bar-mode nil)
;设置字体
(set-default-font "Monospace-11")
;显示时间
(display-time)
;时间使用24小时制
(setq display-time-24hr-format t)
;时间显示包括日期和具体时间
(setq display-time-day-and-date t)
;光标移动到鼠标下时，鼠标自动弹开
(mouse-avoidance-mode 'animate) 
;显示行号
(global-linum-mode t)
;默认目录
(setq default-directory "~/")
;高亮当前行
;(require 'hl-line)
;(global-hl-line-mode t)
;开启语法高亮。
(global-font-lock-mode 1)
;;只渲染当前屏幕语法高亮，加快显示速度
(setq font-lock-maximum-decoration t)
;显示匹配的括号
(show-paren-mode t)
;匹配括号的时候, 不要跳到另一个括号那里
(setq show-paren-style 'parentheses)
;高亮显示要拷贝的区域
(transient-mark-mode t)
;允许emacs和外部其他程式的粘贴
(setq x-select-enable-clipboard t)
;支持中键粘贴
(setq mouse-yank-at-point t)
;当光标在行尾上下移动的时候，始终保持在行尾。
(setq track-eol t)
(setq default-fill-column 78);默认显示 80列就换行
;;使用 y or n 提问
(fset 'yes-or-no-p 'y-or-n-p)
;;;;备份策略
;配置备份文档的路径
(setq backup-directory-alist '(("" . "~/.emacs.d/auto-save-list/")))
;不要生成临时文件
(setq-default make-backup-files nil)
;生成临时文件
;(setq-default make-backup-file t)
;(setq make-backup-file t)
;(setq make-backup-files t)
;启用版本控制，即能够备份多次
(setq version-control t)
;备份最原始的版本两次,即第一次编辑前的文档，和第二次编辑前的文档
(setq kept-old-versions 2)
;备份最新的版本10次，理解同上
(setq kept-new-versions 3)
;删掉不属于以上版本的版本
(setq delete-old-versions t)
;自动存盘
(setq auto-save-mode t)
;击键100次自动保存
(setq auto-save-interval 100)
;改变emacs标题栏的标题
(setq frame-title-format "%f@Athena")

;===== 代码补全 auto-complete =====
(add-to-list 'load-path "/home/xxxcjr/.emacs.d/auto-complete-1.3.1")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/home/xxxcjr/.emacs.d/auto-complete-1.3.1/ac-dict")
(ac-config-default)

;;; emms设置
;;; 来自：The Emacs Multimedia System http://lifegoo.pluskid.org/wiki/Emacs.html
(add-to-list 'load-path
             (expand-file-name "~/.emacs.d/emms-3.0"))

(require 'emms-source-file)
(require 'emms-source-playlist)
(require 'emms-player-simple)
(require 'emms-player-mplayer)
(require 'emms-playlist-mode)
(require 'emms-info)
(require 'emms-cache)
(require 'emms-mode-line)
(require 'emms-playing-time)
(require 'emms-score)
(require 'emms-volume)

(setq emms-playlist-default-major-mode 'emms-playlist-mode)
(add-to-list 'emms-track-initialize-functions 'emms-info-initialize-track)
(add-to-list 'emms-info-functions 'kid-emms-info-simple)
(setq emms-track-description-function 'kid-emms-info-track-description)
(when (fboundp 'emms-cache)
  (emms-cache 1))

(setq emms-player-list
      '(emms-player-mplayer
        emms-player-mpg321
        emms-player-ogg123))

(setq emms-info-asynchronously nil)
(setq emms-playlist-buffer-name "*Music*")
;; use faster finding facility if you have GNU find
(setq emms-source-file-directory-tree-function 'emms-source-file-directory-tree-find)

;;; My musics
(setq emms-source-file-default-directory "~/music")

(add-hook 'emms-player-started-hook 'emms-show)

;; mode line format
(setq emms-mode-line-format "[ %s "
      emms-playing-time-display-format "%s ]")
(setq global-mode-string
      '("" emms-mode-line-string " " emms-playing-time-string))

;;kid-emms-info-simple 函数，仅仅根据文件名来解析出歌手和歌 名
(defun kid-emms-info-simple (track)
"Get info from the filename.
mp3 标签的乱码问题总是很严重，幸好我系统里面的音乐文件
都放得比较有规律，所以我决定直接从文件名获取标签信息。"
  (when (eq 'file (emms-track-type track))
    (let ((regexp "/\\([^/]+\\)/\\([^/]+\\)\\.[^.]+$")
          (name (emms-track-name track)))
      (if (string-match regexp name)
          (progn
            (emms-track-set track 'info-artist (match-string 1 name))
            (emms-track-set track 'info-title (match-string 2 name)))
          (emms-track-set track
                          'info-title
                          (file-name-nondirectory name))))))

;; emms-track-description-function 函数显示播放列表
(defun kid-emms-info-track-description (track)
  "Return a description of the current track."
  (let ((artist (emms-track-get track 'info-artist))
        (title (emms-track-get track 'info-title)))
    (format "%-10s +| %s"
            (or artist
                "")
            title)))

;;;emms快捷键设置
(global-set-key (kbd "C-c e l") 'emms-playlist-mode-go)
(global-set-key (kbd "C-c e s") 'emms-start)
(global-set-key (kbd "C-c e e") 'emms-stop)
(global-set-key (kbd "C-c e n") 'emms-next)
(global-set-key (kbd "C-c e p") 'emms-pause)
(global-set-key (kbd "C-c e f") 'emms-play-playlist)
(global-set-key (kbd "C-c e o") 'emms-play-file)
(global-set-key (kbd "C-c e d") 'emms-play-directory-tree)
(global-set-key (kbd "C-c e a") 'emms-add-directory-tree)


;;设置mpg123
(add-to-list 'load-path "~/.emacs.d/")
(require 'mpg123)

;;设定shell为bash
(setq shell-file-name "/bin/bash")
;;开启shell的颜色支持
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on t)
;;设置快捷键
(global-set-key (kbd "C-c z") 'ansi-term)
(global-set-key (kbd "<f10>") 'rename-buffer)

;; 设置 org-mode
(add-to-list 'load-path "~/.emacs.d/org-7.5/")
(require 'org)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
;只高亮显示最后一个代表层级的*
(setq org-hide-lcading-stars t)
;给已完成事项打上时间
(setq org-log-done ' time)


;; w3m上网设置
;; http://emacser.com/w3m.htm
(require 'w3m)
(require 'w3m-lnum)
(require 'util)
 
(defvar w3m-buffer-name-prefix "*w3m" "Name prefix of w3m buffer")
(defvar w3m-buffer-name (concat w3m-buffer-name-prefix "*") "Name of w3m buffer")
(defvar w3m-bookmark-buffer-name (concat w3m-buffer-name-prefix "-bookmark*") "Name of w3m buffer")
(defvar w3m-dir (concat my-emacs-lisps-path "emacs-w3m/") "Dir of w3m.")
 
(setq w3m-command-arguments '("-cookie" "-F"))
(setq w3m-use-cookies t)
(setq w3m-icon-directory (concat w3m-dir "icons"))
(setq w3m-use-mule-ucs t)
(setq w3m-home-page "http://www.google.cn")  ;;设置主页
(setq w3m-default-display-inline-images t)
 
(defun w3m-settings ()
  (make-local-variable 'hl-line-face)
  (setq hl-line-face 'hl-line-nonunderline-face)
  (setq hl-line-overlay nil)
  (color-theme-adjust-hl-line-face))
 
(add-hook 'w3m-mode-hook 'w3m-settings)
 
(defun w3m-save-current-buffer ()
  "Save current w3m buffer."
  (interactive)
  (save-excursion
    (mark-whole-buffer)
    (call-interactively 'copy-region-as-kill-nomark))
  (with-temp-buffer
    (call-interactively 'yank)
    (call-interactively 'write-file)))
 
(defun w3m-print-current-url ()
  "Display current url."
  (interactive)
  (w3m-message "%s" (w3m-url-readable-string w3m-current-url)))
 
(defun w3m-copy-current-url ()
  "Display the current url in the echo area and put it into `kill-ring'."
  (interactive)
  (when w3m-current-url
    (let ((deactivate-mark nil))
      (kill-new w3m-current-url)
      (w3m-print-current-url))))
 
(defun view-w3m-bookmark ()
  "View w3m bokmark."
  (interactive)
  (let ((buffer (get-buffer w3m-bookmark-buffer-name)))
    (if buffer
        (switch-to-buffer buffer)
      (with-current-buffer (get-buffer-create w3m-bookmark-buffer-name)
        (w3m-mode)
        (w3m-bookmark-view)))))
 
(defun switch-to-w3m ()
  "Switch to *w3m* buffer."
  (interactive)
  (let ((buffer (get-buffer w3m-buffer-name)))
    (if buffer
        (switch-to-buffer buffer)
      (message "Could not found w3m buffer."))))
 
(defun w3m-browse-current-buffer ()
  "Use w3m browser current buffer."
  (interactive)
  (w3m-browse-buffer))
 
(defun w3m-browse-buffer (&optional buffer)
  "Use w3m browser buffer BUFFER."
  (interactive "bBuffer to browse use w3m: ")
  (unless buffer (setq buffer (current-buffer)))
  (let* ((file (buffer-file-name buffer))
         (name (buffer-name buffer)))
    (if file
        (w3m-goto-url-new-session file)
      (with-current-buffer buffer
        (save-excursion
          (mark-whole-buffer)
          (call-interactively 'copy-region-as-kill-nomark)))
      (let* ((new-name
              (concat
               w3m-buffer-name-prefix
               "-"
               (if (string= "*" (substring name 0 1))
                   (substring name 1)
                 (concat name "*"))))
             (new-buffer (get-buffer-create new-name)))
        (switch-to-buffer new-buffer)
        (call-interactively 'yank)
        (w3m-buffer)
        (w3m-mode)
        (setq w3m-current-title (buffer-name))))))
 
;; fix small bug about of `w3m-auto-show'
;; see my-blog/emacs/w3m-auto-show-bug.htm
(defun w3m-auto-show ()
  "Scroll horizontally so that the point is visible."
  (when (and truncate-lines
             w3m-auto-show
             (not w3m-horizontal-scroll-done)
             (not (and (eq last-command this-command)
                       (or (eq (point) (point-min))
                           (eq (point) (point-max)))))
             (or (memq this-command '(beginning-of-buffer end-of-buffer))
                 (string-match "\\`i?search-"
                               (if (symbolp this-command) (symbol-name this-command) ""))
                 (and (markerp (nth 1 w3m-current-position))
                      (markerp (nth 2 w3m-current-position))
                      (>= (point)
                          (marker-position (nth 1 w3m-current-position)))
                      (<= (point)
                          (marker-position (nth 2 w3m-current-position))))))
    (w3m-horizontal-on-screen))
  (setq w3m-horizontal-scroll-done nil))
 
(defun w3m-link-numbering (&rest args)
  "Make overlays that display link numbers."
  (when w3m-link-numbering-mode
    (save-excursion
      (goto-char (point-min))
      (let ((i 0)
            overlay num)
        (catch 'already-numbered
          (while (w3m-goto-next-anchor)
            (when (get-char-property (point) 'w3m-link-numbering-overlay)
              (throw 'already-numbered nil))
            (setq overlay (make-overlay (point) (1+ (point)))
                  num (format "[%d]" (incf i)))
            (w3m-static-if (featurep 'xemacs)
                (progn
                  (overlay-put overlay 'before-string num)
                  (set-glyph-face (extent-begin-glyph overlay)
                                  'w3m-link-numbering))
              (w3m-add-face-property 0 (length num) 'w3m-link-numbering num)
              (overlay-put overlay 'before-string num)
              (overlay-put overlay 'evaporate t))
            (overlay-put overlay 'w3m-link-numbering-overlay i)))))))
 
(apply-define-key
 global-map
 `(("M-M"     w3m-goto-url-new-session)
   ("C-x M-B" view-w3m-bookmark)
   ("C-x M-m" switch-to-w3m)))
 
(apply-define-key
 w3m-mode-map
  `(("<backtab>" w3m-previous-anchor)
    ("n"         w3m-next-anchor)
    ("p"         w3m-previous-anchor)
    ("w"         w3m-next-form)
    ("b"         w3m-previous-form)
    ("f"         w3m-go-to-linknum)
    ("M-n"       w3m-next-buffer)
    ("M-p"       w3m-previous-buffer)
    ("C-k"       kill-this-buffer)
    ("C-k"       w3m-delete-buffer)
    ("C-c 1"     w3m-delete-other-buffers)
    ("1"         delete-other-windows)
    ("C-x C-s"   w3m-save-current-buffer-sb)
    ("P"         w3m-print-current-url)
    ("U"         w3m-print-this-url)
    ("c"         w3m-copy-current-url)
    ("g"         w3m-goto-url-new-session)
    ("G"         w3m-goto-url)
    ("d"         w3m-download-this-url-sb)
    ("M-d"       w3m-download-sb)
    ("s"         w3m-search)
    ("S"         w3m-history)
    ("u"         View-scroll-page-backward)
    ("J"         roll-down)
    ("K"         roll-up)
    ("o"         other-window)
    ("m"         w3m-view-this-url-new-session)
    ("C-h"       w3m-view-previous-page)
    ("F"         w3m-view-next-page)
    ("C-;"       w3m-view-next-page)
    ("r"         w3m-reload-this-page)
    ("v"         w3m-bookmark-view-new-session)
    ("M-e"       w3m-bookmark-edit)
    ("'"         switch-to-other-buffer)))
