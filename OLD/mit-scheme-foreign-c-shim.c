/* -*-C-*- */

#include <mit-scheme.h>

/* Prefix */
#include <stdio.h>
#include <ffi.h>
/* End Prefix */

SCM
Scm_continue_puts (void)
{
  /* Declare. */
  char * tos0;
  int ret0;
  SCM ret0s;

  /* Restore. */
  tos0 = callout_lunseal (&Scm_continue_puts);
  CSTACK_LPOP (int, ret0, tos0);

  /* Return. */
  ret0s = long_to_scm (ret0);
  callout_pop (tos0);
  return (ret0s);
}
SCM
Scm_puts (void)
{
  /* Declare. */
  int ret0;
  char * s;

  /* Init. */
  check_number_of_args (2);
  s = (char *) arg_pointer (2);

  /* Call. */
  callout_seal (&Scm_continue_puts);
  ret0 = puts (s);

  /* Save. */
  callout_unseal (&Scm_continue_puts);
  CSTACK_PUSH (int, ret0);

  return callout_continue (&Scm_continue_puts);
}
