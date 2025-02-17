
(define-record-type <pffi-union>
  (union-make c-type size pointer members)
  pffi-union?
  (c-type pffi-union-c-type)
  (size pffi-union-size)
  (pointer pffi-union-pointer)
  (members pffi-union-members))
