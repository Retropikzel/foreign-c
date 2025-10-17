/* -*-C-*- */

/* Prefix */
#include <stdio.h>
#include <ffi.h>
/* End Prefix */

#include <stdio.h>

void
grovel_basics (FILE * out)
{
  fprintf (out, "   ((sizeof char) . %ld)\n", (long) sizeof (char));
  fprintf (out, "   ((sizeof uchar) . %ld)\n", (long) sizeof (unsigned char));
  fprintf (out, "   ((sizeof short) . %ld)\n", (long) sizeof (short));
  fprintf (out, "   ((sizeof ushort) . %ld)\n", (long) sizeof (unsigned short));
  fprintf (out, "   ((sizeof int) . %ld)\n", (long) sizeof (int));
  fprintf (out, "   ((sizeof uint) . %ld)\n", (long) sizeof (unsigned int));
  fprintf (out, "   ((sizeof long) . %ld)\n", (long) sizeof (long));
  fprintf (out, "   ((sizeof ulong) . %ld)\n", (long) sizeof (unsigned long));
  fprintf (out, "   ((sizeof float) . %ld)\n", (long) sizeof (float));
  fprintf (out, "   ((sizeof double) . %ld)\n", (long) sizeof (double));
  fprintf (out, "   ((sizeof *) . %ld)\n", (long) sizeof (void*));
}

void
grovel_enums (FILE * out)
{
}

int
main (void)
{
  FILE * out = fopen ("mit-scheme-foreign-c-const.scm", "w");
  if (out == NULL) {
    perror ("could not open mit-scheme-foreign-c-const.scm");
    return 1;
  }
  fprintf (out, "'( ;; mit-scheme-foreign-c constants\n");
  fprintf (out, "  ( ;; enum member values\n");
  grovel_enums(out);
  fprintf (out, "   )\n");
  fprintf (out, "  ( ;; struct values\n");
  grovel_basics(out);
  fprintf (out, "   ))\n");
  if (fclose (out)) {
    perror ("could not close mit-scheme-foreign-c-const.scm");
    return 1;
  }
  return 0;
}
