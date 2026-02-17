(define modes '("r" "w" "a" "r+" "w+" "a+" "rb" "wb" "ab" "rb+" "wb+" "ab+"))

(define-c-library libc '("stdio.h") #f '((additional-versions ("0" "6"))))
(define-c-procedure internal-fopen libc 'fopen 'pointer '(pointer pointer))
(define-c-procedure internal-fclose libc 'fclose 'int '(pointer))


(define handle-c-errors
  (lambda (msg return-code)
    (when (and (number? return-code)
               (< return-code 0))
      (let ((msg-pointer (string->c-utf8 msg)))
        (c-perror msg-pointer)
        (c-free msg-pointer)
        (error msg return-code)))
    return-code))

(define (fopen filename mode)
  (when (not (string? filename)) (error "fopen: Filename must be string" filename))
  (when (not (string? mode)) (error "fopen: Mode must be string" mode))
  (when (not (member mode modes))
    (error "fopen: Mode not in allowed modes of "
           `((mode ,mode)
             (allowed-modes @,modes))))
  (let* ((filename-pointer (string->c-utf8 filename))
         (mode-pointer (string->c-utf8 mode))
         (file (handle-c-errors (fopen "fopen: C error" filename mode))))
    (c-free filename-pointer)
    (c-free mode-pointer)
    file))

(define (fclose file)
  (handle-c-errors "fclose: C error" (internal-fclose file)))

