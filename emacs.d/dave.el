
;;---------------------------------------------------------------------
;; Functions for window sizing.
;;---------------------------------------------------------------------

;; Window sizing goop (for maximization)
(defcustom mf-display-padding-width 0
  "*Any extra display padding that you want to account for while
determining the maximize number of columns to fit on a display"
  :type 'integer
  :group 'maxframe)

;; The default accounts for a Mac OS X display with a menubar
;; height of 22 pixels, a titlebar of 23 pixels, and no dock.
(defcustom mf-display-padding-height -8 ;; (+ 22 23)
  "*Any extra display padding that you want to account for while
determining the maximize number of rows to fit on a display"
  :type 'integer
  :group 'maxframe)

(defun mf-set-frame-pixel-size (frame width height)
  "Sets size of FRAME to WIDTH by HEIGHT, measured in pixels."
  (set-frame-size frame (mf-max-columns width) (mf-max-rows height)))

(defun mf-max-columns (width)
  "Calculates the maximum number of columns that can fit in
pixels specified by WIDTH."
  (let ((scroll-bar (or (frame-parameter nil 'scroll-bar-width) 0))
        (left-fringe (or left-fringe-width (nth 0 (window-fringes))
0))
        (right-fringe (or right-fringe-width (nth 1 (window-fringes))
0)))
    (/ (- width scroll-bar left-fringe right-fringe
          mf-display-padding-width)
       (frame-char-width))))

(defun mf-max-rows (height)
  "Calculates the maximum number of rows that can fit in pixels
specified by HEIGHT."
  (/ (- height
        mf-display-padding-height)
     (frame-char-height)))

(defun dave-maximize-frame ()
        "Maximize the current frame (x or mac only)"
        (interactive)
        (mf-set-frame-pixel-size (selected-frame) (display-pixel-width)
(display-pixel-height))
        (set-frame-position (selected-frame) 0 0))


;;---------------------------------------------------------------------
;; Functions for font sizing. (Apple - and Apple +)
;;---------------------------------------------------------------------

(defun dave-increase-default-font-size-for-frame (frame)
        (let*
                (
                        (current-frame-width (frame-pixel-width frame))
                        (current-frame-height (frame-pixel-height frame))
                )
                (set-face-attribute 'default frame :height (+ (face-attribute
'default :height) 10))
                (mf-set-frame-pixel-size frame current-frame-width 
current-frame-
height)
        )
)

(defun less-frame-width (frame)
  (set-frame-size frame (- (frame-width frame) 1) (frame-height
frame))
  (let* ((new-frame-pixel-width (frame-pixel-width frame)))
        (set-frame-size frame (+ (frame-width frame) 1) (frame-height frame))
        new-frame-pixel-width
        ))

(defun more-frame-width (frame)
  (set-frame-size frame (+ (frame-width frame) 1) (frame-height
frame))
  (let* ((new-frame-pixel-width (frame-pixel-width frame)))
        (set-frame-size frame (- (frame-width frame) 1) (frame-height frame))
        new-frame-pixel-width
        ))

(defun less-frame-height (frame)
  (set-frame-size frame (frame-width frame) (- (frame-height frame)
1))
  (let* ((new-frame-pixel-height (frame-pixel-height frame)))
        (set-frame-size frame (frame-width frame) (+ (frame-height frame) 1))
        new-frame-pixel-height
        ))

(defun more-frame-height (frame)
  (set-frame-size frame (frame-width frame) (+ (frame-height frame)
1))
  (let* ((new-frame-pixel-height (frame-pixel-height frame)))
        (set-frame-size frame (frame-width frame) (- (frame-height frame) 1))
        new-frame-pixel-height
        ))

(defun dave-decrease-default-font-size-for-frame (frame)
        (let*
                (
                        (current-frame-width (frame-pixel-width frame))
                        (current-frame-height (frame-pixel-height frame))
                )
                (set-face-attribute 'default frame :height (- (face-attribute
'default :height) 10))
                (mf-set-frame-pixel-size frame current-frame-width 
current-frame-
height)
        )
)

(defun dave-font-larger ()
        "Make the current frame's font size larger."
        (interactive)
        (dave-increase-default-font-size-for-frame (selected-frame)))

(defun dave-font-smaller ()
        "Make the current frame's font size smaller."
        (interactive)
        (dave-decrease-default-font-size-for-frame (selected-frame)))

(defun dave-increase-opacity (frame delta)
  (let
          ((current-opacity (frame-parameter frame 'alpha)))
          (cond ((= (if current-opacity 1 0) 0) (set-frame-parameter frame
'alpha 100))
                        ((>= current-opacity (- 100 delta)) 
(set-frame-parameter frame
'alpha 100))
                        ((< current-opacity (- 100 delta)) (set-frame-parameter 
frame
'alpha (+ current-opacity delta))))))

(defun dave-decrease-opacity (frame delta)
  (let
          ((current-opacity (frame-parameter frame 'alpha)))
          (cond ((= (if current-opacity 1 0) 0) (set-frame-parameter frame
'alpha 100))
                        ((<= current-opacity delta) (set-frame-parameter frame 
'alpha 1))
                        ((> current-opacity delta) (set-frame-parameter frame 
'alpha (-
current-opacity delta))))))

(defcustom dave-opacity-delta 3
  "*Any extra display padding that you want to account for while
determining the maximize number of columns to fit on a display"
  :type 'integer
  :group 'davepeck)

(defun dave-more-opaque ()
  "Make the current frame more opaque."
  (interactive)
  (dave-increase-opacity (selected-frame) dave-opacity-delta))

(defun dave-less-opaque ()
  "Make the current frame less opaque."
  (interactive)
  (dave-decrease-opacity (selected-frame) dave-opacity-delta))

(set-frame-parameter (selected-frame) 'alpha 94)

(global-set-key [(alt \<)] 'dave-less-opaque)
(global-set-key [(alt \>)] 'dave-more-opaque)
(global-set-key [(alt -)] 'dave-font-smaller)
(global-set-key [(alt \+)] 'dave-font-larger)