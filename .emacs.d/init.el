;; 基础配置
;; 禁用启动画面
(setq inhibit-startup-message t)

;; 禁用工具栏和滚动条
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; 显示行号
(global-display-line-numbers-mode t)

;; 高亮当前行
(global-hl-line-mode t)

;; 自动加载更改过的文件
(global-auto-revert-mode t)

;; 启用语法高亮
(global-font-lock-mode t)

;; 更改默认字体大小
;; 设置默认字体
(set-face-attribute 'default nil
                    :family "0xProto Nerd Font"  ;; 字体名称
                    :height  120              ;; 字体大小（以1/10 pt为单位）
                    :weight 'normal           ;; 字体粗细
                    :width 'normal)           ;; 字体宽度

;; 自动补全括号
(electric-pair-mode t)
;; ==================================================================


;; ==================================================================
;; 插件管理器
;; 添加源
(require 'package)
(setq package-archives '(("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
              ("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
              ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")))

;; 安装use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; 使用use-package
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)
;; =====================================================================



;; ======================================================================
;; 常用插件

;; Evil，Vim模式
(use-package evil
  :ensure t
  :config
  (evil-mode 1))

;; -----------------------------------------------------------------------

;; treemacs，文件目录树管理器
(use-package treemacs
  :ensure t
  :config
  (progn
    ;; 启用 Treemacs
    (setq treemacs-space-between-root-nodes nil)
    (setq treemacs-width 30)
    (setq treemacs-follow-mode t)
    (setq treemacs-project-follow-mode t)
    (setq treemacs-filewatch-mode t)
    (setq treemacs--glyph-width 2)))
;; 绑定快捷键打开Treemacs
(global-set-key (kbd "C-x K") 'treemacs) ;; 使用M-x eval-buffer，加载快捷键设置

;; --------------------------------------------------------------------------

;; 图标主题
;; all-the-icons
(use-package all-the-icons
 :ensure t)
 ;; (all-the-icons-install-fonts t) ;; 安装字体

;; -----------------------------------------------------------------------------

(use-package projectile
  :ensure t
  :init
  ;; 默认开启 projectile 模式
  (projectile-mode +1)
  ;; 推荐使用 'alien' 模式，更快的项目索引
  (setq projectile-indexing-method 'alien)
  ;; 设置缓存
  (setq projectile-enable-caching t))
;; ======================================================================






;; =========================================================================
;; 外观美化
;; 主题
;;Doot-theme
(use-package doom-themes
  :ensure t
  :config
  ;; 启用喜欢的主题
  (load-theme 'doom-dark+ t)

  ;; 全局设置
  (setq doom-themes-enable-bold t    ; 如果为nil, 则普遍禁用粗体
        doom-themes-enable-italic t) ; 如果为nil, 则普遍禁用斜体
  ;; 当前行高亮
  (doom-themes-visual-bell-config)
  ;; 出错时启用闪烁模式
  (doom-themes-visual-bell-config)
  ;; 或对于treemacs用户
  (setq doom-themes-treemacs-theme "doom-atom") ; 使用‘doom-colors’获取得更少的极简图标主题
  (doom-themes-treemacs-config)
  ;; 更正（改进）org-mode的原生字体
  (doom-themes-org-config))

;; --------------------------------------------------------------------------------

;; 状态栏
;; spaceline
(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
  ;; spaceline主题
  (spaceline-spacemacs-theme)
  ;; 启用版本控制信息
  (spaceline-toggle-version-control-on))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(dashboard centaur-tabs highlight-indent-guides spaceline treemacs evil doom-themes all-the-icons)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; 自定义组件
  (setq spaceline-custom-theme
        '((anzu :face highlight-face)
          (buffer-id :face buffer-id-face)
          (major-mode :face mode-line-major-mode-face)
          (process :face mode-line-process-face)
          (git :face git-face)))
  
  ;; 启用 all-the-icons
  (setq spaceline-all-the-icons t)

;; -----------------------------------------------------------------------------

;; 安装和配置 highlight-indent-guides 插件
(use-package highlight-indent-guides
  :ensure t
  :init
  ;; 配置缩进引导的显示样式，可以是 'fill、'column 或 'character
  (setq highlight-indent-guides-method 'character)
  :config
  ;; 自动在所有编程模式中启用
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode))

;; 如果你希望在文本模式中也启用，可以添加以下代码
  (add-hook 'text-mode-hook 'highlight-indent-guides-mode)

;; -------------------------------------------------------------------------------
;; ;; Emacs仪表盘(dashboard)
;; 安装并配置 dashboard 插件
(use-package dashboard
  :ensure t
  :config
  ;; 设置仪表板标题
  (setq dashboard-banner-logo-title "Welcome to Emacs!")
  
  ;; 设置启动页展示的内容
  (setq dashboard-startup-banner "/home/wuwei/.emacs.d/image/Emacs.svg") ;; 使用 Emacs 官方 logo
  ;; 也可以使用自己的图片，例如： (setq dashboard-startup-banner "/path/to/your/image.png")

  ;; 配置显示项目
  (setq dashboard-items '((recents  . 5) ;; 最近打开的文件
                          (projects . 5) ;; 最近访问的项目
                          (agenda . 5) ;; 日历
                          (bookmarks . 5) ;; 书签
                          (registers . 5))) ;; 寄存器

  ;; 配置仪表板的显示设置
  (dashboard-setup-startup-hook))

;; -------------------------------------------------------------------------------
;; 标签
(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t)
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward))

;; 加载 Centaur Tabs
(require 'centaur-tabs)
(centaur-tabs-mode t)

;; 显示图标
(setq centaur-tabs-set-icons t)
