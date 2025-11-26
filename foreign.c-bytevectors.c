/* Generated from foreign/c-bytevectors.sld by the CHICKEN compiler
   http://www.call-cc.org
   Version 5.4.0 (rev 1a1d1495)
   linux-unix-gnu-x86-64 [ 64bit dload ptables ]
   command line: foreign/c-bytevectors.sld -output-file foreign.c-bytevectors.c -static -require-extension r7rs -extend r7rs -emit-all-import-libraries -include-path . -unit foreign.c-bytevectors -emit-link-file foreign.c-bytevectors.link
   unit: foreign.c-bytevectors
   uses: eval library scheme.inexact scheme.process-context scheme.file scheme.char scheme.write scheme.base r7rs
*/
#include "chicken.h"

static C_PTABLE_ENTRY *create_ptable(void);
C_noret_decl(C_eval_toplevel)
C_externimport void C_ccall C_eval_toplevel(C_word c,C_word *av) C_noret;
C_noret_decl(C_library_toplevel)
C_externimport void C_ccall C_library_toplevel(C_word c,C_word *av) C_noret;
C_noret_decl(C_scheme_2einexact_toplevel)
C_externimport void C_ccall C_scheme_2einexact_toplevel(C_word c,C_word *av) C_noret;
C_noret_decl(C_scheme_2eprocess_2dcontext_toplevel)
C_externimport void C_ccall C_scheme_2eprocess_2dcontext_toplevel(C_word c,C_word *av) C_noret;
C_noret_decl(C_scheme_2efile_toplevel)
C_externimport void C_ccall C_scheme_2efile_toplevel(C_word c,C_word *av) C_noret;
C_noret_decl(C_scheme_2echar_toplevel)
C_externimport void C_ccall C_scheme_2echar_toplevel(C_word c,C_word *av) C_noret;
C_noret_decl(C_scheme_2ewrite_toplevel)
C_externimport void C_ccall C_scheme_2ewrite_toplevel(C_word c,C_word *av) C_noret;
C_noret_decl(C_scheme_2ebase_toplevel)
C_externimport void C_ccall C_scheme_2ebase_toplevel(C_word c,C_word *av) C_noret;
C_noret_decl(C_r7rs_toplevel)
C_externimport void C_ccall C_r7rs_toplevel(C_word c,C_word *av) C_noret;

static C_TLS C_word lf[126];
static double C_possibly_force_alignment;
static C_char C_TLS li0[] C_aligned={C_lihdr(0,0,41),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,110,97,116,105,118,101,45,101,110,100,105,97,110,110,101,115,115,41,0,0,0,0,0,0,0};
static C_char C_TLS li1[] C_aligned={C_lihdr(0,0,62),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,99,45,98,121,116,101,118,101,99,116,111,114,115,45,105,110,105,116,32,109,97,107,101,32,117,56,45,115,101,116,33,32,117,56,45,114,101,102,41,0,0};
static C_char C_TLS li2[] C_aligned={C_lihdr(0,0,48),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,99,111,109,112,108,97,105,110,32,119,104,111,32,46,32,105,114,114,105,116,97,110,116,115,41};
static C_char C_TLS li3[] C_aligned={C_lihdr(0,0,34),40,102,95,49,48,57,50,32,99,45,98,121,116,101,118,101,99,116,111,114,32,107,32,101,110,100,105,97,110,110,101,115,115,41,0,0,0,0,0,0};
static C_char C_TLS li4[] C_aligned={C_lihdr(0,0,42),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,109,97,107,101,45,117,105,110,116,45,114,101,102,32,115,105,122,101,41,0,0,0,0,0,0};
static C_char C_TLS li5[] C_aligned={C_lihdr(0,0,34),40,102,95,49,49,48,48,32,99,45,98,121,116,101,118,101,99,116,111,114,32,107,32,101,110,100,105,97,110,110,101,115,115,41,0,0,0,0,0,0};
static C_char C_TLS li6[] C_aligned={C_lihdr(0,0,42),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,109,97,107,101,45,115,105,110,116,45,114,101,102,32,115,105,122,101,41,0,0,0,0,0,0};
static C_char C_TLS li7[] C_aligned={C_lihdr(0,0,36),40,102,95,49,49,48,56,32,99,45,98,121,116,101,118,101,99,116,111,114,32,107,32,110,32,101,110,100,105,97,110,110,101,115,115,41,0,0,0,0};
static C_char C_TLS li8[] C_aligned={C_lihdr(0,0,43),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,109,97,107,101,45,117,105,110,116,45,115,101,116,33,32,115,105,122,101,41,0,0,0,0,0};
static C_char C_TLS li9[] C_aligned={C_lihdr(0,0,36),40,102,95,49,49,49,54,32,99,45,98,121,116,101,118,101,99,116,111,114,32,107,32,110,32,101,110,100,105,97,110,110,101,115,115,41,0,0,0,0};
static C_char C_TLS li10[] C_aligned={C_lihdr(0,0,43),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,109,97,107,101,45,115,105,110,116,45,115,101,116,33,32,115,105,122,101,41,0,0,0,0,0};
static C_char C_TLS li11[] C_aligned={C_lihdr(0,0,27),40,102,95,49,49,50,52,32,99,45,98,121,116,101,118,101,99,116,111,114,32,105,110,100,101,120,41,0,0,0,0,0};
static C_char C_TLS li12[] C_aligned={C_lihdr(0,0,53),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,109,97,107,101,45,114,101,102,47,110,97,116,105,118,101,32,98,97,115,101,32,98,97,115,101,45,114,101,102,41,0,0,0};
static C_char C_TLS li13[] C_aligned={C_lihdr(0,0,31),40,102,95,49,49,51,57,32,99,45,98,121,116,101,118,101,99,116,111,114,32,105,110,100,101,120,32,118,97,108,41,0};
static C_char C_TLS li14[] C_aligned={C_lihdr(0,0,55),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,109,97,107,101,45,115,101,116,33,47,110,97,116,105,118,101,32,98,97,115,101,32,98,97,115,101,45,115,101,116,33,41,0};
static C_char C_TLS li15[] C_aligned={C_lihdr(0,0,49),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,101,110,115,117,114,101,45,97,108,105,103,110,101,100,32,105,110,100,101,120,32,98,97,115,101,41,0,0,0,0,0,0,0};
static C_char C_TLS li16[] C_aligned={C_lihdr(0,0,13),40,115,101,116,116,101,114,33,32,105,32,110,41,0,0,0};
static C_char C_TLS li17[] C_aligned={C_lihdr(0,0,10),40,108,111,111,112,32,105,32,108,41,0,0,0,0,0,0};
static C_char C_TLS li18[] C_aligned={C_lihdr(0,0,23),40,102,95,49,49,55,52,32,108,32,101,110,100,110,101,115,115,32,115,105,122,101,41,0};
static C_char C_TLS li19[] C_aligned={C_lihdr(0,0,69),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,109,97,107,101,45,105,110,116,45,108,105,115,116,45,62,99,45,98,121,116,101,118,101,99,116,111,114,32,99,45,98,121,116,101,118,101,99,116,111,114,45,115,101,116,33,41,0,0,0};
static C_char C_TLS li20[] C_aligned={C_lihdr(0,0,15),40,100,111,108,111,111,112,51,50,49,32,112,32,101,41,0};
static C_char C_TLS li21[] C_aligned={C_lihdr(0,0,15),40,100,111,108,111,111,112,51,50,54,32,113,32,101,41,0};
static C_char C_TLS li22[] C_aligned={C_lihdr(0,0,62),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,99,45,98,121,116,101,118,101,99,116,111,114,58,110,111,114,109,97,108,105,122,101,100,45,105,101,101,101,45,112,97,114,116,115,32,112,32,113,41,0,0};
static C_char C_TLS li23[] C_aligned={C_lihdr(0,0,8),40,118,97,51,54,56,51,41};
static C_char C_TLS li24[] C_aligned={C_lihdr(0,0,8),40,118,97,51,54,56,53,41};
static C_char C_TLS li25[] C_aligned={C_lihdr(0,0,7),40,97,49,51,56,57,41,0};
static C_char C_TLS li26[] C_aligned={C_lihdr(0,0,8),40,118,97,51,54,56,55,41};
static C_char C_TLS li27[] C_aligned={C_lihdr(0,0,22),40,100,111,108,111,111,112,51,53,53,32,98,105,97,115,101,100,32,110,117,109,41,0,0};
static C_char C_TLS li28[] C_aligned={C_lihdr(0,0,8),40,118,97,51,54,57,49,41};
static C_char C_TLS li29[] C_aligned={C_lihdr(0,0,8),40,118,97,51,54,57,51,41};
static C_char C_TLS li30[] C_aligned={C_lihdr(0,0,24),40,97,49,51,57,53,32,101,120,112,111,110,101,110,116,32,110,117,109,32,100,101,110,41};
static C_char C_TLS li31[] C_aligned={C_lihdr(0,0,56),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,99,45,98,121,116,101,118,101,99,116,111,114,58,105,101,101,101,45,112,97,114,116,115,32,120,32,98,105,97,115,32,113,41};
static C_char C_TLS li32[] C_aligned={C_lihdr(0,0,8),40,118,97,51,54,57,53,41};
static C_char C_TLS li33[] C_aligned={C_lihdr(0,0,78),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,99,45,98,121,116,101,118,101,99,116,111,114,45,105,101,101,101,45,100,111,117,98,108,101,45,98,105,103,45,101,110,100,105,97,110,45,114,101,102,32,99,45,98,121,116,101,118,101,99,116,111,114,32,107,41,0,0};
static C_char C_TLS li34[] C_aligned={C_lihdr(0,0,8),40,118,97,51,54,57,55,41};
static C_char C_TLS li35[] C_aligned={C_lihdr(0,0,81),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,99,45,98,121,116,101,118,101,99,116,111,114,45,105,101,101,101,45,100,111,117,98,108,101,45,108,105,116,116,108,101,45,101,110,100,105,97,110,45,114,101,102,32,99,45,98,121,116,101,118,101,99,116,111,114,32,107,41,0,0,0,0,0,0,0};
static C_char C_TLS li36[] C_aligned={C_lihdr(0,0,8),40,118,97,51,54,57,57,41};
static C_char C_TLS li37[] C_aligned={C_lihdr(0,0,78),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,99,45,98,121,116,101,118,101,99,116,111,114,45,105,101,101,101,45,115,105,110,103,108,101,45,98,105,103,45,101,110,100,105,97,110,45,114,101,102,32,99,45,98,121,116,101,118,101,99,116,111,114,32,107,41,0,0};
static C_char C_TLS li38[] C_aligned={C_lihdr(0,0,8),40,118,97,51,55,48,49,41};
static C_char C_TLS li39[] C_aligned={C_lihdr(0,0,81),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,99,45,98,121,116,101,118,101,99,116,111,114,45,105,101,101,101,45,115,105,110,103,108,101,45,108,105,116,116,108,101,45,101,110,100,105,97,110,45,114,101,102,32,99,45,98,121,116,101,118,101,99,116,111,114,32,107,41,0,0,0,0,0,0,0};
static C_char C_TLS li40[] C_aligned={C_lihdr(0,0,8),40,118,97,51,55,48,51,41};
static C_char C_TLS li41[] C_aligned={C_lihdr(0,0,83),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,109,97,107,101,45,105,101,101,101,45,100,111,117,98,108,101,32,115,105,103,110,32,98,105,97,115,101,100,45,101,120,112,111,110,101,110,116,32,104,105,98,105,116,115,32,109,105,100,98,105,116,115,32,108,111,98,105,116,115,41,0,0,0,0,0};
static C_char C_TLS li42[] C_aligned={C_lihdr(0,0,66),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,109,97,107,101,45,105,101,101,101,45,115,105,110,103,108,101,32,115,105,103,110,32,98,105,97,115,101,100,45,101,120,112,111,110,101,110,116,32,98,105,116,115,41,0,0,0,0,0,0};
static C_char C_TLS li43[] C_aligned={C_lihdr(0,0,13),40,100,111,108,111,111,112,52,57,52,32,105,41,0,0,0};
static C_char C_TLS li44[] C_aligned={C_lihdr(0,0,13),40,100,111,108,111,111,112,52,57,57,32,105,41,0,0,0};
static C_char C_TLS li45[] C_aligned={C_lihdr(0,0,93),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,114,54,114,115,58,99,45,98,121,116,101,118,101,99,116,111,114,45,99,111,112,121,33,32,115,111,117,114,99,101,32,115,111,117,114,99,101,45,115,116,97,114,116,32,116,97,114,103,101,116,32,116,97,114,103,101,116,45,115,116,97,114,116,32,99,111,117,110,116,41,0,0,0};
static C_char C_TLS li46[] C_aligned={C_lihdr(0,0,47),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,99,45,98,121,116,101,118,101,99,116,111,114,45,115,56,45,114,101,102,32,98,32,107,41,0};
static C_char C_TLS li47[] C_aligned={C_lihdr(0,0,52),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,99,45,98,121,116,101,118,101,99,116,111,114,45,115,56,45,115,101,116,33,32,98,32,107,32,118,97,108,41,0,0,0,0};
static C_char C_TLS li48[] C_aligned={C_lihdr(0,0,18),40,100,111,108,111,111,112,53,50,55,32,118,97,108,115,32,105,41,0,0,0,0,0,0};
static C_char C_TLS li49[] C_aligned={C_lihdr(0,0,50),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,117,56,45,108,105,115,116,45,62,99,45,98,121,116,101,118,101,99,116,111,114,32,118,97,108,115,41,0,0,0,0,0,0};
static C_char C_TLS li50[] C_aligned={C_lihdr(0,0,65),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,99,45,98,121,116,101,118,101,99,116,111,114,45,117,99,104,97,114,45,114,101,102,32,99,45,98,121,116,101,118,101,99,116,111,114,32,105,110,100,101,120,41,0,0,0,0,0,0,0};
static C_char C_TLS li51[] C_aligned={C_lihdr(0,0,71),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,99,45,98,121,116,101,118,101,99,116,111,114,45,117,99,104,97,114,45,115,101,116,33,32,99,45,98,121,116,101,118,101,99,116,111,114,32,105,110,100,101,120,32,99,104,97,114,41,0};
static C_char C_TLS li52[] C_aligned={C_lihdr(0,0,64),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,99,45,98,121,116,101,118,101,99,116,111,114,45,99,104,97,114,45,114,101,102,32,99,45,98,121,116,101,118,101,99,116,111,114,32,105,110,100,101,120,41};
static C_char C_TLS li53[] C_aligned={C_lihdr(0,0,70),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,99,45,98,121,116,101,118,101,99,116,111,114,45,99,104,97,114,45,115,101,116,33,32,99,45,98,121,116,101,118,101,99,116,111,114,32,105,110,100,101,120,32,99,104,97,114,41,0,0};
static C_char C_TLS li54[] C_aligned={C_lihdr(0,0,20),40,100,111,108,111,111,112,53,53,55,32,105,32,114,101,115,117,108,116,41,0,0,0,0};
static C_char C_TLS li55[] C_aligned={C_lihdr(0,0,20),40,100,111,108,111,111,112,53,54,50,32,105,32,114,101,115,117,108,116,41,0,0,0,0};
static C_char C_TLS li56[] C_aligned={C_lihdr(0,0,77),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,99,45,98,121,116,101,118,101,99,116,111,114,45,117,105,110,116,45,114,101,102,32,99,45,98,121,116,101,118,101,99,116,111,114,32,105,110,100,101,120,32,101,110,100,110,101,115,115,32,115,105,122,101,41,0,0,0};
static C_char C_TLS li57[] C_aligned={C_lihdr(0,0,8),40,118,97,51,55,49,53,41};
static C_char C_TLS li58[] C_aligned={C_lihdr(0,0,77),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,99,45,98,121,116,101,118,101,99,116,111,114,45,115,105,110,116,45,114,101,102,32,99,45,98,121,116,101,118,101,99,116,111,114,32,105,110,100,101,120,32,101,110,100,110,101,115,115,32,115,105,122,101,41,0,0,0};
static C_char C_TLS li59[] C_aligned={C_lihdr(0,0,17),40,100,111,108,111,111,112,53,56,54,32,105,32,118,97,108,41,0,0,0,0,0,0,0};
static C_char C_TLS li60[] C_aligned={C_lihdr(0,0,17),40,100,111,108,111,111,112,53,57,53,32,105,32,118,97,108,41,0,0,0,0,0,0,0};
static C_char C_TLS li61[] C_aligned={C_lihdr(0,0,82),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,99,45,98,121,116,101,118,101,99,116,111,114,45,117,105,110,116,45,115,101,116,33,32,99,45,98,121,116,101,118,101,99,116,111,114,32,105,110,100,101,120,32,118,97,108,32,101,110,100,110,101,115,115,32,115,105,122,101,41,0,0,0,0,0,0};
static C_char C_TLS li62[] C_aligned={C_lihdr(0,0,82),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,99,45,98,121,116,101,118,101,99,116,111,114,45,115,105,110,116,45,115,101,116,33,32,99,45,98,121,116,101,118,101,99,116,111,114,32,105,110,100,101,120,32,118,97,108,32,101,110,100,110,101,115,115,32,115,105,122,101,41,0,0,0,0,0,0};
static C_char C_TLS li63[] C_aligned={C_lihdr(0,0,74),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,99,45,98,121,116,101,118,101,99,116,111,114,45,105,101,101,101,45,115,105,110,103,108,101,45,110,97,116,105,118,101,45,114,101,102,32,99,45,98,121,116,101,118,101,99,116,111,114,32,107,41,0,0,0,0,0,0};
static C_char C_TLS li64[] C_aligned={C_lihdr(0,0,74),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,99,45,98,121,116,101,118,101,99,116,111,114,45,105,101,101,101,45,100,111,117,98,108,101,45,110,97,116,105,118,101,45,114,101,102,32,99,45,98,121,116,101,118,101,99,116,111,114,32,107,41,0,0,0,0,0,0};
static C_char C_TLS li65[] C_aligned={C_lihdr(0,0,77),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,99,45,98,121,116,101,118,101,99,116,111,114,45,105,101,101,101,45,115,105,110,103,108,101,45,110,97,116,105,118,101,45,115,101,116,33,32,99,45,98,121,116,101,118,101,99,116,111,114,32,107,32,120,41,0,0,0};
static C_char C_TLS li66[] C_aligned={C_lihdr(0,0,77),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,99,45,98,121,116,101,118,101,99,116,111,114,45,105,101,101,101,45,100,111,117,98,108,101,45,110,97,116,105,118,101,45,115,101,116,33,32,99,45,98,121,116,101,118,101,99,116,111,114,32,107,32,120,41,0,0,0};
static C_char C_TLS li67[] C_aligned={C_lihdr(0,0,78),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,99,45,98,121,116,101,118,101,99,116,111,114,45,105,101,101,101,45,115,105,110,103,108,101,45,114,101,102,32,99,45,98,121,116,101,118,101,99,116,111,114,32,107,32,101,110,100,105,97,110,110,101,115,115,41,0,0};
static C_char C_TLS li68[] C_aligned={C_lihdr(0,0,78),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,99,45,98,121,116,101,118,101,99,116,111,114,45,105,101,101,101,45,100,111,117,98,108,101,45,114,101,102,32,99,45,98,121,116,101,118,101,99,116,111,114,32,107,32,101,110,100,105,97,110,110,101,115,115,41,0,0};
static C_char C_TLS li69[] C_aligned={C_lihdr(0,0,7),40,97,50,57,53,51,41,0};
static C_char C_TLS li70[] C_aligned={C_lihdr(0,0,34),40,115,116,111,114,101,33,32,115,105,103,110,32,98,105,97,115,101,100,45,101,120,112,111,110,101,110,116,32,102,114,97,99,41,0,0,0,0,0,0};
static C_char C_TLS li71[] C_aligned={C_lihdr(0,0,33),40,97,50,57,53,57,32,115,105,103,110,32,98,105,97,115,101,100,45,101,120,112,111,110,101,110,116,32,102,114,97,99,41,0,0,0,0,0,0,0};
static C_char C_TLS li72[] C_aligned={C_lihdr(0,0,81),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,99,45,98,121,116,101,118,101,99,116,111,114,45,105,101,101,101,45,115,105,110,103,108,101,45,115,101,116,33,32,99,45,98,121,116,101,118,101,99,116,111,114,32,107,32,120,32,101,110,100,105,97,110,110,101,115,115,41,0,0,0,0,0,0,0};
static C_char C_TLS li73[] C_aligned={C_lihdr(0,0,7),40,97,51,49,51,51,41,0};
static C_char C_TLS li74[] C_aligned={C_lihdr(0,0,34),40,115,116,111,114,101,33,32,115,105,103,110,32,98,105,97,115,101,100,45,101,120,112,111,110,101,110,116,32,102,114,97,99,41,0,0,0,0,0,0};
static C_char C_TLS li75[] C_aligned={C_lihdr(0,0,11),40,115,119,97,112,33,32,105,32,106,41,0,0,0,0,0};
static C_char C_TLS li76[] C_aligned={C_lihdr(0,0,33),40,97,51,49,51,57,32,115,105,103,110,32,98,105,97,115,101,100,45,101,120,112,111,110,101,110,116,32,102,114,97,99,41,0,0,0,0,0,0,0};
static C_char C_TLS li77[] C_aligned={C_lihdr(0,0,81),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,99,45,98,121,116,101,118,101,99,116,111,114,45,105,101,101,101,45,100,111,117,98,108,101,45,115,101,116,33,32,99,45,98,121,116,101,118,101,99,116,111,114,32,107,32,120,32,101,110,100,105,97,110,110,101,115,115,41,0,0,0,0,0,0,0};
static C_char C_TLS li78[] C_aligned={C_lihdr(0,0,15),40,100,111,108,111,111,112,55,57,50,32,105,32,107,41,0};
static C_char C_TLS li79[] C_aligned={C_lihdr(0,0,15),40,114,101,115,117,108,116,45,108,101,110,103,116,104,41,0};
static C_char C_TLS li80[] C_aligned={C_lihdr(0,0,8),40,118,97,51,55,50,51,41};
static C_char C_TLS li81[] C_aligned={C_lihdr(0,0,8),40,118,97,51,55,50,53,41};
static C_char C_TLS li82[] C_aligned={C_lihdr(0,0,10),40,108,111,111,112,32,105,32,107,41,0,0,0,0,0,0};
static C_char C_TLS li83[] C_aligned={C_lihdr(0,0,51),40,102,111,114,101,105,103,110,46,99,45,98,121,116,101,118,101,99,116,111,114,115,35,115,116,114,105,110,103,45,62,117,116,102,49,54,32,115,116,114,105,110,103,32,46,32,114,101,115,116,41,0,0,0,0,0};
static C_char C_TLS li84[] C_aligned={C_lihdr(0,0,10),40,116,111,112,108,101,118,101,108,41,0,0,0,0,0,0};


C_noret_decl(f_1035)
static void C_ccall f_1035(C_word c,C_word *av) C_noret;
C_noret_decl(f_1038)
static void C_ccall f_1038(C_word c,C_word *av) C_noret;
C_noret_decl(f_1041)
static void C_ccall f_1041(C_word c,C_word *av) C_noret;
C_noret_decl(f_1044)
static void C_ccall f_1044(C_word c,C_word *av) C_noret;
C_noret_decl(f_1047)
static void C_ccall f_1047(C_word c,C_word *av) C_noret;
C_noret_decl(f_1050)
static void C_ccall f_1050(C_word c,C_word *av) C_noret;
C_noret_decl(f_1053)
static void C_ccall f_1053(C_word c,C_word *av) C_noret;
C_noret_decl(f_1056)
static void C_ccall f_1056(C_word c,C_word *av) C_noret;
C_noret_decl(f_1059)
static void C_ccall f_1059(C_word c,C_word *av) C_noret;
C_noret_decl(f_1062)
static void C_ccall f_1062(C_word c,C_word *av) C_noret;
C_noret_decl(f_1064)
static void C_ccall f_1064(C_word c,C_word *av) C_noret;
C_noret_decl(f_1070)
static void C_ccall f_1070(C_word c,C_word *av) C_noret;
C_noret_decl(f_1076)
static void C_ccall f_1076(C_word c,C_word *av) C_noret;
C_noret_decl(f_1084)
static void C_ccall f_1084(C_word c,C_word *av) C_noret;
C_noret_decl(f_1088)
static void C_ccall f_1088(C_word c,C_word *av) C_noret;
C_noret_decl(f_1090)
static void C_ccall f_1090(C_word c,C_word *av) C_noret;
C_noret_decl(f_1092)
static void C_ccall f_1092(C_word c,C_word *av) C_noret;
C_noret_decl(f_1098)
static void C_ccall f_1098(C_word c,C_word *av) C_noret;
C_noret_decl(f_1100)
static void C_ccall f_1100(C_word c,C_word *av) C_noret;
C_noret_decl(f_1106)
static void C_ccall f_1106(C_word c,C_word *av) C_noret;
C_noret_decl(f_1108)
static void C_ccall f_1108(C_word c,C_word *av) C_noret;
C_noret_decl(f_1114)
static void C_ccall f_1114(C_word c,C_word *av) C_noret;
C_noret_decl(f_1116)
static void C_ccall f_1116(C_word c,C_word *av) C_noret;
C_noret_decl(f_1122)
static void C_ccall f_1122(C_word c,C_word *av) C_noret;
C_noret_decl(f_1124)
static void C_ccall f_1124(C_word c,C_word *av) C_noret;
C_noret_decl(f_1128)
static void C_ccall f_1128(C_word c,C_word *av) C_noret;
C_noret_decl(f_1135)
static void C_ccall f_1135(C_word c,C_word *av) C_noret;
C_noret_decl(f_1137)
static void C_ccall f_1137(C_word c,C_word *av) C_noret;
C_noret_decl(f_1139)
static void C_ccall f_1139(C_word c,C_word *av) C_noret;
C_noret_decl(f_1143)
static void C_ccall f_1143(C_word c,C_word *av) C_noret;
C_noret_decl(f_1150)
static void C_ccall f_1150(C_word c,C_word *av) C_noret;
C_noret_decl(f_1152)
static void C_ccall f_1152(C_word c,C_word *av) C_noret;
C_noret_decl(f_1172)
static void C_ccall f_1172(C_word c,C_word *av) C_noret;
C_noret_decl(f_1174)
static void C_ccall f_1174(C_word c,C_word *av) C_noret;
C_noret_decl(f_1178)
static void C_ccall f_1178(C_word c,C_word *av) C_noret;
C_noret_decl(f_1179)
static void C_fcall f_1179(C_word t0,C_word t1,C_word t2,C_word t3) C_noret;
C_noret_decl(f_1188)
static void C_fcall f_1188(C_word t0,C_word t1,C_word t2,C_word t3) C_noret;
C_noret_decl(f_1198)
static void C_ccall f_1198(C_word c,C_word *av) C_noret;
C_noret_decl(f_1241)
static void C_ccall f_1241(C_word c,C_word *av) C_noret;
C_noret_decl(f_1253)
static void C_fcall f_1253(C_word t0,C_word t1,C_word t2,C_word t3) C_noret;
C_noret_decl(f_1285)
static void C_fcall f_1285(C_word t0,C_word t1,C_word t2,C_word t3) C_noret;
C_noret_decl(f_1319)
static void C_ccall f_1319(C_word c,C_word *av) C_noret;
C_noret_decl(f_1326)
static void C_ccall f_1326(C_word c,C_word *av) C_noret;
C_noret_decl(f_1343)
static void C_ccall f_1343(C_word c,C_word *av) C_noret;
C_noret_decl(f_1379)
static void C_ccall f_1379(C_word c,C_word *av) C_noret;
C_noret_decl(f_1382)
static void C_ccall f_1382(C_word c,C_word *av) C_noret;
C_noret_decl(f_1385)
static void C_ccall f_1385(C_word c,C_word *av) C_noret;
C_noret_decl(f_1390)
static void C_ccall f_1390(C_word c,C_word *av) C_noret;
C_noret_decl(f_1396)
static void C_ccall f_1396(C_word c,C_word *av) C_noret;
C_noret_decl(f_1406)
static void C_ccall f_1406(C_word c,C_word *av) C_noret;
C_noret_decl(f_1415)
static void C_ccall f_1415(C_word c,C_word *av) C_noret;
C_noret_decl(f_1433)
static void C_ccall f_1433(C_word c,C_word *av) C_noret;
C_noret_decl(f_1436)
static void C_ccall f_1436(C_word c,C_word *av) C_noret;
C_noret_decl(f_1443)
static void C_ccall f_1443(C_word c,C_word *av) C_noret;
C_noret_decl(f_1470)
static void C_ccall f_1470(C_word c,C_word *av) C_noret;
C_noret_decl(f_1472)
static void C_fcall f_1472(C_word t0,C_word t1,C_word t2,C_word t3) C_noret;
C_noret_decl(f_1493)
static void C_ccall f_1493(C_word c,C_word *av) C_noret;
C_noret_decl(f_1507)
static void C_ccall f_1507(C_word c,C_word *av) C_noret;
C_noret_decl(f_1523)
static void C_ccall f_1523(C_word c,C_word *av) C_noret;
C_noret_decl(f_1528)
static void C_ccall f_1528(C_word c,C_word *av) C_noret;
C_noret_decl(f_1532)
static void C_ccall f_1532(C_word c,C_word *av) C_noret;
C_noret_decl(f_1535)
static void C_ccall f_1535(C_word c,C_word *av) C_noret;
C_noret_decl(f_1538)
static void C_ccall f_1538(C_word c,C_word *av) C_noret;
C_noret_decl(f_1541)
static void C_ccall f_1541(C_word c,C_word *av) C_noret;
C_noret_decl(f_1544)
static void C_ccall f_1544(C_word c,C_word *av) C_noret;
C_noret_decl(f_1547)
static void C_ccall f_1547(C_word c,C_word *av) C_noret;
C_noret_decl(f_1550)
static void C_ccall f_1550(C_word c,C_word *av) C_noret;
C_noret_decl(f_1553)
static void C_ccall f_1553(C_word c,C_word *av) C_noret;
C_noret_decl(f_1637)
static void C_ccall f_1637(C_word c,C_word *av) C_noret;
C_noret_decl(f_1641)
static void C_ccall f_1641(C_word c,C_word *av) C_noret;
C_noret_decl(f_1644)
static void C_ccall f_1644(C_word c,C_word *av) C_noret;
C_noret_decl(f_1647)
static void C_ccall f_1647(C_word c,C_word *av) C_noret;
C_noret_decl(f_1650)
static void C_ccall f_1650(C_word c,C_word *av) C_noret;
C_noret_decl(f_1653)
static void C_ccall f_1653(C_word c,C_word *av) C_noret;
C_noret_decl(f_1656)
static void C_ccall f_1656(C_word c,C_word *av) C_noret;
C_noret_decl(f_1659)
static void C_ccall f_1659(C_word c,C_word *av) C_noret;
C_noret_decl(f_1662)
static void C_ccall f_1662(C_word c,C_word *av) C_noret;
C_noret_decl(f_1746)
static void C_ccall f_1746(C_word c,C_word *av) C_noret;
C_noret_decl(f_1750)
static void C_ccall f_1750(C_word c,C_word *av) C_noret;
C_noret_decl(f_1753)
static void C_ccall f_1753(C_word c,C_word *av) C_noret;
C_noret_decl(f_1756)
static void C_ccall f_1756(C_word c,C_word *av) C_noret;
C_noret_decl(f_1759)
static void C_ccall f_1759(C_word c,C_word *av) C_noret;
C_noret_decl(f_1813)
static void C_ccall f_1813(C_word c,C_word *av) C_noret;
C_noret_decl(f_1817)
static void C_ccall f_1817(C_word c,C_word *av) C_noret;
C_noret_decl(f_1820)
static void C_ccall f_1820(C_word c,C_word *av) C_noret;
C_noret_decl(f_1823)
static void C_ccall f_1823(C_word c,C_word *av) C_noret;
C_noret_decl(f_1826)
static void C_ccall f_1826(C_word c,C_word *av) C_noret;
C_noret_decl(f_1880)
static void C_ccall f_1880(C_word c,C_word *av) C_noret;
C_noret_decl(f_1921)
static void C_fcall f_1921(C_word t0,C_word t1) C_noret;
C_noret_decl(f_1930)
static void C_ccall f_1930(C_word c,C_word *av) C_noret;
C_noret_decl(f_1939)
static void C_ccall f_1939(C_word c,C_word *av) C_noret;
C_noret_decl(f_1955)
static void C_ccall f_1955(C_word c,C_word *av) C_noret;
C_noret_decl(f_1959)
static void C_ccall f_1959(C_word c,C_word *av) C_noret;
C_noret_decl(f_1967)
static void C_ccall f_1967(C_word c,C_word *av) C_noret;
C_noret_decl(f_1975)
static void C_ccall f_1975(C_word c,C_word *av) C_noret;
C_noret_decl(f_1993)
static void C_ccall f_1993(C_word c,C_word *av) C_noret;
C_noret_decl(f_2002)
static void C_ccall f_2002(C_word c,C_word *av) C_noret;
C_noret_decl(f_2018)
static void C_ccall f_2018(C_word c,C_word *av) C_noret;
C_noret_decl(f_2030)
static void C_ccall f_2030(C_word c,C_word *av) C_noret;
C_noret_decl(f_2038)
static void C_ccall f_2038(C_word c,C_word *av) C_noret;
C_noret_decl(f_2040)
static void C_ccall f_2040(C_word c,C_word *av) C_noret;
C_noret_decl(f_2086)
static void C_ccall f_2086(C_word c,C_word *av) C_noret;
C_noret_decl(f_2089)
static void C_ccall f_2089(C_word c,C_word *av) C_noret;
C_noret_decl(f_2105)
static void C_ccall f_2105(C_word c,C_word *av) C_noret;
C_noret_decl(f_2109)
static void C_ccall f_2109(C_word c,C_word *av) C_noret;
C_noret_decl(f_2115)
static void C_ccall f_2115(C_word c,C_word *av) C_noret;
C_noret_decl(f_2118)
static void C_ccall f_2118(C_word c,C_word *av) C_noret;
C_noret_decl(f_2134)
static void C_ccall f_2134(C_word c,C_word *av) C_noret;
C_noret_decl(f_2140)
static void C_ccall f_2140(C_word c,C_word *av) C_noret;
C_noret_decl(f_2152)
static void C_fcall f_2152(C_word t0,C_word t1,C_word t2) C_noret;
C_noret_decl(f_2162)
static void C_ccall f_2162(C_word c,C_word *av) C_noret;
C_noret_decl(f_2177)
static void C_ccall f_2177(C_word c,C_word *av) C_noret;
C_noret_decl(f_2190)
static void C_fcall f_2190(C_word t0,C_word t1,C_word t2) C_noret;
C_noret_decl(f_2200)
static void C_ccall f_2200(C_word c,C_word *av) C_noret;
C_noret_decl(f_2215)
static void C_ccall f_2215(C_word c,C_word *av) C_noret;
C_noret_decl(f_2221)
static void C_ccall f_2221(C_word c,C_word *av) C_noret;
C_noret_decl(f_2225)
static void C_ccall f_2225(C_word c,C_word *av) C_noret;
C_noret_decl(f_2236)
static void C_ccall f_2236(C_word c,C_word *av) C_noret;
C_noret_decl(f_2252)
static void C_ccall f_2252(C_word c,C_word *av) C_noret;
C_noret_decl(f_2259)
static void C_ccall f_2259(C_word c,C_word *av) C_noret;
C_noret_decl(f_2262)
static void C_ccall f_2262(C_word c,C_word *av) C_noret;
C_noret_decl(f_2264)
static void C_fcall f_2264(C_word t0,C_word t1,C_word t2,C_word t3) C_noret;
C_noret_decl(f_2274)
static void C_ccall f_2274(C_word c,C_word *av) C_noret;
C_noret_decl(f_2291)
static void C_ccall f_2291(C_word c,C_word *av) C_noret;
C_noret_decl(f_2299)
static void C_ccall f_2299(C_word c,C_word *av) C_noret;
C_noret_decl(f_2301)
static void C_ccall f_2301(C_word c,C_word *av) C_noret;
C_noret_decl(f_2311)
static void C_ccall f_2311(C_word c,C_word *av) C_noret;
C_noret_decl(f_2319)
static void C_ccall f_2319(C_word c,C_word *av) C_noret;
C_noret_decl(f_2321)
static void C_ccall f_2321(C_word c,C_word *av) C_noret;
C_noret_decl(f_2331)
static void C_ccall f_2331(C_word c,C_word *av) C_noret;
C_noret_decl(f_2343)
static void C_fcall f_2343(C_word t0,C_word t1,C_word t2,C_word t3) C_noret;
C_noret_decl(f_2369)
static void C_ccall f_2369(C_word c,C_word *av) C_noret;
C_noret_decl(f_2388)
static void C_fcall f_2388(C_word t0,C_word t1,C_word t2,C_word t3) C_noret;
C_noret_decl(f_2414)
static void C_ccall f_2414(C_word c,C_word *av) C_noret;
C_noret_decl(f_2425)
static void C_ccall f_2425(C_word c,C_word *av) C_noret;
C_noret_decl(f_2427)
static void C_ccall f_2427(C_word c,C_word *av) C_noret;
C_noret_decl(f_2431)
static void C_ccall f_2431(C_word c,C_word *av) C_noret;
C_noret_decl(f_2434)
static void C_ccall f_2434(C_word c,C_word *av) C_noret;
C_noret_decl(f_2447)
static void C_ccall f_2447(C_word c,C_word *av) C_noret;
C_noret_decl(f_2451)
static void C_fcall f_2451(C_word t0,C_word t1) C_noret;
C_noret_decl(f_2459)
static void C_ccall f_2459(C_word c,C_word *av) C_noret;
C_noret_decl(f_2471)
static void C_fcall f_2471(C_word t0,C_word t1,C_word t2,C_word t3) C_noret;
C_noret_decl(f_2484)
static void C_ccall f_2484(C_word c,C_word *av) C_noret;
C_noret_decl(f_2518)
static void C_fcall f_2518(C_word t0,C_word t1,C_word t2,C_word t3) C_noret;
C_noret_decl(f_2531)
static void C_ccall f_2531(C_word c,C_word *av) C_noret;
C_noret_decl(f_2557)
static void C_ccall f_2557(C_word c,C_word *av) C_noret;
C_noret_decl(f_2559)
static void C_ccall f_2559(C_word c,C_word *av) C_noret;
C_noret_decl(f_2563)
static void C_fcall f_2563(C_word t0,C_word t1) C_noret;
C_noret_decl(f_2576)
static void C_ccall f_2576(C_word c,C_word *av) C_noret;
C_noret_decl(f_2580)
static void C_ccall f_2580(C_word c,C_word *av) C_noret;
C_noret_decl(f_2584)
static void C_ccall f_2584(C_word c,C_word *av) C_noret;
C_noret_decl(f_2588)
static void C_ccall f_2588(C_word c,C_word *av) C_noret;
C_noret_decl(f_2592)
static void C_ccall f_2592(C_word c,C_word *av) C_noret;
C_noret_decl(f_2596)
static void C_ccall f_2596(C_word c,C_word *av) C_noret;
C_noret_decl(f_2600)
static void C_ccall f_2600(C_word c,C_word *av) C_noret;
C_noret_decl(f_2604)
static void C_ccall f_2604(C_word c,C_word *av) C_noret;
C_noret_decl(f_2608)
static void C_ccall f_2608(C_word c,C_word *av) C_noret;
C_noret_decl(f_2612)
static void C_ccall f_2612(C_word c,C_word *av) C_noret;
C_noret_decl(f_2616)
static void C_ccall f_2616(C_word c,C_word *av) C_noret;
C_noret_decl(f_2620)
static void C_ccall f_2620(C_word c,C_word *av) C_noret;
C_noret_decl(f_2624)
static void C_ccall f_2624(C_word c,C_word *av) C_noret;
C_noret_decl(f_2628)
static void C_ccall f_2628(C_word c,C_word *av) C_noret;
C_noret_decl(f_2632)
static void C_ccall f_2632(C_word c,C_word *av) C_noret;
C_noret_decl(f_2636)
static void C_ccall f_2636(C_word c,C_word *av) C_noret;
C_noret_decl(f_2640)
static void C_ccall f_2640(C_word c,C_word *av) C_noret;
C_noret_decl(f_2644)
static void C_ccall f_2644(C_word c,C_word *av) C_noret;
C_noret_decl(f_2648)
static void C_ccall f_2648(C_word c,C_word *av) C_noret;
C_noret_decl(f_2652)
static void C_ccall f_2652(C_word c,C_word *av) C_noret;
C_noret_decl(f_2656)
static void C_ccall f_2656(C_word c,C_word *av) C_noret;
C_noret_decl(f_2660)
static void C_ccall f_2660(C_word c,C_word *av) C_noret;
C_noret_decl(f_2664)
static void C_ccall f_2664(C_word c,C_word *av) C_noret;
C_noret_decl(f_2668)
static void C_ccall f_2668(C_word c,C_word *av) C_noret;
C_noret_decl(f_2672)
static void C_ccall f_2672(C_word c,C_word *av) C_noret;
C_noret_decl(f_2674)
static void C_ccall f_2674(C_word c,C_word *av) C_noret;
C_noret_decl(f_2684)
static void C_ccall f_2684(C_word c,C_word *av) C_noret;
C_noret_decl(f_2704)
static void C_ccall f_2704(C_word c,C_word *av) C_noret;
C_noret_decl(f_2725)
static void C_ccall f_2725(C_word c,C_word *av) C_noret;
C_noret_decl(f_2727)
static void C_ccall f_2727(C_word c,C_word *av) C_noret;
C_noret_decl(f_2737)
static void C_ccall f_2737(C_word c,C_word *av) C_noret;
C_noret_decl(f_2757)
static void C_ccall f_2757(C_word c,C_word *av) C_noret;
C_noret_decl(f_2778)
static void C_ccall f_2778(C_word c,C_word *av) C_noret;
C_noret_decl(f_2780)
static void C_ccall f_2780(C_word c,C_word *av) C_noret;
C_noret_decl(f_2790)
static void C_ccall f_2790(C_word c,C_word *av) C_noret;
C_noret_decl(f_2810)
static void C_ccall f_2810(C_word c,C_word *av) C_noret;
C_noret_decl(f_2831)
static void C_ccall f_2831(C_word c,C_word *av) C_noret;
C_noret_decl(f_2833)
static void C_ccall f_2833(C_word c,C_word *av) C_noret;
C_noret_decl(f_2877)
static void C_ccall f_2877(C_word c,C_word *av) C_noret;
C_noret_decl(f_2898)
static void C_ccall f_2898(C_word c,C_word *av) C_noret;
C_noret_decl(f_2900)
static void C_ccall f_2900(C_word c,C_word *av) C_noret;
C_noret_decl(f_2924)
static void C_ccall f_2924(C_word c,C_word *av) C_noret;
C_noret_decl(f_2948)
static void C_ccall f_2948(C_word c,C_word *av) C_noret;
C_noret_decl(f_2954)
static void C_ccall f_2954(C_word c,C_word *av) C_noret;
C_noret_decl(f_2960)
static void C_ccall f_2960(C_word c,C_word *av) C_noret;
C_noret_decl(f_2963)
static void C_fcall f_2963(C_word t0,C_word t1,C_word t2,C_word t3,C_word t4) C_noret;
C_noret_decl(f_2967)
static void C_ccall f_2967(C_word c,C_word *av) C_noret;
C_noret_decl(f_2976)
static void C_ccall f_2976(C_word c,C_word *av) C_noret;
C_noret_decl(f_2979)
static void C_ccall f_2979(C_word c,C_word *av) C_noret;
C_noret_decl(f_2982)
static void C_ccall f_2982(C_word c,C_word *av) C_noret;
C_noret_decl(f_3040)
static void C_ccall f_3040(C_word c,C_word *av) C_noret;
C_noret_decl(f_3043)
static void C_ccall f_3043(C_word c,C_word *av) C_noret;
C_noret_decl(f_3046)
static void C_ccall f_3046(C_word c,C_word *av) C_noret;
C_noret_decl(f_3128)
static void C_ccall f_3128(C_word c,C_word *av) C_noret;
C_noret_decl(f_3134)
static void C_ccall f_3134(C_word c,C_word *av) C_noret;
C_noret_decl(f_3140)
static void C_ccall f_3140(C_word c,C_word *av) C_noret;
C_noret_decl(f_3143)
static void C_fcall f_3143(C_word t0,C_word t1,C_word t2,C_word t3,C_word t4) C_noret;
C_noret_decl(f_3147)
static void C_ccall f_3147(C_word c,C_word *av) C_noret;
C_noret_decl(f_3150)
static void C_ccall f_3150(C_word c,C_word *av) C_noret;
C_noret_decl(f_3153)
static void C_ccall f_3153(C_word c,C_word *av) C_noret;
C_noret_decl(f_3156)
static void C_ccall f_3156(C_word c,C_word *av) C_noret;
C_noret_decl(f_3159)
static void C_ccall f_3159(C_word c,C_word *av) C_noret;
C_noret_decl(f_3162)
static void C_ccall f_3162(C_word c,C_word *av) C_noret;
C_noret_decl(f_3165)
static void C_ccall f_3165(C_word c,C_word *av) C_noret;
C_noret_decl(f_3168)
static void C_ccall f_3168(C_word c,C_word *av) C_noret;
C_noret_decl(f_3171)
static void C_ccall f_3171(C_word c,C_word *av) C_noret;
C_noret_decl(f_3180)
static void C_ccall f_3180(C_word c,C_word *av) C_noret;
C_noret_decl(f_3183)
static void C_ccall f_3183(C_word c,C_word *av) C_noret;
C_noret_decl(f_3186)
static void C_ccall f_3186(C_word c,C_word *av) C_noret;
C_noret_decl(f_3327)
static void C_fcall f_3327(C_word t0,C_word t1,C_word t2,C_word t3) C_noret;
C_noret_decl(f_3331)
static void C_ccall f_3331(C_word c,C_word *av) C_noret;
C_noret_decl(f_3334)
static void C_ccall f_3334(C_word c,C_word *av) C_noret;
C_noret_decl(f_3337)
static void C_ccall f_3337(C_word c,C_word *av) C_noret;
C_noret_decl(f_3367)
static void C_ccall f_3367(C_word c,C_word *av) C_noret;
C_noret_decl(f_3371)
static void C_ccall f_3371(C_word c,C_word *av) C_noret;
C_noret_decl(f_3382)
static void C_fcall f_3382(C_word t0,C_word t1) C_noret;
C_noret_decl(f_3388)
static void C_fcall f_3388(C_word t0,C_word t1,C_word t2,C_word t3) C_noret;
C_noret_decl(f_3425)
static void C_ccall f_3425(C_word c,C_word *av) C_noret;
C_noret_decl(f_3427)
static void C_fcall f_3427(C_word t0,C_word t1,C_word t2,C_word t3) C_noret;
C_noret_decl(f_3452)
static void C_ccall f_3452(C_word c,C_word *av) C_noret;
C_noret_decl(f_3455)
static void C_ccall f_3455(C_word c,C_word *av) C_noret;
C_noret_decl(f_3504)
static void C_ccall f_3504(C_word c,C_word *av) C_noret;
C_noret_decl(f_3507)
static void C_ccall f_3507(C_word c,C_word *av) C_noret;
C_noret_decl(f_3510)
static void C_ccall f_3510(C_word c,C_word *av) C_noret;
C_noret_decl(f_3513)
static void C_ccall f_3513(C_word c,C_word *av) C_noret;
C_noret_decl(f_3547)
static void C_ccall f_3547(C_word c,C_word *av) C_noret;
C_noret_decl(f_3551)
static void C_ccall f_3551(C_word c,C_word *av) C_noret;
C_noret_decl(C_foreign_2ec_2dbytevectors_toplevel)
C_externexport void C_ccall C_foreign_2ec_2dbytevectors_toplevel(C_word c,C_word *av) C_noret;
C_noret_decl(va3683)
static void C_fcall va3683(C_word t0,C_word t1) C_noret;
C_noret_decl(va3685)
static void C_fcall va3685(C_word t0,C_word t1) C_noret;
C_noret_decl(va3687)
static void C_fcall va3687(C_word t0,C_word t1) C_noret;
C_noret_decl(va3691)
static void C_fcall va3691(C_word t0,C_word t1) C_noret;
C_noret_decl(va3693)
static void C_fcall va3693(C_word t0,C_word t1) C_noret;
C_noret_decl(va3695)
static void C_fcall va3695(C_word t0,C_word t1) C_noret;
C_noret_decl(va3697)
static void C_fcall va3697(C_word t0,C_word t1) C_noret;
C_noret_decl(va3699)
static void C_fcall va3699(C_word t0,C_word t1) C_noret;
C_noret_decl(va3701)
static void C_fcall va3701(C_word t0,C_word t1) C_noret;
C_noret_decl(va3703)
static void C_fcall va3703(C_word t0,C_word t1) C_noret;
C_noret_decl(va3715)
static void C_fcall va3715(C_word t0,C_word t1) C_noret;
C_noret_decl(va3723)
static void C_fcall va3723(C_word t0,C_word t1) C_noret;
C_noret_decl(va3725)
static void C_fcall va3725(C_word t0,C_word t1) C_noret;

C_noret_decl(trf_1179)
static void C_ccall trf_1179(C_word c,C_word *av) C_noret;
static void C_ccall trf_1179(C_word c,C_word *av){
C_word t0=av[3];
C_word t1=av[2];
C_word t2=av[1];
C_word t3=av[0];
f_1179(t0,t1,t2,t3);}

C_noret_decl(trf_1188)
static void C_ccall trf_1188(C_word c,C_word *av) C_noret;
static void C_ccall trf_1188(C_word c,C_word *av){
C_word t0=av[3];
C_word t1=av[2];
C_word t2=av[1];
C_word t3=av[0];
f_1188(t0,t1,t2,t3);}

C_noret_decl(trf_1253)
static void C_ccall trf_1253(C_word c,C_word *av) C_noret;
static void C_ccall trf_1253(C_word c,C_word *av){
C_word t0=av[3];
C_word t1=av[2];
C_word t2=av[1];
C_word t3=av[0];
f_1253(t0,t1,t2,t3);}

C_noret_decl(trf_1285)
static void C_ccall trf_1285(C_word c,C_word *av) C_noret;
static void C_ccall trf_1285(C_word c,C_word *av){
C_word t0=av[3];
C_word t1=av[2];
C_word t2=av[1];
C_word t3=av[0];
f_1285(t0,t1,t2,t3);}

C_noret_decl(trf_1472)
static void C_ccall trf_1472(C_word c,C_word *av) C_noret;
static void C_ccall trf_1472(C_word c,C_word *av){
C_word t0=av[3];
C_word t1=av[2];
C_word t2=av[1];
C_word t3=av[0];
f_1472(t0,t1,t2,t3);}

C_noret_decl(trf_1921)
static void C_ccall trf_1921(C_word c,C_word *av) C_noret;
static void C_ccall trf_1921(C_word c,C_word *av){
C_word t0=av[1];
C_word t1=av[0];
f_1921(t0,t1);}

C_noret_decl(trf_2152)
static void C_ccall trf_2152(C_word c,C_word *av) C_noret;
static void C_ccall trf_2152(C_word c,C_word *av){
C_word t0=av[2];
C_word t1=av[1];
C_word t2=av[0];
f_2152(t0,t1,t2);}

C_noret_decl(trf_2190)
static void C_ccall trf_2190(C_word c,C_word *av) C_noret;
static void C_ccall trf_2190(C_word c,C_word *av){
C_word t0=av[2];
C_word t1=av[1];
C_word t2=av[0];
f_2190(t0,t1,t2);}

C_noret_decl(trf_2264)
static void C_ccall trf_2264(C_word c,C_word *av) C_noret;
static void C_ccall trf_2264(C_word c,C_word *av){
C_word t0=av[3];
C_word t1=av[2];
C_word t2=av[1];
C_word t3=av[0];
f_2264(t0,t1,t2,t3);}

C_noret_decl(trf_2343)
static void C_ccall trf_2343(C_word c,C_word *av) C_noret;
static void C_ccall trf_2343(C_word c,C_word *av){
C_word t0=av[3];
C_word t1=av[2];
C_word t2=av[1];
C_word t3=av[0];
f_2343(t0,t1,t2,t3);}

C_noret_decl(trf_2388)
static void C_ccall trf_2388(C_word c,C_word *av) C_noret;
static void C_ccall trf_2388(C_word c,C_word *av){
C_word t0=av[3];
C_word t1=av[2];
C_word t2=av[1];
C_word t3=av[0];
f_2388(t0,t1,t2,t3);}

C_noret_decl(trf_2451)
static void C_ccall trf_2451(C_word c,C_word *av) C_noret;
static void C_ccall trf_2451(C_word c,C_word *av){
C_word t0=av[1];
C_word t1=av[0];
f_2451(t0,t1);}

C_noret_decl(trf_2471)
static void C_ccall trf_2471(C_word c,C_word *av) C_noret;
static void C_ccall trf_2471(C_word c,C_word *av){
C_word t0=av[3];
C_word t1=av[2];
C_word t2=av[1];
C_word t3=av[0];
f_2471(t0,t1,t2,t3);}

C_noret_decl(trf_2518)
static void C_ccall trf_2518(C_word c,C_word *av) C_noret;
static void C_ccall trf_2518(C_word c,C_word *av){
C_word t0=av[3];
C_word t1=av[2];
C_word t2=av[1];
C_word t3=av[0];
f_2518(t0,t1,t2,t3);}

C_noret_decl(trf_2563)
static void C_ccall trf_2563(C_word c,C_word *av) C_noret;
static void C_ccall trf_2563(C_word c,C_word *av){
C_word t0=av[1];
C_word t1=av[0];
f_2563(t0,t1);}

C_noret_decl(trf_2963)
static void C_ccall trf_2963(C_word c,C_word *av) C_noret;
static void C_ccall trf_2963(C_word c,C_word *av){
C_word t0=av[4];
C_word t1=av[3];
C_word t2=av[2];
C_word t3=av[1];
C_word t4=av[0];
f_2963(t0,t1,t2,t3,t4);}

C_noret_decl(trf_3143)
static void C_ccall trf_3143(C_word c,C_word *av) C_noret;
static void C_ccall trf_3143(C_word c,C_word *av){
C_word t0=av[4];
C_word t1=av[3];
C_word t2=av[2];
C_word t3=av[1];
C_word t4=av[0];
f_3143(t0,t1,t2,t3,t4);}

C_noret_decl(trf_3327)
static void C_ccall trf_3327(C_word c,C_word *av) C_noret;
static void C_ccall trf_3327(C_word c,C_word *av){
C_word t0=av[3];
C_word t1=av[2];
C_word t2=av[1];
C_word t3=av[0];
f_3327(t0,t1,t2,t3);}

C_noret_decl(trf_3382)
static void C_ccall trf_3382(C_word c,C_word *av) C_noret;
static void C_ccall trf_3382(C_word c,C_word *av){
C_word t0=av[1];
C_word t1=av[0];
f_3382(t0,t1);}

C_noret_decl(trf_3388)
static void C_ccall trf_3388(C_word c,C_word *av) C_noret;
static void C_ccall trf_3388(C_word c,C_word *av){
C_word t0=av[3];
C_word t1=av[2];
C_word t2=av[1];
C_word t3=av[0];
f_3388(t0,t1,t2,t3);}

C_noret_decl(trf_3427)
static void C_ccall trf_3427(C_word c,C_word *av) C_noret;
static void C_ccall trf_3427(C_word c,C_word *av){
C_word t0=av[3];
C_word t1=av[2];
C_word t2=av[1];
C_word t3=av[0];
f_3427(t0,t1,t2,t3);}

C_noret_decl(trva3683)
static void C_ccall trva3683(C_word c,C_word *av) C_noret;
static void C_ccall trva3683(C_word c,C_word *av){
C_word t0=av[1];
C_word t1=av[0];
va3683(t0,t1);}

C_noret_decl(trva3685)
static void C_ccall trva3685(C_word c,C_word *av) C_noret;
static void C_ccall trva3685(C_word c,C_word *av){
C_word t0=av[1];
C_word t1=av[0];
va3685(t0,t1);}

C_noret_decl(trva3687)
static void C_ccall trva3687(C_word c,C_word *av) C_noret;
static void C_ccall trva3687(C_word c,C_word *av){
C_word t0=av[1];
C_word t1=av[0];
va3687(t0,t1);}

C_noret_decl(trva3691)
static void C_ccall trva3691(C_word c,C_word *av) C_noret;
static void C_ccall trva3691(C_word c,C_word *av){
C_word t0=av[1];
C_word t1=av[0];
va3691(t0,t1);}

C_noret_decl(trva3693)
static void C_ccall trva3693(C_word c,C_word *av) C_noret;
static void C_ccall trva3693(C_word c,C_word *av){
C_word t0=av[1];
C_word t1=av[0];
va3693(t0,t1);}

C_noret_decl(trva3695)
static void C_ccall trva3695(C_word c,C_word *av) C_noret;
static void C_ccall trva3695(C_word c,C_word *av){
C_word t0=av[1];
C_word t1=av[0];
va3695(t0,t1);}

C_noret_decl(trva3697)
static void C_ccall trva3697(C_word c,C_word *av) C_noret;
static void C_ccall trva3697(C_word c,C_word *av){
C_word t0=av[1];
C_word t1=av[0];
va3697(t0,t1);}

C_noret_decl(trva3699)
static void C_ccall trva3699(C_word c,C_word *av) C_noret;
static void C_ccall trva3699(C_word c,C_word *av){
C_word t0=av[1];
C_word t1=av[0];
va3699(t0,t1);}

C_noret_decl(trva3701)
static void C_ccall trva3701(C_word c,C_word *av) C_noret;
static void C_ccall trva3701(C_word c,C_word *av){
C_word t0=av[1];
C_word t1=av[0];
va3701(t0,t1);}

C_noret_decl(trva3703)
static void C_ccall trva3703(C_word c,C_word *av) C_noret;
static void C_ccall trva3703(C_word c,C_word *av){
C_word t0=av[1];
C_word t1=av[0];
va3703(t0,t1);}

C_noret_decl(trva3715)
static void C_ccall trva3715(C_word c,C_word *av) C_noret;
static void C_ccall trva3715(C_word c,C_word *av){
C_word t0=av[1];
C_word t1=av[0];
va3715(t0,t1);}

C_noret_decl(trva3723)
static void C_ccall trva3723(C_word c,C_word *av) C_noret;
static void C_ccall trva3723(C_word c,C_word *av){
C_word t0=av[1];
C_word t1=av[0];
va3723(t0,t1);}

C_noret_decl(trva3725)
static void C_ccall trva3725(C_word c,C_word *av) C_noret;
static void C_ccall trva3725(C_word c,C_word *av){
C_word t0=av[1];
C_word t1=av[0];
va3725(t0,t1);}

/* k1033 */
static void C_ccall f_1035(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,2)))){
C_save_and_reclaim((void *)f_1035,c,av);}
a=C_alloc(3);
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1038,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);{
C_word *av2=av;
av2[0]=C_SCHEME_UNDEFINED;
av2[1]=t2;
C_eval_toplevel(2,av2);}}

/* k1036 in k1033 */
static void C_ccall f_1038(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(11,c,2)))){
C_save_and_reclaim((void *)f_1038,c,av);}
a=C_alloc(11);
t2=C_a_i_provide(&a,1,lf[0]);
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1041,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);{
C_word *av2=av;
av2[0]=C_SCHEME_UNDEFINED;
av2[1]=t3;
C_r7rs_toplevel(2,av2);}}

/* k1039 in k1036 in k1033 */
static void C_ccall f_1041(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(11,c,2)))){
C_save_and_reclaim((void *)f_1041,c,av);}
a=C_alloc(11);
t2=C_a_i_provide(&a,1,lf[1]);
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1044,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:50: ##sys#provide"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[125]);
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=*((C_word*)lf[125]+1);
av2[1]=t3;
av2[2]=lf[0];
tp(3,av2);}}

/* k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1044(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,2)))){
C_save_and_reclaim((void *)f_1044,c,av);}
a=C_alloc(3);
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1047,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);{
C_word *av2=av;
av2[0]=C_SCHEME_UNDEFINED;
av2[1]=t2;
C_scheme_2ebase_toplevel(2,av2);}}

/* k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1047(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,2)))){
C_save_and_reclaim((void *)f_1047,c,av);}
a=C_alloc(3);
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1050,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);{
C_word *av2=av;
av2[0]=C_SCHEME_UNDEFINED;
av2[1]=t2;
C_scheme_2ewrite_toplevel(2,av2);}}

/* k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1050(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,2)))){
C_save_and_reclaim((void *)f_1050,c,av);}
a=C_alloc(3);
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1053,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);{
C_word *av2=av;
av2[0]=C_SCHEME_UNDEFINED;
av2[1]=t2;
C_scheme_2echar_toplevel(2,av2);}}

/* k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1053(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,2)))){
C_save_and_reclaim((void *)f_1053,c,av);}
a=C_alloc(3);
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1056,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);{
C_word *av2=av;
av2[0]=C_SCHEME_UNDEFINED;
av2[1]=t2;
C_scheme_2efile_toplevel(2,av2);}}

/* k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1056(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,2)))){
C_save_and_reclaim((void *)f_1056,c,av);}
a=C_alloc(3);
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1059,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);{
C_word *av2=av;
av2[0]=C_SCHEME_UNDEFINED;
av2[1]=t2;
C_scheme_2eprocess_2dcontext_toplevel(2,av2);}}

/* k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1059(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,2)))){
C_save_and_reclaim((void *)f_1059,c,av);}
a=C_alloc(3);
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1062,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);{
C_word *av2=av;
av2[0]=C_SCHEME_UNDEFINED;
av2[1]=t2;
C_scheme_2einexact_toplevel(2,av2);}}

/* k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1062(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word t9;
C_word t10;
C_word t11;
C_word t12;
C_word t13;
C_word t14;
C_word t15;
C_word t16;
C_word t17;
C_word t18;
C_word t19;
C_word t20;
C_word t21;
C_word t22;
C_word t23;
C_word t24;
C_word t25;
C_word t26;
C_word t27;
C_word t28;
C_word t29;
C_word t30;
C_word t31;
C_word t32;
C_word t33;
C_word t34;
C_word t35;
C_word t36;
C_word t37;
C_word t38;
C_word t39;
C_word t40;
C_word t41;
C_word t42;
C_word t43;
C_word t44;
C_word t45;
C_word t46;
C_word t47;
C_word t48;
C_word t49;
C_word t50;
C_word t51;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(106,c,7)))){
C_save_and_reclaim((void *)f_1062,c,av);}
a=C_alloc(106);
t2=C_mutate((C_word*)lf[2]+1 /* (set! foreign.c-bytevectors#native-endianness ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1064,a[2]=((C_word)li0),tmp=(C_word)a,a+=3,tmp));
t3=C_set_block_item(lf[4] /* foreign.c-bytevectors#make-c-bytevector */,0,C_SCHEME_FALSE);
t4=C_set_block_item(lf[5] /* foreign.c-bytevectors#c-bytevector-u8-set! */,0,C_SCHEME_FALSE);
t5=C_set_block_item(lf[6] /* foreign.c-bytevectors#c-bytevector-u8-ref */,0,C_SCHEME_FALSE);
t6=C_mutate((C_word*)lf[7]+1 /* (set! foreign.c-bytevectors#c-bytevectors-init ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1070,a[2]=((C_word)li1),tmp=(C_word)a,a+=3,tmp));
t7=C_mutate((C_word*)lf[8]+1 /* (set! foreign.c-bytevectors#complain ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1076,a[2]=((C_word)li2),tmp=(C_word)a,a+=3,tmp));
t8=C_mutate((C_word*)lf[13]+1 /* (set! foreign.c-bytevectors#make-uint-ref ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1090,a[2]=((C_word)li4),tmp=(C_word)a,a+=3,tmp));
t9=C_mutate((C_word*)lf[15]+1 /* (set! foreign.c-bytevectors#make-sint-ref ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1098,a[2]=((C_word)li6),tmp=(C_word)a,a+=3,tmp));
t10=C_mutate((C_word*)lf[17]+1 /* (set! foreign.c-bytevectors#make-uint-set! ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1106,a[2]=((C_word)li8),tmp=(C_word)a,a+=3,tmp));
t11=C_mutate((C_word*)lf[19]+1 /* (set! foreign.c-bytevectors#make-sint-set! ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1114,a[2]=((C_word)li10),tmp=(C_word)a,a+=3,tmp));
t12=C_mutate((C_word*)lf[21]+1 /* (set! foreign.c-bytevectors#make-ref/native ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1122,a[2]=((C_word)li12),tmp=(C_word)a,a+=3,tmp));
t13=C_mutate((C_word*)lf[23]+1 /* (set! foreign.c-bytevectors#make-set!/native ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1137,a[2]=((C_word)li14),tmp=(C_word)a,a+=3,tmp));
t14=C_mutate((C_word*)lf[22]+1 /* (set! foreign.c-bytevectors#ensure-aligned ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1152,a[2]=((C_word)li15),tmp=(C_word)a,a+=3,tmp));
t15=C_mutate((C_word*)lf[25]+1 /* (set! foreign.c-bytevectors#make-int-list->c-bytevector ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1172,a[2]=((C_word)li19),tmp=(C_word)a,a+=3,tmp));
t16=C_set_block_item(lf[26] /* foreign.c-bytevectors#c-bytevector:single-maxexponent */,0,C_fix(255));
t17=C_s_a_i_quotient(&a,2,C_fast_retrieve(lf[26]),C_fix(2));
t18=C_mutate((C_word*)lf[27]+1 /* (set! foreign.c-bytevectors#c-bytevector:single-bias ...) */,t17);
t19=C_set_block_item(lf[28] /* foreign.c-bytevectors#c-bytevector:single-hidden-bit */,0,C_fix(8388608));
t20=C_set_block_item(lf[29] /* foreign.c-bytevectors#c-bytevector:double-maxexponent */,0,C_fix(2047));
t21=C_s_a_i_quotient(&a,2,C_fast_retrieve(lf[29]),C_fix(2));
t22=C_mutate((C_word*)lf[30]+1 /* (set! foreign.c-bytevectors#c-bytevector:double-bias ...) */,t21);
t23=C_mutate((C_word*)lf[31]+1 /* (set! foreign.c-bytevectors#c-bytevector:double-hidden-bit ...) */,lf[32]);
t24=C_mutate((C_word*)lf[33]+1 /* (set! foreign.c-bytevectors#two^48 ...) */,lf[34]);
t25=C_mutate((C_word*)lf[35]+1 /* (set! foreign.c-bytevectors#two^40 ...) */,lf[36]);
t26=C_mutate((C_word*)lf[37]+1 /* (set! foreign.c-bytevectors#two^32 ...) */,lf[38]);
t27=C_set_block_item(lf[39] /* foreign.c-bytevectors#two^24 */,0,C_fix(16777216));
t28=C_set_block_item(lf[40] /* foreign.c-bytevectors#two^16 */,0,C_fix(65536));
t29=C_set_block_item(lf[41] /* foreign.c-bytevectors#two^8 */,0,C_fix(256));
t30=C_mutate((C_word*)lf[42]+1 /* (set! foreign.c-bytevectors#c-bytevector:normalized-ieee-parts ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1241,a[2]=((C_word)li22),tmp=(C_word)a,a+=3,tmp));
t31=C_mutate((C_word*)lf[43]+1 /* (set! foreign.c-bytevectors#c-bytevector:ieee-parts ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1319,a[2]=((C_word)li31),tmp=(C_word)a,a+=3,tmp));
t32=C_mutate((C_word*)lf[55]+1 /* (set! foreign.c-bytevectors#c-bytevector-ieee-double-big-endian-ref ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1528,a[2]=((C_word)li33),tmp=(C_word)a,a+=3,tmp));
t33=C_mutate((C_word*)lf[57]+1 /* (set! foreign.c-bytevectors#c-bytevector-ieee-double-little-endian-ref ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1637,a[2]=((C_word)li35),tmp=(C_word)a,a+=3,tmp));
t34=C_mutate((C_word*)lf[58]+1 /* (set! foreign.c-bytevectors#c-bytevector-ieee-single-big-endian-ref ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1746,a[2]=((C_word)li37),tmp=(C_word)a,a+=3,tmp));
t35=C_mutate((C_word*)lf[60]+1 /* (set! foreign.c-bytevectors#c-bytevector-ieee-single-little-endian-ref ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1813,a[2]=((C_word)li39),tmp=(C_word)a,a+=3,tmp));
t36=C_mutate((C_word*)lf[56]+1 /* (set! foreign.c-bytevectors#make-ieee-double ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1880,a[2]=((C_word)li41),tmp=(C_word)a,a+=3,tmp));
t37=C_mutate((C_word*)lf[59]+1 /* (set! foreign.c-bytevectors#make-ieee-single ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2040,a[2]=((C_word)li42),tmp=(C_word)a,a+=3,tmp));
t38=C_mutate((C_word*)lf[76]+1 /* (set! foreign.c-bytevectors#r6rs:c-bytevector-copy! ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2140,a[2]=((C_word)li45),tmp=(C_word)a,a+=3,tmp));
t39=C_mutate((C_word*)lf[77]+1 /* (set! foreign.c-bytevectors#c-bytevector-s8-ref ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2221,a[2]=((C_word)li46),tmp=(C_word)a,a+=3,tmp));
t40=C_mutate((C_word*)lf[78]+1 /* (set! foreign.c-bytevectors#c-bytevector-s8-set! ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2236,a[2]=((C_word)li47),tmp=(C_word)a,a+=3,tmp));
t41=C_mutate((C_word*)lf[79]+1 /* (set! foreign.c-bytevectors#u8-list->c-bytevector ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2252,a[2]=((C_word)li49),tmp=(C_word)a,a+=3,tmp));
t42=C_mutate((C_word*)lf[80]+1 /* (set! foreign.c-bytevectors#c-bytevector-uchar-ref ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2291,a[2]=((C_word)li50),tmp=(C_word)a,a+=3,tmp));
t43=C_mutate((C_word*)lf[81]+1 /* (set! foreign.c-bytevectors#c-bytevector-uchar-set! ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2301,a[2]=((C_word)li51),tmp=(C_word)a,a+=3,tmp));
t44=C_mutate((C_word*)lf[82]+1 /* (set! foreign.c-bytevectors#c-bytevector-char-ref ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2311,a[2]=((C_word)li52),tmp=(C_word)a,a+=3,tmp));
t45=C_mutate((C_word*)lf[83]+1 /* (set! foreign.c-bytevectors#c-bytevector-char-set! ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2321,a[2]=((C_word)li53),tmp=(C_word)a,a+=3,tmp));
t46=C_mutate((C_word*)lf[14]+1 /* (set! foreign.c-bytevectors#c-bytevector-uint-ref ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2331,a[2]=((C_word)li56),tmp=(C_word)a,a+=3,tmp));
t47=C_mutate((C_word*)lf[16]+1 /* (set! foreign.c-bytevectors#c-bytevector-sint-ref ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2427,a[2]=((C_word)li58),tmp=(C_word)a,a+=3,tmp));
t48=C_mutate((C_word*)lf[18]+1 /* (set! foreign.c-bytevectors#c-bytevector-uint-set! ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2459,a[2]=((C_word)li61),tmp=(C_word)a,a+=3,tmp));
t49=C_mutate((C_word*)lf[20]+1 /* (set! foreign.c-bytevectors#c-bytevector-sint-set! ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2559,a[2]=((C_word)li62),tmp=(C_word)a,a+=3,tmp));
t50=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2580,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:693: make-uint-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[13]);
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=*((C_word*)lf[13]+1);
av2[1]=t50;
av2[2]=C_fix(2);
tp(3,av2);}}

/* foreign.c-bytevectors#native-endianness in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1064(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
if(c!=2) C_bad_argc_2(c,2,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,1)))){
C_save_and_reclaim((void *)f_1064,c,av);}
t2=t1;{
C_word *av2=av;
av2[0]=t2;
av2[1]=lf[3];
((C_proc)(void*)(*((C_word*)t2+1)))(2,av2);}}

/* foreign.c-bytevectors#c-bytevectors-init in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1070(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4=av[4];
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word *a;
if(c!=5) C_bad_argc_2(c,5,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,1)))){
C_save_and_reclaim((void *)f_1070,c,av);}
t5=C_mutate((C_word*)lf[4]+1 /* (set! foreign.c-bytevectors#make-c-bytevector ...) */,t2);
t6=C_mutate((C_word*)lf[5]+1 /* (set! foreign.c-bytevectors#c-bytevector-u8-set! ...) */,t3);
t7=C_mutate((C_word*)lf[6]+1 /* (set! foreign.c-bytevectors#c-bytevector-u8-ref ...) */,t4);
t8=t1;{
C_word *av2=av;
av2[0]=t8;
av2[1]=t7;
((C_proc)(void*)(*((C_word*)t8+1)))(2,av2);}}

/* foreign.c-bytevectors#complain in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1076(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3;
C_word *a;
if(c<3) C_bad_min_argc_2(c,3,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand((c-3)*C_SIZEOF_PAIR +7,c,2)))){
C_save_and_reclaim((void*)f_1076,c,av);}
a=C_alloc((c-3)*C_SIZEOF_PAIR+7);
t3=C_build_rest(&a,c,3,av);
C_word t4;
C_word t5;
C_word t6;
t4=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_1084,a[2]=t1,a[3]=t3,tmp=(C_word)a,a+=4,tmp);
t5=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1088,a[2]=t4,tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:168: scheme#symbol->string"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[12]+1));
C_word *av2=av;
av2[0]=*((C_word*)lf[12]+1);
av2[1]=t5;
av2[2]=t2;
tp(3,av2);}}

/* k1082 in foreign.c-bytevectors#complain in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1084(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,4)))){
C_save_and_reclaim((void *)f_1084,c,av);}{
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=0;
av2[1]=((C_word*)t0)[2];
av2[2]=*((C_word*)lf[9]+1);
av2[3]=t1;
av2[4]=((C_word*)t0)[3];
C_apply(5,av2);}}

/* k1086 in foreign.c-bytevectors#complain in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1088(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,3)))){
C_save_and_reclaim((void *)f_1088,c,av);}
C_trace(C_text("foreign/c-bytevectors.sld:167: scheme#string-append"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[10]+1));
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[10]+1);
av2[1]=((C_word*)t0)[2];
av2[2]=lf[11];
av2[3]=t1;
tp(4,av2);}}

/* foreign.c-bytevectors#make-uint-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1090(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3;
C_word *a;
if(c!=3) C_bad_argc_2(c,3,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(4,c,5)))){
C_save_and_reclaim((void *)f_1090,c,av);}
a=C_alloc(4);
t3=t1;{
C_word *av2=av;
av2[0]=t3;
av2[1]=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_1092,a[2]=t2,a[3]=((C_word)li3),tmp=(C_word)a,a+=4,tmp);
((C_proc)(void*)(*((C_word*)t3+1)))(2,av2);}}

/* f_1092 in foreign.c-bytevectors#make-uint-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1092(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4=av[4];
C_word t5;
C_word *a;
if(c!=5) C_bad_argc_2(c,5,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,5)))){
C_save_and_reclaim((void *)f_1092,c,av);}
C_trace(C_text("foreign/c-bytevectors.sld:203: c-bytevector-uint-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[14]);
C_word *av2;
if(c >= 6) {
  av2=av;
} else {
  av2=C_alloc(6);
}
av2[0]=*((C_word*)lf[14]+1);
av2[1]=t1;
av2[2]=t2;
av2[3]=t3;
av2[4]=t4;
av2[5]=((C_word*)t0)[2];
tp(6,av2);}}

/* foreign.c-bytevectors#make-sint-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1098(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3;
C_word *a;
if(c!=3) C_bad_argc_2(c,3,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(4,c,5)))){
C_save_and_reclaim((void *)f_1098,c,av);}
a=C_alloc(4);
t3=t1;{
C_word *av2=av;
av2[0]=t3;
av2[1]=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_1100,a[2]=t2,a[3]=((C_word)li5),tmp=(C_word)a,a+=4,tmp);
((C_proc)(void*)(*((C_word*)t3+1)))(2,av2);}}

/* f_1100 in foreign.c-bytevectors#make-sint-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1100(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4=av[4];
C_word t5;
C_word *a;
if(c!=5) C_bad_argc_2(c,5,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,5)))){
C_save_and_reclaim((void *)f_1100,c,av);}
C_trace(C_text("foreign/c-bytevectors.sld:207: c-bytevector-sint-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[16]);
C_word *av2;
if(c >= 6) {
  av2=av;
} else {
  av2=C_alloc(6);
}
av2[0]=*((C_word*)lf[16]+1);
av2[1]=t1;
av2[2]=t2;
av2[3]=t3;
av2[4]=t4;
av2[5]=((C_word*)t0)[2];
tp(6,av2);}}

/* foreign.c-bytevectors#make-uint-set! in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1106(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3;
C_word *a;
if(c!=3) C_bad_argc_2(c,3,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(4,c,6)))){
C_save_and_reclaim((void *)f_1106,c,av);}
a=C_alloc(4);
t3=t1;{
C_word *av2=av;
av2[0]=t3;
av2[1]=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_1108,a[2]=t2,a[3]=((C_word)li7),tmp=(C_word)a,a+=4,tmp);
((C_proc)(void*)(*((C_word*)t3+1)))(2,av2);}}

/* f_1108 in foreign.c-bytevectors#make-uint-set! in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1108(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4=av[4];
C_word t5=av[5];
C_word t6;
C_word *a;
if(c!=6) C_bad_argc_2(c,6,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,6)))){
C_save_and_reclaim((void *)f_1108,c,av);}
C_trace(C_text("foreign/c-bytevectors.sld:211: c-bytevector-uint-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[18]);
C_word *av2;
if(c >= 7) {
  av2=av;
} else {
  av2=C_alloc(7);
}
av2[0]=*((C_word*)lf[18]+1);
av2[1]=t1;
av2[2]=t2;
av2[3]=t3;
av2[4]=t4;
av2[5]=t5;
av2[6]=((C_word*)t0)[2];
tp(7,av2);}}

/* foreign.c-bytevectors#make-sint-set! in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1114(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3;
C_word *a;
if(c!=3) C_bad_argc_2(c,3,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(4,c,6)))){
C_save_and_reclaim((void *)f_1114,c,av);}
a=C_alloc(4);
t3=t1;{
C_word *av2=av;
av2[0]=t3;
av2[1]=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_1116,a[2]=t2,a[3]=((C_word)li9),tmp=(C_word)a,a+=4,tmp);
((C_proc)(void*)(*((C_word*)t3+1)))(2,av2);}}

/* f_1116 in foreign.c-bytevectors#make-sint-set! in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1116(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4=av[4];
C_word t5=av[5];
C_word t6;
C_word *a;
if(c!=6) C_bad_argc_2(c,6,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,6)))){
C_save_and_reclaim((void *)f_1116,c,av);}
C_trace(C_text("foreign/c-bytevectors.sld:215: c-bytevector-sint-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[20]);
C_word *av2;
if(c >= 7) {
  av2=av;
} else {
  av2=C_alloc(7);
}
av2[0]=*((C_word*)lf[20]+1);
av2[1]=t1;
av2[2]=t2;
av2[3]=t3;
av2[4]=t4;
av2[5]=t5;
av2[6]=((C_word*)t0)[2];
tp(7,av2);}}

/* foreign.c-bytevectors#make-ref/native in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1122(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4;
C_word *a;
if(c!=4) C_bad_argc_2(c,4,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(5,c,4)))){
C_save_and_reclaim((void *)f_1122,c,av);}
a=C_alloc(5);
t4=t1;{
C_word *av2=av;
av2[0]=t4;
av2[1]=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_1124,a[2]=t3,a[3]=t2,a[4]=((C_word)li11),tmp=(C_word)a,a+=5,tmp);
((C_proc)(void*)(*((C_word*)t4+1)))(2,av2);}}

/* f_1124 in foreign.c-bytevectors#make-ref/native in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1124(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4;
C_word t5;
C_word *a;
if(c!=4) C_bad_argc_2(c,4,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(6,c,3)))){
C_save_and_reclaim((void *)f_1124,c,av);}
a=C_alloc(6);
t4=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_1128,a[2]=((C_word*)t0)[2],a[3]=t1,a[4]=t2,a[5]=t3,tmp=(C_word)a,a+=6,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:219: ensure-aligned"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[22]);
C_word *av2=av;
av2[0]=*((C_word*)lf[22]+1);
av2[1]=t4;
av2[2]=t3;
av2[3]=((C_word*)t0)[3];
tp(4,av2);}}

/* k1126 */
static void C_ccall f_1128(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(6,c,2)))){
C_save_and_reclaim((void *)f_1128,c,av);}
a=C_alloc(6);
t2=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_1135,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[5],tmp=(C_word)a,a+=6,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:220: native-endianness"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[2]);
C_word *av2=av;
av2[0]=*((C_word*)lf[2]+1);
av2[1]=t2;
tp(2,av2);}}

/* k1133 in k1126 */
static void C_ccall f_1135(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,4)))){
C_save_and_reclaim((void *)f_1135,c,av);}
C_trace(C_text("foreign/c-bytevectors.sld:220: base-ref"));
t2=((C_word*)t0)[2];{
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=t2;
av2[1]=((C_word*)t0)[3];
av2[2]=((C_word*)t0)[4];
av2[3]=((C_word*)t0)[5];
av2[4]=t1;
((C_proc)C_fast_retrieve_proc(t2))(5,av2);}}

/* foreign.c-bytevectors#make-set!/native in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1137(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4;
C_word *a;
if(c!=4) C_bad_argc_2(c,4,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(5,c,5)))){
C_save_and_reclaim((void *)f_1137,c,av);}
a=C_alloc(5);
t4=t1;{
C_word *av2=av;
av2[0]=t4;
av2[1]=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_1139,a[2]=t3,a[3]=t2,a[4]=((C_word)li13),tmp=(C_word)a,a+=5,tmp);
((C_proc)(void*)(*((C_word*)t4+1)))(2,av2);}}

/* f_1139 in foreign.c-bytevectors#make-set!/native in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1139(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4=av[4];
C_word t5;
C_word t6;
C_word *a;
if(c!=5) C_bad_argc_2(c,5,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(7,c,3)))){
C_save_and_reclaim((void *)f_1139,c,av);}
a=C_alloc(7);
t5=(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)f_1143,a[2]=((C_word*)t0)[2],a[3]=t1,a[4]=t2,a[5]=t3,a[6]=t4,tmp=(C_word)a,a+=7,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:224: ensure-aligned"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[22]);
C_word *av2=av;
av2[0]=*((C_word*)lf[22]+1);
av2[1]=t5;
av2[2]=t3;
av2[3]=((C_word*)t0)[3];
tp(4,av2);}}

/* k1141 */
static void C_ccall f_1143(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(7,c,2)))){
C_save_and_reclaim((void *)f_1143,c,av);}
a=C_alloc(7);
t2=(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)f_1150,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[5],a[6]=((C_word*)t0)[6],tmp=(C_word)a,a+=7,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:225: native-endianness"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[2]);
C_word *av2=av;
av2[0]=*((C_word*)lf[2]+1);
av2[1]=t2;
tp(2,av2);}}

/* k1148 in k1141 */
static void C_ccall f_1150(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,5)))){
C_save_and_reclaim((void *)f_1150,c,av);}
C_trace(C_text("foreign/c-bytevectors.sld:225: base-set!"));
t2=((C_word*)t0)[2];{
C_word *av2;
if(c >= 6) {
  av2=av;
} else {
  av2=C_alloc(6);
}
av2[0]=t2;
av2[1]=((C_word*)t0)[3];
av2[2]=((C_word*)t0)[4];
av2[3]=((C_word*)t0)[5];
av2[4]=((C_word*)t0)[6];
av2[5]=t1;
((C_proc)C_fast_retrieve_proc(t2))(6,av2);}}

/* foreign.c-bytevectors#ensure-aligned in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1152(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4;
C_word t5;
C_word t6;
C_word *a;
if(c!=4) C_bad_argc_2(c,4,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(5,c,4)))){
C_save_and_reclaim((void *)f_1152,c,av);}
a=C_alloc(5);
t4=C_s_a_i_remainder(&a,2,t2,t3);
t5=C_i_zerop(t4);
if(C_truep(C_i_not(t5))){
C_trace(C_text("foreign/c-bytevectors.sld:229: chicken.base#error"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[9]+1));
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=*((C_word*)lf[9]+1);
av2[1]=t1;
av2[2]=lf[24];
av2[3]=t2;
av2[4]=t3;
tp(5,av2);}}
else{
t6=t1;{
C_word *av2=av;
av2[0]=t6;
av2[1]=C_SCHEME_UNDEFINED;
((C_proc)(void*)(*((C_word*)t6+1)))(2,av2);}}}

/* foreign.c-bytevectors#make-int-list->c-bytevector in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1172(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3;
C_word *a;
if(c!=3) C_bad_argc_2(c,3,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(4,c,5)))){
C_save_and_reclaim((void *)f_1172,c,av);}
a=C_alloc(4);
t3=t1;{
C_word *av2=av;
av2[0]=t3;
av2[1]=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_1174,a[2]=t2,a[3]=((C_word)li18),tmp=(C_word)a,a+=4,tmp);
((C_proc)(void*)(*((C_word*)t3+1)))(2,av2);}}

/* f_1174 in foreign.c-bytevectors#make-int-list->c-bytevector in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1174(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4=av[4];
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word *a;
if(c!=5) C_bad_argc_2(c,5,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(40,c,2)))){
C_save_and_reclaim((void *)f_1174,c,av);}
a=C_alloc(40);
t5=(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)f_1178,a[2]=((C_word*)t0)[2],a[3]=t3,a[4]=t4,a[5]=t1,a[6]=t2,tmp=(C_word)a,a+=7,tmp);
t6=C_i_length(t2);
t7=C_s_a_i_times(&a,2,t4,t6);
C_trace(C_text("foreign/c-bytevectors.sld:243: make-c-bytevector"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[4]);
C_word *av2=av;
av2[0]=*((C_word*)lf[4]+1);
av2[1]=t5;
av2[2]=t7;
tp(3,av2);}}

/* k1176 */
static void C_ccall f_1178(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(16,c,4)))){
C_save_and_reclaim((void *)f_1178,c,av);}
a=C_alloc(16);
t2=(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)f_1179,a[2]=((C_word*)t0)[2],a[3]=t1,a[4]=((C_word*)t0)[3],a[5]=((C_word*)t0)[4],a[6]=((C_word)li16),tmp=(C_word)a,a+=7,tmp);
t3=C_SCHEME_UNDEFINED;
t4=(*a=C_VECTOR_TYPE|1,a[1]=t3,tmp=(C_word)a,a+=2,tmp);
t5=C_set_block_item(t4,0,(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)f_1188,a[2]=t1,a[3]=((C_word*)t0)[4],a[4]=t4,a[5]=t2,a[6]=((C_word)li17),tmp=(C_word)a,a+=7,tmp));
t6=((C_word*)t4)[1];
f_1188(t6,((C_word*)t0)[5],C_fix(0),((C_word*)t0)[6]);}

/* setter! in k1176 */
static void C_fcall f_1179(C_word t0,C_word t1,C_word t2,C_word t3){
C_word tmp;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,0,6)))){
C_save_and_reclaim_args((void *)trf_1179,4,t0,t1,t2,t3);}
C_trace(C_text("foreign/c-bytevectors.sld:245: c-bytevector-set!"));
t4=((C_word*)t0)[2];{
C_word av2[7];
av2[0]=t4;
av2[1]=t1;
av2[2]=((C_word*)t0)[3];
av2[3]=t2;
av2[4]=t3;
av2[5]=((C_word*)t0)[4];
av2[6]=((C_word*)t0)[5];
((C_proc)C_fast_retrieve_proc(t4))(7,av2);}}

/* loop in k1176 */
static void C_fcall f_1188(C_word t0,C_word t1,C_word t2,C_word t3){
C_word tmp;
C_word t4;
C_word t5;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(7,0,3)))){
C_save_and_reclaim_args((void *)trf_1188,4,t0,t1,t2,t3);}
a=C_alloc(7);
if(C_truep(C_i_nullp(t3))){
t4=t1;{
C_word av2[2];
av2[0]=t4;
av2[1]=((C_word*)t0)[2];
((C_proc)(void*)(*((C_word*)t4+1)))(2,av2);}}
else{
t4=(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)f_1198,a[2]=t2,a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=t1,a[6]=t3,tmp=(C_word)a,a+=7,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:250: setter!"));
t5=((C_word*)t0)[5];
f_1179(t5,t4,t2,C_i_car(t3));}}

/* k1196 in loop in k1176 */
static void C_ccall f_1198(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(29,c,3)))){
C_save_and_reclaim((void *)f_1198,c,av);}
a=C_alloc(29);
t2=C_s_a_i_plus(&a,2,((C_word*)t0)[2],((C_word*)t0)[3]);
C_trace(C_text("foreign/c-bytevectors.sld:251: loop"));
t3=((C_word*)((C_word*)t0)[4])[1];
f_1188(t3,((C_word*)t0)[5],t2,C_i_cdr(((C_word*)t0)[6]));}

/* foreign.c-bytevectors#c-bytevector:normalized-ieee-parts in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1241(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word *a;
if(c!=4) C_bad_argc_2(c,4,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(36,c,4)))){
C_save_and_reclaim((void *)f_1241,c,av);}
a=C_alloc(36);
if(C_truep(C_i_lessp(t2,t3))){
t4=C_SCHEME_UNDEFINED;
t5=(*a=C_VECTOR_TYPE|1,a[1]=t4,tmp=(C_word)a,a+=2,tmp);
t6=C_set_block_item(t5,0,(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_1253,a[2]=t3,a[3]=t5,a[4]=((C_word)li20),tmp=(C_word)a,a+=5,tmp));
t7=((C_word*)t5)[1];
f_1253(t7,t1,t2,C_fix(0));}
else{
t4=C_s_a_i_plus(&a,2,t3,t3);
if(C_truep(C_i_less_or_equalp(t4,t2))){
t5=C_SCHEME_UNDEFINED;
t6=(*a=C_VECTOR_TYPE|1,a[1]=t5,tmp=(C_word)a,a+=2,tmp);
t7=C_set_block_item(t6,0,(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_1285,a[2]=t2,a[3]=t6,a[4]=((C_word)li21),tmp=(C_word)a,a+=5,tmp));
t8=((C_word*)t6)[1];
f_1285(t8,t1,t3,C_fix(0));}
else{
C_trace(C_text("foreign/c-bytevectors.sld:312: scheme#values"));{
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=0;
av2[1]=t1;
av2[2]=C_fix(0);
av2[3]=t2;
av2[4]=t3;
C_values(5,av2);}}}}

/* doloop321 in foreign.c-bytevectors#c-bytevector:normalized-ieee-parts in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_fcall f_1253(C_word t0,C_word t1,C_word t2,C_word t3){
C_word tmp;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word t9;
C_word *a;
loop:
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(58,0,4)))){
C_save_and_reclaim_args((void *)trf_1253,4,t0,t1,t2,t3);}
a=C_alloc(58);
if(C_truep(C_i_greater_or_equalp(t2,((C_word*)t0)[2]))){
C_trace(C_text("foreign/c-bytevectors.sld:305: scheme#values"));{
C_word av2[5];
av2[0]=0;
av2[1]=t1;
av2[2]=t3;
av2[3]=t2;
av2[4]=((C_word*)t0)[2];
C_values(5,av2);}}
else{
t4=C_s_a_i_plus(&a,2,t2,t2);
t5=C_s_a_i_minus(&a,2,t3,C_fix(1));
t7=t1;
t8=t4;
t9=t5;
t1=t7;
t2=t8;
t3=t9;
goto loop;}}

/* doloop326 in foreign.c-bytevectors#c-bytevector:normalized-ieee-parts in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_fcall f_1285(C_word t0,C_word t1,C_word t2,C_word t3){
C_word tmp;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word t9;
C_word t10;
C_word *a;
loop:
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(87,0,4)))){
C_save_and_reclaim_args((void *)trf_1285,4,t0,t1,t2,t3);}
a=C_alloc(87);
t4=C_s_a_i_plus(&a,2,t2,t2);
if(C_truep(C_i_lessp(((C_word*)t0)[2],t4))){
C_trace(C_text("foreign/c-bytevectors.sld:310: scheme#values"));{
C_word av2[5];
av2[0]=0;
av2[1]=t1;
av2[2]=t3;
av2[3]=((C_word*)t0)[2];
av2[4]=t2;
C_values(5,av2);}}
else{
t5=C_s_a_i_plus(&a,2,t2,t2);
t6=C_s_a_i_plus(&a,2,t3,C_fix(1));
t8=t1;
t9=t5;
t10=t6;
t1=t8;
t2=t9;
t3=t10;
goto loop;}}

/* foreign.c-bytevectors#c-bytevector:ieee-parts in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1319(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4=av[4];
C_word t5;
C_word t6;
C_word *a;
if(c!=5) C_bad_argc_2(c,5,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(6,c,2)))){
C_save_and_reclaim((void *)f_1319,c,av);}
a=C_alloc(6);
t5=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_1326,a[2]=t4,a[3]=t1,a[4]=t3,a[5]=t2,tmp=(C_word)a,a+=6,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:334: chicken.base#nan?"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[54]+1));
C_word *av2=av;
av2[0]=*((C_word*)lf[54]+1);
av2[1]=t5;
av2[2]=t2;
tp(3,av2);}}

/* k1324 in foreign.c-bytevectors#c-bytevector:ieee-parts in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1326(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(34,c,2)))){
C_save_and_reclaim((void *)f_1326,c,av);}
a=C_alloc(34);
if(C_truep(t1)){
t2=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)va3683,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word)li23),tmp=(C_word)a,a+=5,tmp);
t3=t2;
va3683(t3,C_s_a_i_plus(&a,2,((C_word*)t0)[4],((C_word*)t0)[4]));}
else{
t2=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_1343,a[2]=((C_word*)t0)[5],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[2],tmp=(C_word)a,a+=6,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:336: chicken.base#infinite?"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[53]+1));
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=*((C_word*)lf[53]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[5];
tp(3,av2);}}}

/* k1341 in k1324 in foreign.c-bytevectors#c-bytevector:ieee-parts in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1343(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(34,c,4)))){
C_save_and_reclaim((void *)f_1343,c,av);}
a=C_alloc(34);
if(C_truep(t1)){
t2=C_i_positivep(((C_word*)t0)[2]);
t3=(C_truep(t2)?C_fix(0):C_fix(1));
t4=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)va3685,a[2]=((C_word*)t0)[3],a[3]=t3,a[4]=((C_word)li24),tmp=(C_word)a,a+=5,tmp);
t5=t4;
va3685(t5,C_s_a_i_plus(&a,2,((C_word*)t0)[4],((C_word*)t0)[4]));}
else{
if(C_truep(C_i_zerop(((C_word*)t0)[2]))){
t2=C_i_eqvp(((C_word*)t0)[2],lf[44]);
t3=(C_truep(t2)?C_fix(1):C_fix(0));
C_trace(C_text("foreign/c-bytevectors.sld:339: scheme#values"));{
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=0;
av2[1]=((C_word*)t0)[3];
av2[2]=t3;
av2[3]=C_fix(0);
av2[4]=C_fix(0);
C_values(5,av2);}}
else{
t2=C_i_negativep(((C_word*)t0)[2]);
t3=(C_truep(t2)?C_fix(1):C_fix(0));
t4=(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)f_1379,a[2]=((C_word*)t0)[4],a[3]=((C_word*)t0)[5],a[4]=t3,a[5]=((C_word*)t0)[2],a[6]=((C_word*)t0)[3],tmp=(C_word)a,a+=7,tmp);
t5=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1523,a[2]=t4,tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:342: scheme#abs"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[52]+1));
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=*((C_word*)lf[52]+1);
av2[1]=t5;
av2[2]=((C_word*)t0)[2];
tp(3,av2);}}}}

/* k1377 in k1341 in k1324 in foreign.c-bytevectors#c-bytevector:ieee-parts in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1379(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(8,c,2)))){
C_save_and_reclaim((void *)f_1379,c,av);}
a=C_alloc(8);
t2=(*a=C_CLOSURE_TYPE|7,a[1]=(C_word)f_1382,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[5],a[6]=((C_word*)t0)[6],a[7]=t1,tmp=(C_word)a,a+=8,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:343: scheme#numerator"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[50]);
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=*((C_word*)lf[50]+1);
av2[1]=t2;
av2[2]=t1;
tp(3,av2);}}

/* k1380 in k1377 in k1341 in k1324 in foreign.c-bytevectors#c-bytevector:ieee-parts in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1382(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(8,c,2)))){
C_save_and_reclaim((void *)f_1382,c,av);}
a=C_alloc(8);
t2=(*a=C_CLOSURE_TYPE|7,a[1]=(C_word)f_1385,a[2]=t1,a[3]=((C_word*)t0)[2],a[4]=((C_word*)t0)[3],a[5]=((C_word*)t0)[4],a[6]=((C_word*)t0)[5],a[7]=((C_word*)t0)[6],tmp=(C_word)a,a+=8,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:344: scheme#denominator"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[49]);
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=*((C_word*)lf[49]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[7];
tp(3,av2);}}

/* k1383 in k1380 in k1377 in k1341 in k1324 in foreign.c-bytevectors#c-bytevector:ieee-parts in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1385(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(12,c,5)))){
C_save_and_reclaim((void *)f_1385,c,av);}
a=C_alloc(12);
t2=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_1390,a[2]=((C_word*)t0)[2],a[3]=t1,a[4]=((C_word)li25),tmp=(C_word)a,a+=5,tmp);
t3=(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)f_1396,a[2]=((C_word*)t0)[3],a[3]=((C_word*)t0)[4],a[4]=((C_word*)t0)[5],a[5]=((C_word*)t0)[6],a[6]=((C_word)li30),tmp=(C_word)a,a+=7,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:345: scheme#call-with-values"));{
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=0;
av2[1]=((C_word*)t0)[7];
av2[2]=t2;
av2[3]=t3;
C_call_with_values(4,av2);}}

/* a1389 in k1383 in k1380 in k1377 in k1341 in k1324 in foreign.c-bytevectors#c-bytevector:ieee-parts in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1390(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
if(c!=2) C_bad_argc_2(c,2,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,3)))){
C_save_and_reclaim((void *)f_1390,c,av);}
C_trace(C_text("foreign/c-bytevectors.sld:346: c-bytevector:normalized-ieee-parts"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[42]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[42]+1);
av2[1]=t1;
av2[2]=((C_word*)t0)[2];
av2[3]=((C_word*)t0)[3];
tp(4,av2);}}

/* a1395 in k1383 in k1380 in k1377 in k1341 in k1324 in foreign.c-bytevectors#c-bytevector:ieee-parts in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1396(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4=av[4];
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word *a;
if(c!=5) C_bad_argc_2(c,5,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(73,c,2)))){
C_save_and_reclaim((void *)f_1396,c,av);}
a=C_alloc(73);
t5=C_s_a_i_plus(&a,2,t2,((C_word*)t0)[2]);
t6=(*a=C_CLOSURE_TYPE|9,a[1]=(C_word)f_1406,a[2]=t4,a[3]=((C_word*)t0)[3],a[4]=t3,a[5]=t1,a[6]=((C_word*)t0)[4],a[7]=t5,a[8]=((C_word*)t0)[5],a[9]=((C_word*)t0)[2],tmp=(C_word)a,a+=10,tmp);
t7=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)va3693,a[2]=t6,a[3]=t5,a[4]=((C_word)li29),tmp=(C_word)a,a+=5,tmp);
t8=t7;
va3693(t8,C_s_a_i_plus(&a,2,((C_word*)t0)[2],((C_word*)t0)[2]));}

/* k1404 in a1395 in k1383 in k1380 in k1377 in k1341 in k1324 in foreign.c-bytevectors#c-bytevector:ieee-parts in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1406(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(40,c,3)))){
C_save_and_reclaim((void *)f_1406,c,av);}
a=C_alloc(40);
if(C_truep(t1)){
if(C_truep(C_i_less_or_equalp(((C_word*)t0)[2],((C_word*)t0)[3]))){
t2=(*a=C_CLOSURE_TYPE|8,a[1]=(C_word)f_1415,a[2]=((C_word*)t0)[4],a[3]=((C_word*)t0)[5],a[4]=((C_word*)t0)[6],a[5]=((C_word*)t0)[7],a[6]=((C_word*)t0)[8],a[7]=((C_word*)t0)[9],a[8]=((C_word*)t0)[3],tmp=(C_word)a,a+=9,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:352: scheme#/"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[47]+1));
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[47]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[3];
av2[3]=((C_word*)t0)[2];
tp(4,av2);}}
else{
t2=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_1433,a[2]=((C_word*)t0)[5],a[3]=((C_word*)t0)[6],a[4]=((C_word*)t0)[7],a[5]=((C_word*)t0)[4],tmp=(C_word)a,a+=6,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:358: scheme#/"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[47]+1));
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[47]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[2];
av2[3]=((C_word*)t0)[3];
tp(4,av2);}}}
else{
t2=(*a=C_CLOSURE_TYPE|10,a[1]=(C_word)va3691,a[2]=((C_word*)t0)[7],a[3]=((C_word*)t0)[8],a[4]=((C_word*)t0)[5],a[5]=((C_word*)t0)[9],a[6]=((C_word*)t0)[3],a[7]=((C_word*)t0)[6],a[8]=((C_word*)t0)[4],a[9]=((C_word*)t0)[2],a[10]=((C_word)li28),tmp=(C_word)a,a+=11,tmp);
t3=t2;
va3691(t3,C_s_a_i_plus(&a,2,((C_word*)t0)[9],((C_word*)t0)[9]));}}

/* k1413 in k1404 in a1395 in k1383 in k1380 in k1377 in k1341 in k1324 in foreign.c-bytevectors#c-bytevector:ieee-parts in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1415(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(33,c,6)))){
C_save_and_reclaim((void *)f_1415,c,av);}
a=C_alloc(33);
t2=C_s_a_i_times(&a,2,((C_word*)t0)[2],t1);
if(C_truep(C_i_integerp(t1))){
C_trace(C_text("foreign/c-bytevectors.sld:355: scheme#values"));{
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=0;
av2[1]=((C_word*)t0)[3];
av2[2]=((C_word*)t0)[4];
av2[3]=((C_word*)t0)[5];
av2[4]=t2;
C_values(5,av2);}}
else{
C_trace(C_text("foreign/c-bytevectors.sld:356: chicken.base#error"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[9]+1));
C_word *av2;
if(c >= 7) {
  av2=av;
} else {
  av2=C_alloc(7);
}
av2[0]=*((C_word*)lf[9]+1);
av2[1]=((C_word*)t0)[3];
av2[2]=lf[45];
av2[3]=lf[46];
av2[4]=((C_word*)t0)[6];
av2[5]=((C_word*)t0)[7];
av2[6]=((C_word*)t0)[8];
tp(7,av2);}}}

/* k1431 in k1404 in a1395 in k1383 in k1380 in k1377 in k1341 in k1324 in foreign.c-bytevectors#c-bytevector:ieee-parts in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1433(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(5,c,3)))){
C_save_and_reclaim((void *)f_1433,c,av);}
a=C_alloc(5);
t2=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_1436,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],tmp=(C_word)a,a+=5,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:359: scheme#/"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[47]+1));
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[47]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[5];
av2[3]=t1;
tp(4,av2);}}

/* k1434 in k1431 in k1404 in a1395 in k1383 in k1380 in k1377 in k1341 in k1324 in foreign.c-bytevectors#c-bytevector:ieee-parts in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1436(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(5,c,2)))){
C_save_and_reclaim((void *)f_1436,c,av);}
a=C_alloc(5);
t2=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_1443,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],tmp=(C_word)a,a+=5,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:362: scheme#round"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[48]+1));
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=*((C_word*)lf[48]+1);
av2[1]=t2;
av2[2]=t1;
tp(3,av2);}}

/* k1441 in k1434 in k1431 in k1404 in a1395 in k1383 in k1380 in k1377 in k1341 in k1324 in foreign.c-bytevectors#c-bytevector:ieee-parts in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1443(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,4)))){
C_save_and_reclaim((void *)f_1443,c,av);}
C_trace(C_text("foreign/c-bytevectors.sld:360: scheme#values"));{
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=0;
av2[1]=((C_word*)t0)[2];
av2[2]=((C_word*)t0)[3];
av2[3]=((C_word*)t0)[4];
av2[4]=t1;
C_values(5,av2);}}

/* k1468 */
static void C_ccall f_1470(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(8,c,4)))){
C_save_and_reclaim((void *)f_1470,c,av);}
a=C_alloc(8);
t2=C_SCHEME_UNDEFINED;
t3=(*a=C_VECTOR_TYPE|1,a[1]=t2,tmp=(C_word)a,a+=2,tmp);
t4=C_set_block_item(t3,0,(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_1472,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=t3,a[5]=((C_word)li27),tmp=(C_word)a,a+=6,tmp));
t5=((C_word*)t3)[1];
f_1472(t5,((C_word*)t0)[4],((C_word*)t0)[5],t1);}

/* doloop355 in k1468 */
static void C_fcall f_1472(C_word t0,C_word t1,C_word t2,C_word t3){
C_word tmp;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word t9;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(39,0,4)))){
C_save_and_reclaim_args((void *)trf_1472,4,t0,t1,t2,t3);}
a=C_alloc(39);
t4=C_i_lessp(t3,((C_word*)t0)[2]);
t5=(C_truep(t4)?C_i_nequalp(t2,C_fix(1)):C_SCHEME_FALSE);
if(C_truep(t5)){
C_trace(C_text("foreign/c-bytevectors.sld:373: scheme#values"));{
C_word av2[5];
av2[0]=0;
av2[1]=t1;
av2[2]=((C_word*)t0)[3];
av2[3]=t2;
av2[4]=t3;
C_values(5,av2);}}
else{
t6=C_s_a_i_plus(&a,2,t2,C_fix(1));
t7=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_1493,a[2]=((C_word*)t0)[4],a[3]=t1,a[4]=t6,tmp=(C_word)a,a+=5,tmp);
t8=C_s_a_i_quotient(&a,2,t3,C_fix(2));
C_trace(C_text("foreign/c-bytevectors.sld:371: scheme#round"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[48]+1));
C_word av2[3];
av2[0]=*((C_word*)lf[48]+1);
av2[1]=t7;
av2[2]=t8;
tp(3,av2);}}}

/* k1491 in doloop355 in k1468 */
static void C_ccall f_1493(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,3)))){
C_save_and_reclaim((void *)f_1493,c,av);}
t2=((C_word*)((C_word*)t0)[2])[1];
f_1472(t2,((C_word*)t0)[3],((C_word*)t0)[4],t1);}

/* k1505 */
static void C_ccall f_1507(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,2)))){
C_save_and_reclaim((void *)f_1507,c,av);}
C_trace(C_text("foreign/c-bytevectors.sld:370: scheme#round"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[48]+1));
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=*((C_word*)lf[48]+1);
av2[1]=((C_word*)t0)[2];
av2[2]=t1;
tp(3,av2);}}

/* k1521 in k1341 in k1324 in foreign.c-bytevectors#c-bytevector:ieee-parts in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1523(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,2)))){
C_save_and_reclaim((void *)f_1523,c,av);}
C_trace(C_text("foreign/c-bytevectors.sld:342: scheme#inexact->exact"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[51]+1));
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=*((C_word*)lf[51]+1);
av2[1]=((C_word*)t0)[2];
av2[2]=t1;
tp(3,av2);}}

/* foreign.c-bytevectors#c-bytevector-ieee-double-big-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1528(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4;
C_word t5;
C_word t6;
C_word *a;
if(c!=4) C_bad_argc_2(c,4,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(34,c,3)))){
C_save_and_reclaim((void *)f_1528,c,av);}
a=C_alloc(34);
t4=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_1532,a[2]=t1,a[3]=t3,a[4]=t2,tmp=(C_word)a,a+=5,tmp);
t5=C_s_a_i_plus(&a,2,t3,C_fix(0));
C_trace(C_text("foreign/c-bytevectors.sld:383: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word *av2=av;
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t4;
av2[2]=t2;
av2[3]=t5;
tp(4,av2);}}

/* k1530 in foreign.c-bytevectors#c-bytevector-ieee-double-big-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1532(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(35,c,3)))){
C_save_and_reclaim((void *)f_1532,c,av);}
a=C_alloc(35);
t2=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_1535,a[2]=t1,a[3]=((C_word*)t0)[2],a[4]=((C_word*)t0)[3],a[5]=((C_word*)t0)[4],tmp=(C_word)a,a+=6,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[3],C_fix(1));
C_trace(C_text("foreign/c-bytevectors.sld:384: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[4];
av2[3]=t3;
tp(4,av2);}}

/* k1533 in k1530 in foreign.c-bytevectors#c-bytevector-ieee-double-big-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1535(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(36,c,3)))){
C_save_and_reclaim((void *)f_1535,c,av);}
a=C_alloc(36);
t2=(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)f_1538,a[2]=((C_word*)t0)[2],a[3]=t1,a[4]=((C_word*)t0)[3],a[5]=((C_word*)t0)[4],a[6]=((C_word*)t0)[5],tmp=(C_word)a,a+=7,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[4],C_fix(2));
C_trace(C_text("foreign/c-bytevectors.sld:385: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[5];
av2[3]=t3;
tp(4,av2);}}

/* k1536 in k1533 in k1530 in foreign.c-bytevectors#c-bytevector-ieee-double-big-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1538(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(37,c,3)))){
C_save_and_reclaim((void *)f_1538,c,av);}
a=C_alloc(37);
t2=(*a=C_CLOSURE_TYPE|7,a[1]=(C_word)f_1541,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=t1,a[5]=((C_word*)t0)[4],a[6]=((C_word*)t0)[5],a[7]=((C_word*)t0)[6],tmp=(C_word)a,a+=8,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[5],C_fix(3));
C_trace(C_text("foreign/c-bytevectors.sld:386: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[6];
av2[3]=t3;
tp(4,av2);}}

/* k1539 in k1536 in k1533 in k1530 in foreign.c-bytevectors#c-bytevector-ieee-double-big-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1541(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(38,c,3)))){
C_save_and_reclaim((void *)f_1541,c,av);}
a=C_alloc(38);
t2=(*a=C_CLOSURE_TYPE|8,a[1]=(C_word)f_1544,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=t1,a[6]=((C_word*)t0)[5],a[7]=((C_word*)t0)[6],a[8]=((C_word*)t0)[7],tmp=(C_word)a,a+=9,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[6],C_fix(4));
C_trace(C_text("foreign/c-bytevectors.sld:387: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[7];
av2[3]=t3;
tp(4,av2);}}

/* k1542 in k1539 in k1536 in k1533 in k1530 in foreign.c-bytevectors#c-bytevector-ieee-double-big-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1544(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(39,c,3)))){
C_save_and_reclaim((void *)f_1544,c,av);}
a=C_alloc(39);
t2=(*a=C_CLOSURE_TYPE|9,a[1]=(C_word)f_1547,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[5],a[6]=t1,a[7]=((C_word*)t0)[6],a[8]=((C_word*)t0)[7],a[9]=((C_word*)t0)[8],tmp=(C_word)a,a+=10,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[7],C_fix(5));
C_trace(C_text("foreign/c-bytevectors.sld:388: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[8];
av2[3]=t3;
tp(4,av2);}}

/* k1545 in k1542 in k1539 in k1536 in k1533 in k1530 in foreign.c-bytevectors#c-bytevector-ieee-double-big-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1547(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(40,c,3)))){
C_save_and_reclaim((void *)f_1547,c,av);}
a=C_alloc(40);
t2=(*a=C_CLOSURE_TYPE|10,a[1]=(C_word)f_1550,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[5],a[6]=((C_word*)t0)[6],a[7]=t1,a[8]=((C_word*)t0)[7],a[9]=((C_word*)t0)[8],a[10]=((C_word*)t0)[9],tmp=(C_word)a,a+=11,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[8],C_fix(6));
C_trace(C_text("foreign/c-bytevectors.sld:389: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[9];
av2[3]=t3;
tp(4,av2);}}

/* k1548 in k1545 in k1542 in k1539 in k1536 in k1533 in k1530 in foreign.c-bytevectors#c-bytevector-ieee-double-big-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1550(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(39,c,3)))){
C_save_and_reclaim((void *)f_1550,c,av);}
a=C_alloc(39);
t2=(*a=C_CLOSURE_TYPE|9,a[1]=(C_word)f_1553,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[5],a[6]=((C_word*)t0)[6],a[7]=((C_word*)t0)[7],a[8]=t1,a[9]=((C_word*)t0)[8],tmp=(C_word)a,a+=10,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[9],C_fix(7));
C_trace(C_text("foreign/c-bytevectors.sld:390: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[10];
av2[3]=t3;
tp(4,av2);}}

/* k1551 in k1548 in k1545 in k1542 in k1539 in k1536 in k1533 in k1530 in foreign.c-bytevectors#c-bytevector-ieee-double-big-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1553(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word t9;
C_word t10;
C_word t11;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(188,c,2)))){
C_save_and_reclaim((void *)f_1553,c,av);}
a=C_alloc(188);
t2=C_s_a_i_quotient(&a,2,((C_word*)t0)[2],C_fix(128));
t3=C_s_a_i_remainder(&a,2,((C_word*)t0)[2],C_fix(128));
t4=C_s_a_i_times(&a,2,C_fix(16),t3);
t5=C_s_a_i_quotient(&a,2,((C_word*)t0)[3],C_fix(16));
t6=C_s_a_i_plus(&a,2,t4,t5);
t7=C_s_a_i_remainder(&a,2,((C_word*)t0)[3],C_fix(16));
t8=C_s_a_i_times(&a,2,C_fix(65536),t7);
t9=C_s_a_i_times(&a,2,C_fix(256),((C_word*)t0)[4]);
t10=(*a=C_CLOSURE_TYPE|10,a[1]=(C_word)va3695,a[2]=((C_word*)t0)[5],a[3]=((C_word*)t0)[6],a[4]=((C_word*)t0)[7],a[5]=((C_word*)t0)[8],a[6]=t1,a[7]=((C_word*)t0)[9],a[8]=t2,a[9]=t6,a[10]=((C_word)li32),tmp=(C_word)a,a+=11,tmp);
t11=t10;
va3695(t11,C_s_a_i_plus(&a,2,t8,t9));}

/* foreign.c-bytevectors#c-bytevector-ieee-double-little-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1637(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4;
C_word t5;
C_word t6;
C_word *a;
if(c!=4) C_bad_argc_2(c,4,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(34,c,3)))){
C_save_and_reclaim((void *)f_1637,c,av);}
a=C_alloc(34);
t4=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_1641,a[2]=t1,a[3]=t3,a[4]=t2,tmp=(C_word)a,a+=5,tmp);
t5=C_s_a_i_plus(&a,2,t3,C_fix(7));
C_trace(C_text("foreign/c-bytevectors.sld:402: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word *av2=av;
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t4;
av2[2]=t2;
av2[3]=t5;
tp(4,av2);}}

/* k1639 in foreign.c-bytevectors#c-bytevector-ieee-double-little-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1641(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(35,c,3)))){
C_save_and_reclaim((void *)f_1641,c,av);}
a=C_alloc(35);
t2=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_1644,a[2]=t1,a[3]=((C_word*)t0)[2],a[4]=((C_word*)t0)[3],a[5]=((C_word*)t0)[4],tmp=(C_word)a,a+=6,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[3],C_fix(6));
C_trace(C_text("foreign/c-bytevectors.sld:403: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[4];
av2[3]=t3;
tp(4,av2);}}

/* k1642 in k1639 in foreign.c-bytevectors#c-bytevector-ieee-double-little-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1644(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(36,c,3)))){
C_save_and_reclaim((void *)f_1644,c,av);}
a=C_alloc(36);
t2=(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)f_1647,a[2]=((C_word*)t0)[2],a[3]=t1,a[4]=((C_word*)t0)[3],a[5]=((C_word*)t0)[4],a[6]=((C_word*)t0)[5],tmp=(C_word)a,a+=7,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[4],C_fix(5));
C_trace(C_text("foreign/c-bytevectors.sld:404: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[5];
av2[3]=t3;
tp(4,av2);}}

/* k1645 in k1642 in k1639 in foreign.c-bytevectors#c-bytevector-ieee-double-little-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1647(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(37,c,3)))){
C_save_and_reclaim((void *)f_1647,c,av);}
a=C_alloc(37);
t2=(*a=C_CLOSURE_TYPE|7,a[1]=(C_word)f_1650,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=t1,a[5]=((C_word*)t0)[4],a[6]=((C_word*)t0)[5],a[7]=((C_word*)t0)[6],tmp=(C_word)a,a+=8,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[5],C_fix(4));
C_trace(C_text("foreign/c-bytevectors.sld:405: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[6];
av2[3]=t3;
tp(4,av2);}}

/* k1648 in k1645 in k1642 in k1639 in foreign.c-bytevectors#c-bytevector-ieee-double-little-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1650(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(38,c,3)))){
C_save_and_reclaim((void *)f_1650,c,av);}
a=C_alloc(38);
t2=(*a=C_CLOSURE_TYPE|8,a[1]=(C_word)f_1653,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=t1,a[6]=((C_word*)t0)[5],a[7]=((C_word*)t0)[6],a[8]=((C_word*)t0)[7],tmp=(C_word)a,a+=9,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[6],C_fix(3));
C_trace(C_text("foreign/c-bytevectors.sld:406: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[7];
av2[3]=t3;
tp(4,av2);}}

/* k1651 in k1648 in k1645 in k1642 in k1639 in foreign.c-bytevectors#c-bytevector-ieee-double-little-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1653(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(39,c,3)))){
C_save_and_reclaim((void *)f_1653,c,av);}
a=C_alloc(39);
t2=(*a=C_CLOSURE_TYPE|9,a[1]=(C_word)f_1656,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[5],a[6]=t1,a[7]=((C_word*)t0)[6],a[8]=((C_word*)t0)[7],a[9]=((C_word*)t0)[8],tmp=(C_word)a,a+=10,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[7],C_fix(2));
C_trace(C_text("foreign/c-bytevectors.sld:407: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[8];
av2[3]=t3;
tp(4,av2);}}

/* k1654 in k1651 in k1648 in k1645 in k1642 in k1639 in foreign.c-bytevectors#c-bytevector-ieee-double-little-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1656(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(40,c,3)))){
C_save_and_reclaim((void *)f_1656,c,av);}
a=C_alloc(40);
t2=(*a=C_CLOSURE_TYPE|10,a[1]=(C_word)f_1659,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[5],a[6]=((C_word*)t0)[6],a[7]=t1,a[8]=((C_word*)t0)[7],a[9]=((C_word*)t0)[8],a[10]=((C_word*)t0)[9],tmp=(C_word)a,a+=11,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[8],C_fix(1));
C_trace(C_text("foreign/c-bytevectors.sld:408: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[9];
av2[3]=t3;
tp(4,av2);}}

/* k1657 in k1654 in k1651 in k1648 in k1645 in k1642 in k1639 in foreign.c-bytevectors#c-bytevector-ieee-double-little-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1659(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(39,c,3)))){
C_save_and_reclaim((void *)f_1659,c,av);}
a=C_alloc(39);
t2=(*a=C_CLOSURE_TYPE|9,a[1]=(C_word)f_1662,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[5],a[6]=((C_word*)t0)[6],a[7]=((C_word*)t0)[7],a[8]=t1,a[9]=((C_word*)t0)[8],tmp=(C_word)a,a+=10,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[9],C_fix(0));
C_trace(C_text("foreign/c-bytevectors.sld:409: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[10];
av2[3]=t3;
tp(4,av2);}}

/* k1660 in k1657 in k1654 in k1651 in k1648 in k1645 in k1642 in k1639 in foreign.c-bytevectors#c-bytevector-ieee-double-little-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1662(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word t9;
C_word t10;
C_word t11;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(188,c,2)))){
C_save_and_reclaim((void *)f_1662,c,av);}
a=C_alloc(188);
t2=C_s_a_i_quotient(&a,2,((C_word*)t0)[2],C_fix(128));
t3=C_s_a_i_remainder(&a,2,((C_word*)t0)[2],C_fix(128));
t4=C_s_a_i_times(&a,2,C_fix(16),t3);
t5=C_s_a_i_quotient(&a,2,((C_word*)t0)[3],C_fix(16));
t6=C_s_a_i_plus(&a,2,t4,t5);
t7=C_s_a_i_remainder(&a,2,((C_word*)t0)[3],C_fix(16));
t8=C_s_a_i_times(&a,2,C_fix(65536),t7);
t9=C_s_a_i_times(&a,2,C_fix(256),((C_word*)t0)[4]);
t10=(*a=C_CLOSURE_TYPE|10,a[1]=(C_word)va3697,a[2]=((C_word*)t0)[5],a[3]=((C_word*)t0)[6],a[4]=((C_word*)t0)[7],a[5]=((C_word*)t0)[8],a[6]=t1,a[7]=((C_word*)t0)[9],a[8]=t2,a[9]=t6,a[10]=((C_word)li34),tmp=(C_word)a,a+=11,tmp);
t11=t10;
va3697(t11,C_s_a_i_plus(&a,2,t8,t9));}

/* foreign.c-bytevectors#c-bytevector-ieee-single-big-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1746(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4;
C_word t5;
C_word t6;
C_word *a;
if(c!=4) C_bad_argc_2(c,4,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(34,c,3)))){
C_save_and_reclaim((void *)f_1746,c,av);}
a=C_alloc(34);
t4=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_1750,a[2]=t1,a[3]=t3,a[4]=t2,tmp=(C_word)a,a+=5,tmp);
t5=C_s_a_i_plus(&a,2,t3,C_fix(0));
C_trace(C_text("foreign/c-bytevectors.sld:425: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word *av2=av;
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t4;
av2[2]=t2;
av2[3]=t5;
tp(4,av2);}}

/* k1748 in foreign.c-bytevectors#c-bytevector-ieee-single-big-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1750(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(35,c,3)))){
C_save_and_reclaim((void *)f_1750,c,av);}
a=C_alloc(35);
t2=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_1753,a[2]=t1,a[3]=((C_word*)t0)[2],a[4]=((C_word*)t0)[3],a[5]=((C_word*)t0)[4],tmp=(C_word)a,a+=6,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[3],C_fix(1));
C_trace(C_text("foreign/c-bytevectors.sld:426: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[4];
av2[3]=t3;
tp(4,av2);}}

/* k1751 in k1748 in foreign.c-bytevectors#c-bytevector-ieee-single-big-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1753(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(36,c,3)))){
C_save_and_reclaim((void *)f_1753,c,av);}
a=C_alloc(36);
t2=(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)f_1756,a[2]=((C_word*)t0)[2],a[3]=t1,a[4]=((C_word*)t0)[3],a[5]=((C_word*)t0)[4],a[6]=((C_word*)t0)[5],tmp=(C_word)a,a+=7,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[4],C_fix(2));
C_trace(C_text("foreign/c-bytevectors.sld:427: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[5];
av2[3]=t3;
tp(4,av2);}}

/* k1754 in k1751 in k1748 in foreign.c-bytevectors#c-bytevector-ieee-single-big-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1756(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(35,c,3)))){
C_save_and_reclaim((void *)f_1756,c,av);}
a=C_alloc(35);
t2=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_1759,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=t1,a[5]=((C_word*)t0)[4],tmp=(C_word)a,a+=6,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[5],C_fix(3));
C_trace(C_text("foreign/c-bytevectors.sld:428: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[6];
av2[3]=t3;
tp(4,av2);}}

/* k1757 in k1754 in k1751 in k1748 in foreign.c-bytevectors#c-bytevector-ieee-single-big-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1759(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word t9;
C_word t10;
C_word t11;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(184,c,2)))){
C_save_and_reclaim((void *)f_1759,c,av);}
a=C_alloc(184);
t2=C_s_a_i_quotient(&a,2,((C_word*)t0)[2],C_fix(128));
t3=C_s_a_i_remainder(&a,2,((C_word*)t0)[2],C_fix(128));
t4=C_s_a_i_times(&a,2,C_fix(2),t3);
t5=C_s_a_i_quotient(&a,2,((C_word*)t0)[3],C_fix(128));
t6=C_s_a_i_plus(&a,2,t4,t5);
t7=C_s_a_i_remainder(&a,2,((C_word*)t0)[3],C_fix(128));
t8=C_s_a_i_times(&a,2,C_fix(65536),t7);
t9=C_s_a_i_times(&a,2,C_fix(256),((C_word*)t0)[4]);
t10=(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)va3699,a[2]=t1,a[3]=((C_word*)t0)[5],a[4]=t2,a[5]=t6,a[6]=((C_word)li36),tmp=(C_word)a,a+=7,tmp);
t11=t10;
va3699(t11,C_s_a_i_plus(&a,2,t8,t9));}

/* foreign.c-bytevectors#c-bytevector-ieee-single-little-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1813(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4;
C_word t5;
C_word t6;
C_word *a;
if(c!=4) C_bad_argc_2(c,4,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(34,c,3)))){
C_save_and_reclaim((void *)f_1813,c,av);}
a=C_alloc(34);
t4=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_1817,a[2]=t1,a[3]=t3,a[4]=t2,tmp=(C_word)a,a+=5,tmp);
t5=C_s_a_i_plus(&a,2,t3,C_fix(3));
C_trace(C_text("foreign/c-bytevectors.sld:438: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word *av2=av;
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t4;
av2[2]=t2;
av2[3]=t5;
tp(4,av2);}}

/* k1815 in foreign.c-bytevectors#c-bytevector-ieee-single-little-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1817(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(35,c,3)))){
C_save_and_reclaim((void *)f_1817,c,av);}
a=C_alloc(35);
t2=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_1820,a[2]=t1,a[3]=((C_word*)t0)[2],a[4]=((C_word*)t0)[3],a[5]=((C_word*)t0)[4],tmp=(C_word)a,a+=6,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[3],C_fix(2));
C_trace(C_text("foreign/c-bytevectors.sld:439: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[4];
av2[3]=t3;
tp(4,av2);}}

/* k1818 in k1815 in foreign.c-bytevectors#c-bytevector-ieee-single-little-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1820(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(36,c,3)))){
C_save_and_reclaim((void *)f_1820,c,av);}
a=C_alloc(36);
t2=(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)f_1823,a[2]=((C_word*)t0)[2],a[3]=t1,a[4]=((C_word*)t0)[3],a[5]=((C_word*)t0)[4],a[6]=((C_word*)t0)[5],tmp=(C_word)a,a+=7,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[4],C_fix(1));
C_trace(C_text("foreign/c-bytevectors.sld:440: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[5];
av2[3]=t3;
tp(4,av2);}}

/* k1821 in k1818 in k1815 in foreign.c-bytevectors#c-bytevector-ieee-single-little-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1823(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(35,c,3)))){
C_save_and_reclaim((void *)f_1823,c,av);}
a=C_alloc(35);
t2=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_1826,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=t1,a[5]=((C_word*)t0)[4],tmp=(C_word)a,a+=6,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[5],C_fix(0));
C_trace(C_text("foreign/c-bytevectors.sld:441: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[6];
av2[3]=t3;
tp(4,av2);}}

/* k1824 in k1821 in k1818 in k1815 in foreign.c-bytevectors#c-bytevector-ieee-single-little-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1826(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word t9;
C_word t10;
C_word t11;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(184,c,2)))){
C_save_and_reclaim((void *)f_1826,c,av);}
a=C_alloc(184);
t2=C_s_a_i_quotient(&a,2,((C_word*)t0)[2],C_fix(128));
t3=C_s_a_i_remainder(&a,2,((C_word*)t0)[2],C_fix(128));
t4=C_s_a_i_times(&a,2,C_fix(2),t3);
t5=C_s_a_i_quotient(&a,2,((C_word*)t0)[3],C_fix(128));
t6=C_s_a_i_plus(&a,2,t4,t5);
t7=C_s_a_i_remainder(&a,2,((C_word*)t0)[3],C_fix(128));
t8=C_s_a_i_times(&a,2,C_fix(65536),t7);
t9=C_s_a_i_times(&a,2,C_fix(256),((C_word*)t0)[4]);
t10=(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)va3701,a[2]=t1,a[3]=((C_word*)t0)[5],a[4]=t2,a[5]=t6,a[6]=((C_word)li38),tmp=(C_word)a,a+=7,tmp);
t11=t10;
va3701(t11,C_s_a_i_plus(&a,2,t8,t9));}

/* foreign.c-bytevectors#make-ieee-double in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1880(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4=av[4];
C_word t5=av[5];
C_word t6=av[6];
C_word t7;
C_word t8;
C_word t9;
C_word *a;
if(c!=7) C_bad_argc_2(c,7,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(36,c,2)))){
C_save_and_reclaim((void *)f_1880,c,av);}
a=C_alloc(36);
if(C_truep(C_i_nequalp(t3,C_fast_retrieve(lf[29])))){
t7=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)va3703,a[2]=t6,a[3]=t2,a[4]=t1,a[5]=((C_word)li40),tmp=(C_word)a,a+=6,tmp);
t8=t7;
va3703(t8,C_s_a_i_plus(&a,2,t4,t5));}
else{
if(C_truep(C_i_nequalp(C_fix(0),t3))){
t7=(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)f_1921,a[2]=t2,a[3]=t1,a[4]=t6,a[5]=t5,a[6]=t4,tmp=(C_word)a,a+=7,tmp);
if(C_truep(C_i_nequalp(C_fix(0),t4))){
t8=C_i_nequalp(C_fix(0),t5);
t9=t7;
f_1921(t9,(C_truep(t8)?C_i_nequalp(C_fix(0),t6):C_SCHEME_FALSE));}
else{
t8=t7;
f_1921(t8,C_SCHEME_FALSE);}}
else{
t7=C_s_a_i_plus(&a,2,C_fix(1048576),t4);
t8=(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)f_1993,a[2]=t2,a[3]=t1,a[4]=t3,a[5]=t6,a[6]=t5,tmp=(C_word)a,a+=7,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:495: scheme#exact->inexact"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[70]+1));
C_word *av2=av;
av2[0]=*((C_word*)lf[70]+1);
av2[1]=t8;
av2[2]=t7;
tp(3,av2);}}}}

/* k1919 in foreign.c-bytevectors#make-ieee-double in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_fcall f_1921(C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(6,0,2)))){
C_save_and_reclaim_args((void *)trf_1921,2,t0,t1);}
a=C_alloc(6);
if(C_truep(t1)){
t2=C_i_nequalp(C_fix(0),((C_word*)t0)[2]);
t3=((C_word*)t0)[3];{
C_word av2[2];
av2[0]=t3;
av2[1]=(C_truep(t2)?lf[65]:lf[44]);
((C_proc)(void*)(*((C_word*)t3+1)))(2,av2);}}
else{
t2=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_1930,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[5],tmp=(C_word)a,a+=6,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:481: scheme#exact->inexact"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[70]+1));
C_word av2[3];
av2[0]=*((C_word*)lf[70]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[6];
tp(3,av2);}}}

/* k1928 in k1919 in foreign.c-bytevectors#make-ieee-double in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1930(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(39,c,2)))){
C_save_and_reclaim((void *)f_1930,c,av);}
a=C_alloc(39);
t2=C_s_a_i_times(&a,2,lf[66],t1);
t3=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_1975,a[2]=t2,a[3]=((C_word*)t0)[2],a[4]=((C_word*)t0)[3],a[5]=((C_word*)t0)[4],tmp=(C_word)a,a+=6,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:483: scheme#exact->inexact"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[70]+1));
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=*((C_word*)lf[70]+1);
av2[1]=t3;
av2[2]=((C_word*)t0)[5];
tp(3,av2);}}

/* k1937 in k1965 in k1973 in k1928 in k1919 in foreign.c-bytevectors#make-ieee-double in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1939(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(8,c,2)))){
C_save_and_reclaim((void *)f_1939,c,av);}
a=C_alloc(8);
t2=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_1955,a[2]=t1,a[3]=((C_word*)t0)[2],a[4]=((C_word*)t0)[3],tmp=(C_word)a,a+=5,tmp);
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1959,a[2]=t2,tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:488: scheme#-"));{
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=0;
av2[1]=t3;
av2[2]=C_fast_retrieve(lf[30]);
C_minus(3,av2);}}

/* k1953 in k1937 in k1965 in k1973 in k1928 in k1919 in foreign.c-bytevectors#make-ieee-double in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1955(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(33,c,2)))){
C_save_and_reclaim((void *)f_1955,c,av);}
a=C_alloc(33);
t2=C_s_a_i_times(&a,2,((C_word*)t0)[2],t1);
if(C_truep(C_i_nequalp(C_fix(0),((C_word*)t0)[3]))){
t3=((C_word*)t0)[4];{
C_word *av2=av;
av2[0]=t3;
av2[1]=t2;
((C_proc)(void*)(*((C_word*)t3+1)))(2,av2);}}
else{
C_trace(C_text("foreign/c-bytevectors.sld:491: scheme#-"));{
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=0;
av2[1]=((C_word*)t0)[4];
av2[2]=t2;
C_minus(3,av2);}}}

/* k1957 in k1937 in k1965 in k1973 in k1928 in k1919 in foreign.c-bytevectors#make-ieee-double in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1959(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,3)))){
C_save_and_reclaim((void *)f_1959,c,av);}
C_trace(C_text("foreign/c-bytevectors.sld:488: scheme#expt"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[67]+1));
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[67]+1);
av2[1]=((C_word*)t0)[2];
av2[2]=lf[68];
av2[3]=t1;
tp(4,av2);}}

/* k1965 in k1973 in k1928 in k1919 in foreign.c-bytevectors#make-ieee-double in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1967(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(33,c,3)))){
C_save_and_reclaim((void *)f_1967,c,av);}
a=C_alloc(33);
t2=C_s_a_i_plus(&a,2,((C_word*)t0)[2],t1);
t3=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_1939,a[2]=((C_word*)t0)[3],a[3]=((C_word*)t0)[4],tmp=(C_word)a,a+=4,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:487: scheme#/"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[47]+1));
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[47]+1);
av2[1]=t3;
av2[2]=t2;
av2[3]=lf[69];
tp(4,av2);}}

/* k1973 in k1928 in k1919 in foreign.c-bytevectors#make-ieee-double in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1975(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(67,c,2)))){
C_save_and_reclaim((void *)f_1975,c,av);}
a=C_alloc(67);
t2=C_s_a_i_plus(&a,2,((C_word*)t0)[2],t1);
t3=C_s_a_i_times(&a,2,lf[66],t2);
t4=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_1967,a[2]=t3,a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],tmp=(C_word)a,a+=5,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:485: scheme#exact->inexact"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[70]+1));
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=*((C_word*)lf[70]+1);
av2[1]=t4;
av2[2]=((C_word*)t0)[5];
tp(3,av2);}}

/* k1991 in foreign.c-bytevectors#make-ieee-double in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_1993(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(40,c,2)))){
C_save_and_reclaim((void *)f_1993,c,av);}
a=C_alloc(40);
t2=C_s_a_i_times(&a,2,lf[66],t1);
t3=(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)f_2038,a[2]=t2,a[3]=((C_word*)t0)[2],a[4]=((C_word*)t0)[3],a[5]=((C_word*)t0)[4],a[6]=((C_word*)t0)[5],tmp=(C_word)a,a+=7,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:497: scheme#exact->inexact"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[70]+1));
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=*((C_word*)lf[70]+1);
av2[1]=t3;
av2[2]=((C_word*)t0)[6];
tp(3,av2);}}

/* k2000 in k2028 in k2036 in k1991 in foreign.c-bytevectors#make-ieee-double in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2002(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(34,c,3)))){
C_save_and_reclaim((void *)f_2002,c,av);}
a=C_alloc(34);
t2=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_2018,a[2]=t1,a[3]=((C_word*)t0)[2],a[4]=((C_word*)t0)[3],tmp=(C_word)a,a+=5,tmp);
t3=C_s_a_i_minus(&a,2,((C_word*)t0)[4],C_fast_retrieve(lf[30]));
C_trace(C_text("foreign/c-bytevectors.sld:502: scheme#expt"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[67]+1));
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[67]+1);
av2[1]=t2;
av2[2]=lf[68];
av2[3]=t3;
tp(4,av2);}}

/* k2016 in k2000 in k2028 in k2036 in k1991 in foreign.c-bytevectors#make-ieee-double in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2018(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(33,c,2)))){
C_save_and_reclaim((void *)f_2018,c,av);}
a=C_alloc(33);
t2=C_s_a_i_times(&a,2,((C_word*)t0)[2],t1);
if(C_truep(C_i_nequalp(C_fix(0),((C_word*)t0)[3]))){
t3=((C_word*)t0)[4];{
C_word *av2=av;
av2[0]=t3;
av2[1]=t2;
((C_proc)(void*)(*((C_word*)t3+1)))(2,av2);}}
else{
C_trace(C_text("foreign/c-bytevectors.sld:506: scheme#-"));{
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=0;
av2[1]=((C_word*)t0)[4];
av2[2]=t2;
C_minus(3,av2);}}}

/* k2028 in k2036 in k1991 in foreign.c-bytevectors#make-ieee-double in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2030(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(34,c,3)))){
C_save_and_reclaim((void *)f_2030,c,av);}
a=C_alloc(34);
t2=C_s_a_i_plus(&a,2,((C_word*)t0)[2],t1);
t3=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_2002,a[2]=((C_word*)t0)[3],a[3]=((C_word*)t0)[4],a[4]=((C_word*)t0)[5],tmp=(C_word)a,a+=5,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:501: scheme#/"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[47]+1));
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[47]+1);
av2[1]=t3;
av2[2]=t2;
av2[3]=lf[71];
tp(4,av2);}}

/* k2036 in k1991 in foreign.c-bytevectors#make-ieee-double in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2038(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(68,c,2)))){
C_save_and_reclaim((void *)f_2038,c,av);}
a=C_alloc(68);
t2=C_s_a_i_plus(&a,2,((C_word*)t0)[2],t1);
t3=C_s_a_i_times(&a,2,lf[66],t2);
t4=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_2030,a[2]=t3,a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[5],tmp=(C_word)a,a+=6,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:499: scheme#exact->inexact"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[70]+1));
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=*((C_word*)lf[70]+1);
av2[1]=t4;
av2[2]=((C_word*)t0)[6];
tp(3,av2);}}

/* foreign.c-bytevectors#make-ieee-single in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2040(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4=av[4];
C_word t5;
C_word t6;
C_word t7;
C_word *a;
if(c!=5) C_bad_argc_2(c,5,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(34,c,2)))){
C_save_and_reclaim((void *)f_2040,c,av);}
a=C_alloc(34);
if(C_truep(C_i_nequalp(t3,C_fast_retrieve(lf[26])))){
if(C_truep(C_i_zerop(t4))){
t5=C_i_nequalp(C_fix(0),t2);
t6=t1;{
C_word *av2=av;
av2[0]=t6;
av2[1]=(C_truep(t5)?lf[61]:lf[62]);
((C_proc)(void*)(*((C_word*)t6+1)))(2,av2);}}
else{
t5=C_i_nequalp(C_fix(0),t2);
t6=t1;{
C_word *av2=av;
av2[0]=t6;
av2[1]=(C_truep(t5)?lf[72]:lf[73]);
((C_proc)(void*)(*((C_word*)t6+1)))(2,av2);}}}
else{
if(C_truep(C_i_nequalp(C_fix(0),t3))){
if(C_truep(C_i_nequalp(C_fix(0),t4))){
t5=C_i_nequalp(C_fix(0),t2);
t6=t1;{
C_word *av2=av;
av2[0]=t6;
av2[1]=(C_truep(t5)?lf[65]:lf[44]);
((C_proc)(void*)(*((C_word*)t6+1)))(2,av2);}}
else{
t5=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_2086,a[2]=t2,a[3]=t1,tmp=(C_word)a,a+=4,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:535: scheme#exact->inexact"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[70]+1));
C_word *av2=av;
av2[0]=*((C_word*)lf[70]+1);
av2[1]=t5;
av2[2]=t4;
tp(3,av2);}}}
else{
t5=C_s_a_i_plus(&a,2,C_fix(8388608),t4);
t6=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_2115,a[2]=t2,a[3]=t1,a[4]=t3,tmp=(C_word)a,a+=5,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:545: scheme#exact->inexact"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[70]+1));
C_word *av2=av;
av2[0]=*((C_word*)lf[70]+1);
av2[1]=t6;
av2[2]=t5;
tp(3,av2);}}}}

/* k2084 in foreign.c-bytevectors#make-ieee-single in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2086(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(4,c,3)))){
C_save_and_reclaim((void *)f_2086,c,av);}
a=C_alloc(4);
t2=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_2089,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],tmp=(C_word)a,a+=4,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:537: scheme#/"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[47]+1));
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[47]+1);
av2[1]=t2;
av2[2]=t1;
av2[3]=lf[74];
tp(4,av2);}}

/* k2087 in k2084 in foreign.c-bytevectors#make-ieee-single in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2089(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(8,c,2)))){
C_save_and_reclaim((void *)f_2089,c,av);}
a=C_alloc(8);
t2=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_2105,a[2]=t1,a[3]=((C_word*)t0)[2],a[4]=((C_word*)t0)[3],tmp=(C_word)a,a+=5,tmp);
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2109,a[2]=t2,tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:538: scheme#-"));{
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=0;
av2[1]=t3;
av2[2]=C_fast_retrieve(lf[27]);
C_minus(3,av2);}}

/* k2103 in k2087 in k2084 in foreign.c-bytevectors#make-ieee-single in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2105(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(33,c,2)))){
C_save_and_reclaim((void *)f_2105,c,av);}
a=C_alloc(33);
t2=C_s_a_i_times(&a,2,((C_word*)t0)[2],t1);
if(C_truep(C_i_nequalp(C_fix(0),((C_word*)t0)[3]))){
t3=((C_word*)t0)[4];{
C_word *av2=av;
av2[0]=t3;
av2[1]=t2;
((C_proc)(void*)(*((C_word*)t3+1)))(2,av2);}}
else{
C_trace(C_text("foreign/c-bytevectors.sld:541: scheme#-"));{
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=0;
av2[1]=((C_word*)t0)[4];
av2[2]=t2;
C_minus(3,av2);}}}

/* k2107 in k2087 in k2084 in foreign.c-bytevectors#make-ieee-single in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2109(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,3)))){
C_save_and_reclaim((void *)f_2109,c,av);}
C_trace(C_text("foreign/c-bytevectors.sld:538: scheme#expt"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[67]+1));
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[67]+1);
av2[1]=((C_word*)t0)[2];
av2[2]=lf[68];
av2[3]=t1;
tp(4,av2);}}

/* k2113 in foreign.c-bytevectors#make-ieee-single in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2115(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(5,c,3)))){
C_save_and_reclaim((void *)f_2115,c,av);}
a=C_alloc(5);
t2=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_2118,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],tmp=(C_word)a,a+=5,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:547: scheme#/"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[47]+1));
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[47]+1);
av2[1]=t2;
av2[2]=t1;
av2[3]=lf[75];
tp(4,av2);}}

/* k2116 in k2113 in foreign.c-bytevectors#make-ieee-single in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2118(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(34,c,3)))){
C_save_and_reclaim((void *)f_2118,c,av);}
a=C_alloc(34);
t2=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_2134,a[2]=t1,a[3]=((C_word*)t0)[2],a[4]=((C_word*)t0)[3],tmp=(C_word)a,a+=5,tmp);
t3=C_s_a_i_minus(&a,2,((C_word*)t0)[4],C_fast_retrieve(lf[27]));
C_trace(C_text("foreign/c-bytevectors.sld:548: scheme#expt"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[67]+1));
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[67]+1);
av2[1]=t2;
av2[2]=lf[68];
av2[3]=t3;
tp(4,av2);}}

/* k2132 in k2116 in k2113 in foreign.c-bytevectors#make-ieee-single in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2134(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(33,c,2)))){
C_save_and_reclaim((void *)f_2134,c,av);}
a=C_alloc(33);
t2=C_s_a_i_times(&a,2,((C_word*)t0)[2],t1);
if(C_truep(C_i_nequalp(C_fix(0),((C_word*)t0)[3]))){
t3=((C_word*)t0)[4];{
C_word *av2=av;
av2[0]=t3;
av2[1]=t2;
((C_proc)(void*)(*((C_word*)t3+1)))(2,av2);}}
else{
C_trace(C_text("foreign/c-bytevectors.sld:552: scheme#-"));{
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=0;
av2[1]=((C_word*)t0)[4];
av2[2]=t2;
C_minus(3,av2);}}}

/* foreign.c-bytevectors#r6rs:c-bytevector-copy! in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2140(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4=av[4];
C_word t5=av[5];
C_word t6=av[6];
C_word t7;
C_word t8;
C_word t9;
C_word t10;
C_word t11;
C_word *a;
if(c!=7) C_bad_argc_2(c,7,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(39,c,3)))){
C_save_and_reclaim((void *)f_2140,c,av);}
a=C_alloc(39);
if(C_truep(C_i_greater_or_equalp(t3,t5))){
t7=C_SCHEME_UNDEFINED;
t8=(*a=C_VECTOR_TYPE|1,a[1]=t7,tmp=(C_word)a,a+=2,tmp);
t9=C_set_block_item(t8,0,(*a=C_CLOSURE_TYPE|8,a[1]=(C_word)f_2152,a[2]=t6,a[3]=t8,a[4]=t5,a[5]=t4,a[6]=t3,a[7]=t2,a[8]=((C_word)li43),tmp=(C_word)a,a+=9,tmp));
t10=((C_word*)t8)[1];
f_2152(t10,t1,C_fix(0));}
else{
t7=C_s_a_i_minus(&a,2,t6,C_fix(1));
t8=C_SCHEME_UNDEFINED;
t9=(*a=C_VECTOR_TYPE|1,a[1]=t8,tmp=(C_word)a,a+=2,tmp);
t10=C_set_block_item(t9,0,(*a=C_CLOSURE_TYPE|7,a[1]=(C_word)f_2190,a[2]=t9,a[3]=t5,a[4]=t4,a[5]=t3,a[6]=t2,a[7]=((C_word)li44),tmp=(C_word)a,a+=8,tmp));
t11=((C_word*)t9)[1];
f_2190(t11,t1,t7);}}

/* doloop494 in foreign.c-bytevectors#r6rs:c-bytevector-copy! in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_fcall f_2152(C_word t0,C_word t1,C_word t2){
C_word tmp;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(68,0,3)))){
C_save_and_reclaim_args((void *)trf_2152,3,t0,t1,t2);}
a=C_alloc(68);
if(C_truep(C_i_greater_or_equalp(t2,((C_word*)t0)[2]))){
t3=t1;{
C_word av2[2];
av2[0]=t3;
av2[1]=C_SCHEME_UNDEFINED;
((C_proc)(void*)(*((C_word*)t3+1)))(2,av2);}}
else{
t3=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_2162,a[2]=t2,a[3]=((C_word*)t0)[3],a[4]=t1,tmp=(C_word)a,a+=5,tmp);
t4=C_s_a_i_plus(&a,2,((C_word*)t0)[4],t2);
t5=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_2177,a[2]=t3,a[3]=((C_word*)t0)[5],a[4]=t4,tmp=(C_word)a,a+=5,tmp);
t6=C_s_a_i_plus(&a,2,((C_word*)t0)[6],t2);
C_trace(C_text("foreign/c-bytevectors.sld:589: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word av2[4];
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t5;
av2[2]=((C_word*)t0)[7];
av2[3]=t6;
tp(4,av2);}}}

/* k2160 in doloop494 in foreign.c-bytevectors#r6rs:c-bytevector-copy! in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2162(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(29,c,2)))){
C_save_and_reclaim((void *)f_2162,c,av);}
a=C_alloc(29);
t2=C_s_a_i_plus(&a,2,((C_word*)t0)[2],C_fix(1));
t3=((C_word*)((C_word*)t0)[3])[1];
f_2152(t3,((C_word*)t0)[4],t2);}

/* k2175 in doloop494 in foreign.c-bytevectors#r6rs:c-bytevector-copy! in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2177(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,4)))){
C_save_and_reclaim((void *)f_2177,c,av);}
C_trace(C_text("foreign/c-bytevectors.sld:587: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=*((C_word*)lf[5]+1);
av2[1]=((C_word*)t0)[2];
av2[2]=((C_word*)t0)[3];
av2[3]=((C_word*)t0)[4];
av2[4]=t1;
tp(5,av2);}}

/* doloop499 in foreign.c-bytevectors#r6rs:c-bytevector-copy! in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_fcall f_2190(C_word t0,C_word t1,C_word t2){
C_word tmp;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(68,0,3)))){
C_save_and_reclaim_args((void *)trf_2190,3,t0,t1,t2);}
a=C_alloc(68);
if(C_truep(C_i_lessp(t2,C_fix(0)))){
t3=t1;{
C_word av2[2];
av2[0]=t3;
av2[1]=C_SCHEME_UNDEFINED;
((C_proc)(void*)(*((C_word*)t3+1)))(2,av2);}}
else{
t3=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_2200,a[2]=t2,a[3]=((C_word*)t0)[2],a[4]=t1,tmp=(C_word)a,a+=5,tmp);
t4=C_s_a_i_plus(&a,2,((C_word*)t0)[3],t2);
t5=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_2215,a[2]=t3,a[3]=((C_word*)t0)[4],a[4]=t4,tmp=(C_word)a,a+=5,tmp);
t6=C_s_a_i_plus(&a,2,((C_word*)t0)[5],t2);
C_trace(C_text("foreign/c-bytevectors.sld:594: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word av2[4];
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t5;
av2[2]=((C_word*)t0)[6];
av2[3]=t6;
tp(4,av2);}}}

/* k2198 in doloop499 in foreign.c-bytevectors#r6rs:c-bytevector-copy! in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2200(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(29,c,2)))){
C_save_and_reclaim((void *)f_2200,c,av);}
a=C_alloc(29);
t2=C_s_a_i_minus(&a,2,((C_word*)t0)[2],C_fix(1));
t3=((C_word*)((C_word*)t0)[3])[1];
f_2190(t3,((C_word*)t0)[4],t2);}

/* k2213 in doloop499 in foreign.c-bytevectors#r6rs:c-bytevector-copy! in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2215(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,4)))){
C_save_and_reclaim((void *)f_2215,c,av);}
C_trace(C_text("foreign/c-bytevectors.sld:592: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=*((C_word*)lf[5]+1);
av2[1]=((C_word*)t0)[2];
av2[2]=((C_word*)t0)[3];
av2[3]=((C_word*)t0)[4];
av2[4]=t1;
tp(5,av2);}}

/* foreign.c-bytevectors#c-bytevector-s8-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2221(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4;
C_word t5;
C_word *a;
if(c!=4) C_bad_argc_2(c,4,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,3)))){
C_save_and_reclaim((void *)f_2221,c,av);}
a=C_alloc(3);
t4=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2225,a[2]=t1,tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:603: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word *av2=av;
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t4;
av2[2]=t2;
av2[3]=t3;
tp(4,av2);}}

/* k2223 in foreign.c-bytevectors#c-bytevector-s8-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2225(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(29,c,1)))){
C_save_and_reclaim((void *)f_2225,c,av);}
a=C_alloc(29);
t2=C_i_greaterp(t1,C_fix(127));
t3=((C_word*)t0)[2];{
C_word *av2=av;
av2[0]=t3;
av2[1]=(C_truep(t2)?C_s_a_i_minus(&a,2,t1,C_fix(256)):t1);
((C_proc)(void*)(*((C_word*)t3+1)))(2,av2);}}

/* foreign.c-bytevectors#c-bytevector-s8-set! in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2236(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4=av[4];
C_word t5;
C_word t6;
C_word t7;
C_word *a;
if(c!=5) C_bad_argc_2(c,5,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(29,c,4)))){
C_save_and_reclaim((void *)f_2236,c,av);}
a=C_alloc(29);
t5=C_i_negativep(t4);
t6=(C_truep(t5)?C_s_a_i_plus(&a,2,t4,C_fix(256)):t4);
C_trace(C_text("foreign/c-bytevectors.sld:606: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word *av2=av;
av2[0]=*((C_word*)lf[5]+1);
av2[1]=t1;
av2[2]=t2;
av2[3]=t3;
av2[4]=t6;
tp(5,av2);}}

/* foreign.c-bytevectors#u8-list->c-bytevector in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2252(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3;
C_word t4;
C_word t5;
C_word *a;
if(c!=3) C_bad_argc_2(c,3,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(4,c,2)))){
C_save_and_reclaim((void *)f_2252,c,av);}
a=C_alloc(4);
t3=C_i_length(t2);
t4=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_2259,a[2]=t1,a[3]=t2,tmp=(C_word)a,a+=4,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:617: make-c-bytevector"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[4]);
C_word *av2=av;
av2[0]=*((C_word*)lf[4]+1);
av2[1]=t4;
av2[2]=t3;
tp(3,av2);}}

/* k2257 in foreign.c-bytevectors#u8-list->c-bytevector in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2259(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(11,c,4)))){
C_save_and_reclaim((void *)f_2259,c,av);}
a=C_alloc(11);
t2=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_2262,a[2]=((C_word*)t0)[2],a[3]=t1,tmp=(C_word)a,a+=4,tmp);
t3=C_SCHEME_UNDEFINED;
t4=(*a=C_VECTOR_TYPE|1,a[1]=t3,tmp=(C_word)a,a+=2,tmp);
t5=C_set_block_item(t4,0,(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_2264,a[2]=t4,a[3]=t1,a[4]=((C_word)li48),tmp=(C_word)a,a+=5,tmp));
t6=((C_word*)t4)[1];
f_2264(t6,t2,((C_word*)t0)[3],C_fix(0));}

/* k2260 in k2257 in foreign.c-bytevectors#u8-list->c-bytevector in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2262(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,1)))){
C_save_and_reclaim((void *)f_2262,c,av);}
t2=((C_word*)t0)[2];{
C_word *av2=av;
av2[0]=t2;
av2[1]=((C_word*)t0)[3];
((C_proc)(void*)(*((C_word*)t2+1)))(2,av2);}}

/* doloop527 in k2257 in foreign.c-bytevectors#u8-list->c-bytevector in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_fcall f_2264(C_word t0,C_word t1,C_word t2,C_word t3){
C_word tmp;
C_word t4;
C_word t5;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(6,0,4)))){
C_save_and_reclaim_args((void *)trf_2264,4,t0,t1,t2,t3);}
a=C_alloc(6);
if(C_truep(C_i_nullp(t2))){
t4=t1;{
C_word av2[2];
av2[0]=t4;
av2[1]=C_SCHEME_UNDEFINED;
((C_proc)(void*)(*((C_word*)t4+1)))(2,av2);}}
else{
t4=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_2274,a[2]=t2,a[3]=t3,a[4]=((C_word*)t0)[2],a[5]=t1,tmp=(C_word)a,a+=6,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:621: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word av2[5];
av2[0]=*((C_word*)lf[5]+1);
av2[1]=t4;
av2[2]=((C_word*)t0)[3];
av2[3]=t3;
av2[4]=C_i_car(t2);
tp(5,av2);}}}

/* k2272 in doloop527 in k2257 in foreign.c-bytevectors#u8-list->c-bytevector in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2274(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(29,c,3)))){
C_save_and_reclaim((void *)f_2274,c,av);}
a=C_alloc(29);
t2=C_i_cdr(((C_word*)t0)[2]);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[3],C_fix(1));
t4=((C_word*)((C_word*)t0)[4])[1];
f_2264(t4,((C_word*)t0)[5],t2,t3);}

/* foreign.c-bytevectors#c-bytevector-uchar-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2291(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4;
C_word t5;
C_word *a;
if(c!=4) C_bad_argc_2(c,4,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,3)))){
C_save_and_reclaim((void *)f_2291,c,av);}
a=C_alloc(3);
t4=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2299,a[2]=t1,tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:625: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word *av2=av;
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t4;
av2[2]=t2;
av2[3]=t3;
tp(4,av2);}}

/* k2297 in foreign.c-bytevectors#c-bytevector-uchar-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2299(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,1)))){
C_save_and_reclaim((void *)f_2299,c,av);}
t2=((C_word*)t0)[2];{
C_word *av2=av;
av2[0]=t2;
av2[1]=C_make_character(C_unfix(t1));
((C_proc)(void*)(*((C_word*)t2+1)))(2,av2);}}

/* foreign.c-bytevectors#c-bytevector-uchar-set! in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2301(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4=av[4];
C_word t5;
C_word *a;
if(c!=5) C_bad_argc_2(c,5,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,4)))){
C_save_and_reclaim((void *)f_2301,c,av);}
C_trace(C_text("foreign/c-bytevectors.sld:628: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word *av2=av;
av2[0]=*((C_word*)lf[5]+1);
av2[1]=t1;
av2[2]=t2;
av2[3]=t3;
av2[4]=C_fix(C_character_code(t4));
tp(5,av2);}}

/* foreign.c-bytevectors#c-bytevector-char-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2311(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4;
C_word t5;
C_word *a;
if(c!=4) C_bad_argc_2(c,4,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,3)))){
C_save_and_reclaim((void *)f_2311,c,av);}
a=C_alloc(3);
t4=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2319,a[2]=t1,tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:631: c-bytevector-s8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[77]);
C_word *av2=av;
av2[0]=*((C_word*)lf[77]+1);
av2[1]=t4;
av2[2]=t2;
av2[3]=t3;
tp(4,av2);}}

/* k2317 in foreign.c-bytevectors#c-bytevector-char-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2319(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,1)))){
C_save_and_reclaim((void *)f_2319,c,av);}
t2=((C_word*)t0)[2];{
C_word *av2=av;
av2[0]=t2;
av2[1]=C_make_character(C_unfix(t1));
((C_proc)(void*)(*((C_word*)t2+1)))(2,av2);}}

/* foreign.c-bytevectors#c-bytevector-char-set! in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2321(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4=av[4];
C_word t5;
C_word *a;
if(c!=5) C_bad_argc_2(c,5,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,4)))){
C_save_and_reclaim((void *)f_2321,c,av);}
C_trace(C_text("foreign/c-bytevectors.sld:634: c-bytevector-s8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[78]);
C_word *av2=av;
av2[0]=*((C_word*)lf[78]+1);
av2[1]=t1;
av2[2]=t2;
av2[3]=t3;
av2[4]=C_fix(C_character_code(t4));
tp(5,av2);}}

/* foreign.c-bytevectors#c-bytevector-uint-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2331(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4=av[4];
C_word t5=av[5];
C_word t6;
C_word t7;
C_word t8;
C_word t9;
C_word t10;
C_word t11;
C_word t12;
C_word *a;
if(c!=6) C_bad_argc_2(c,6,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(37,c,4)))){
C_save_and_reclaim((void *)f_2331,c,av);}
a=C_alloc(37);
t6=C_eqp(t4,lf[84]);
if(C_truep(t6)){
t7=C_SCHEME_UNDEFINED;
t8=(*a=C_VECTOR_TYPE|1,a[1]=t7,tmp=(C_word)a,a+=2,tmp);
t9=C_set_block_item(t8,0,(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)f_2343,a[2]=t5,a[3]=t8,a[4]=t3,a[5]=t2,a[6]=((C_word)li54),tmp=(C_word)a,a+=7,tmp));
t10=((C_word*)t8)[1];
f_2343(t10,t1,C_fix(0),C_fix(0));}
else{
t7=C_eqp(t4,lf[3]);
if(C_truep(t7)){
t8=C_s_a_i_minus(&a,2,t5,C_fix(1));
t9=C_SCHEME_UNDEFINED;
t10=(*a=C_VECTOR_TYPE|1,a[1]=t9,tmp=(C_word)a,a+=2,tmp);
t11=C_set_block_item(t10,0,(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_2388,a[2]=t10,a[3]=t3,a[4]=t2,a[5]=((C_word)li55),tmp=(C_word)a,a+=6,tmp));
t12=((C_word*)t10)[1];
f_2388(t12,t1,t8,C_fix(0));}
else{
t8=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_2425,a[2]=t1,a[3]=t2,a[4]=t3,a[5]=t5,tmp=(C_word)a,a+=6,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:650: native-endianness"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[2]);
C_word *av2=av;
av2[0]=*((C_word*)lf[2]+1);
av2[1]=t8;
tp(2,av2);}}}}

/* doloop557 in foreign.c-bytevectors#c-bytevector-uint-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_fcall f_2343(C_word t0,C_word t1,C_word t2,C_word t3){
C_word tmp;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(97,0,3)))){
C_save_and_reclaim_args((void *)trf_2343,4,t0,t1,t2,t3);}
a=C_alloc(97);
if(C_truep(C_i_greater_or_equalp(t2,((C_word*)t0)[2]))){
t4=t1;{
C_word av2[2];
av2[0]=t4;
av2[1]=t3;
((C_proc)(void*)(*((C_word*)t4+1)))(2,av2);}}
else{
t4=C_s_a_i_plus(&a,2,t2,C_fix(1));
t5=C_s_a_i_times(&a,2,C_fix(256),t3);
t6=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_2369,a[2]=t5,a[3]=((C_word*)t0)[3],a[4]=t1,a[5]=t4,tmp=(C_word)a,a+=6,tmp);
t7=C_s_a_i_plus(&a,2,((C_word*)t0)[4],t2);
C_trace(C_text("foreign/c-bytevectors.sld:640: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word av2[4];
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t6;
av2[2]=((C_word*)t0)[5];
av2[3]=t7;
tp(4,av2);}}}

/* k2367 in doloop557 in foreign.c-bytevectors#c-bytevector-uint-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2369(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(29,c,3)))){
C_save_and_reclaim((void *)f_2369,c,av);}
a=C_alloc(29);
t2=C_s_a_i_plus(&a,2,((C_word*)t0)[2],t1);
t3=((C_word*)((C_word*)t0)[3])[1];
f_2343(t3,((C_word*)t0)[4],((C_word*)t0)[5],t2);}

/* doloop562 in foreign.c-bytevectors#c-bytevector-uint-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_fcall f_2388(C_word t0,C_word t1,C_word t2,C_word t3){
C_word tmp;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(97,0,3)))){
C_save_and_reclaim_args((void *)trf_2388,4,t0,t1,t2,t3);}
a=C_alloc(97);
if(C_truep(C_i_lessp(t2,C_fix(0)))){
t4=t1;{
C_word av2[2];
av2[0]=t4;
av2[1]=t3;
((C_proc)(void*)(*((C_word*)t4+1)))(2,av2);}}
else{
t4=C_s_a_i_minus(&a,2,t2,C_fix(1));
t5=C_s_a_i_times(&a,2,C_fix(256),t3);
t6=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_2414,a[2]=t5,a[3]=((C_word*)t0)[2],a[4]=t1,a[5]=t4,tmp=(C_word)a,a+=6,tmp);
t7=C_s_a_i_plus(&a,2,((C_word*)t0)[3],t2);
C_trace(C_text("foreign/c-bytevectors.sld:646: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word av2[4];
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t6;
av2[2]=((C_word*)t0)[4];
av2[3]=t7;
tp(4,av2);}}}

/* k2412 in doloop562 in foreign.c-bytevectors#c-bytevector-uint-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2414(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(29,c,3)))){
C_save_and_reclaim((void *)f_2414,c,av);}
a=C_alloc(29);
t2=C_s_a_i_plus(&a,2,((C_word*)t0)[2],t1);
t3=((C_word*)((C_word*)t0)[3])[1];
f_2388(t3,((C_word*)t0)[4],((C_word*)t0)[5],t2);}

/* k2423 in foreign.c-bytevectors#c-bytevector-uint-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2425(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,5)))){
C_save_and_reclaim((void *)f_2425,c,av);}
C_trace(C_text("foreign/c-bytevectors.sld:650: c-bytevector-uint-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[14]);
C_word *av2;
if(c >= 6) {
  av2=av;
} else {
  av2=C_alloc(6);
}
av2[0]=*((C_word*)lf[14]+1);
av2[1]=((C_word*)t0)[2];
av2[2]=((C_word*)t0)[3];
av2[3]=((C_word*)t0)[4];
av2[4]=t1;
av2[5]=((C_word*)t0)[5];
tp(6,av2);}}

/* foreign.c-bytevectors#c-bytevector-sint-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2427(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4=av[4];
C_word t5=av[5];
C_word t6;
C_word t7;
C_word t8;
C_word t9;
C_word t10;
C_word *a;
if(c!=6) C_bad_argc_2(c,6,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(44,c,2)))){
C_save_and_reclaim((void *)f_2427,c,av);}
a=C_alloc(44);
t6=(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)f_2431,a[2]=t1,a[3]=t5,a[4]=t2,a[5]=t3,a[6]=t4,tmp=(C_word)a,a+=7,tmp);
t7=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_2451,a[2]=t6,a[3]=t2,tmp=(C_word)a,a+=4,tmp);
t8=C_eqp(t4,lf[84]);
if(C_truep(t8)){
t9=t7;
f_2451(t9,t3);}
else{
t9=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)va3715,a[2]=t7,a[3]=((C_word)li57),tmp=(C_word)a,a+=4,tmp);
t10=t9;
va3715(t10,C_s_a_i_plus(&a,2,t3,t5));}}

/* k2429 in foreign.c-bytevectors#c-bytevector-sint-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2431(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(5,c,5)))){
C_save_and_reclaim((void *)f_2431,c,av);}
a=C_alloc(5);
t2=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_2434,a[2]=t1,a[3]=((C_word*)t0)[2],a[4]=((C_word*)t0)[3],tmp=(C_word)a,a+=5,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:657: c-bytevector-uint-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[14]);
C_word *av2;
if(c >= 6) {
  av2=av;
} else {
  av2=C_alloc(6);
}
av2[0]=*((C_word*)lf[14]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[4];
av2[3]=((C_word*)t0)[5];
av2[4]=((C_word*)t0)[6];
av2[5]=((C_word*)t0)[3];
tp(6,av2);}}

/* k2432 in k2429 in foreign.c-bytevectors#c-bytevector-sint-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2434(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(4,c,3)))){
C_save_and_reclaim((void *)f_2434,c,av);}
a=C_alloc(4);
if(C_truep(C_i_greaterp(((C_word*)t0)[2],C_fix(127)))){
t2=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_2447,a[2]=((C_word*)t0)[3],a[3]=t1,tmp=(C_word)a,a+=4,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:659: scheme#expt"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[67]+1));
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[67]+1);
av2[1]=t2;
av2[2]=C_fix(256);
av2[3]=((C_word*)t0)[4];
tp(4,av2);}}
else{
t2=((C_word*)t0)[3];{
C_word *av2=av;
av2[0]=t2;
av2[1]=t1;
((C_proc)(void*)(*((C_word*)t2+1)))(2,av2);}}}

/* k2445 in k2432 in k2429 in foreign.c-bytevectors#c-bytevector-sint-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2447(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(29,c,1)))){
C_save_and_reclaim((void *)f_2447,c,av);}
a=C_alloc(29);
t2=((C_word*)t0)[2];{
C_word *av2=av;
av2[0]=t2;
av2[1]=C_s_a_i_minus(&a,2,((C_word*)t0)[3],t1);
((C_proc)(void*)(*((C_word*)t2+1)))(2,av2);}}

/* k2449 in foreign.c-bytevectors#c-bytevector-sint-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_fcall f_2451(C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,0,3)))){
C_save_and_reclaim_args((void *)trf_2451,2,t0,t1);}
C_trace(C_text("foreign/c-bytevectors.sld:653: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word av2[4];
av2[0]=*((C_word*)lf[6]+1);
av2[1]=((C_word*)t0)[2];
av2[2]=((C_word*)t0)[3];
av2[3]=t1;
tp(4,av2);}}

/* foreign.c-bytevectors#c-bytevector-uint-set! in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2459(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4=av[4];
C_word t5=av[5];
C_word t6=av[6];
C_word t7;
C_word t8;
C_word t9;
C_word t10;
C_word t11;
C_word t12;
C_word t13;
C_word *a;
if(c!=7) C_bad_argc_2(c,7,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(37,c,4)))){
C_save_and_reclaim((void *)f_2459,c,av);}
a=C_alloc(37);
t7=C_eqp(t5,lf[3]);
if(C_truep(t7)){
t8=C_SCHEME_UNDEFINED;
t9=(*a=C_VECTOR_TYPE|1,a[1]=t8,tmp=(C_word)a,a+=2,tmp);
t10=C_set_block_item(t9,0,(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)f_2471,a[2]=t6,a[3]=t9,a[4]=t3,a[5]=t2,a[6]=((C_word)li59),tmp=(C_word)a,a+=7,tmp));
t11=((C_word*)t9)[1];
f_2471(t11,t1,C_fix(0),t4);}
else{
t8=C_eqp(t5,lf[84]);
if(C_truep(t8)){
t9=C_s_a_i_minus(&a,2,t6,C_fix(1));
t10=C_SCHEME_UNDEFINED;
t11=(*a=C_VECTOR_TYPE|1,a[1]=t10,tmp=(C_word)a,a+=2,tmp);
t12=C_set_block_item(t11,0,(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_2518,a[2]=t11,a[3]=t3,a[4]=t2,a[5]=((C_word)li60),tmp=(C_word)a,a+=6,tmp));
t13=((C_word*)t11)[1];
f_2518(t13,t1,t9,t4);}
else{
t9=(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)f_2557,a[2]=t1,a[3]=t2,a[4]=t3,a[5]=t4,a[6]=t6,tmp=(C_word)a,a+=7,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:679: native-endianness"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[2]);
C_word *av2=av;
av2[0]=*((C_word*)lf[2]+1);
av2[1]=t9;
tp(2,av2);}}}}

/* doloop586 in foreign.c-bytevectors#c-bytevector-uint-set! in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_fcall f_2471(C_word t0,C_word t1,C_word t2,C_word t3){
C_word tmp;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(40,0,4)))){
C_save_and_reclaim_args((void *)trf_2471,4,t0,t1,t2,t3);}
a=C_alloc(40);
if(C_truep(C_i_greater_or_equalp(t2,((C_word*)t0)[2]))){
t4=t1;{
C_word av2[2];
av2[0]=t4;
av2[1]=C_SCHEME_UNDEFINED;
((C_proc)(void*)(*((C_word*)t4+1)))(2,av2);}}
else{
t4=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_2484,a[2]=t2,a[3]=t3,a[4]=((C_word*)t0)[3],a[5]=t1,tmp=(C_word)a,a+=6,tmp);
t5=C_s_a_i_plus(&a,2,((C_word*)t0)[4],t2);
t6=C_s_a_i_remainder(&a,2,t3,C_fix(256));
C_trace(C_text("foreign/c-bytevectors.sld:671: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word av2[5];
av2[0]=*((C_word*)lf[5]+1);
av2[1]=t4;
av2[2]=((C_word*)t0)[5];
av2[3]=t5;
av2[4]=t6;
tp(5,av2);}}}

/* k2482 in doloop586 in foreign.c-bytevectors#c-bytevector-uint-set! in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2484(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(34,c,3)))){
C_save_and_reclaim((void *)f_2484,c,av);}
a=C_alloc(34);
t2=C_s_a_i_plus(&a,2,((C_word*)t0)[2],C_fix(1));
t3=C_s_a_i_quotient(&a,2,((C_word*)t0)[3],C_fix(256));
t4=((C_word*)((C_word*)t0)[4])[1];
f_2471(t4,((C_word*)t0)[5],t2,t3);}

/* doloop595 in foreign.c-bytevectors#c-bytevector-uint-set! in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_fcall f_2518(C_word t0,C_word t1,C_word t2,C_word t3){
C_word tmp;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(40,0,4)))){
C_save_and_reclaim_args((void *)trf_2518,4,t0,t1,t2,t3);}
a=C_alloc(40);
if(C_truep(C_i_lessp(t2,C_fix(0)))){
t4=t1;{
C_word av2[2];
av2[0]=t4;
av2[1]=C_SCHEME_UNDEFINED;
((C_proc)(void*)(*((C_word*)t4+1)))(2,av2);}}
else{
t4=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_2531,a[2]=t2,a[3]=t3,a[4]=((C_word*)t0)[2],a[5]=t1,tmp=(C_word)a,a+=6,tmp);
t5=C_s_a_i_plus(&a,2,((C_word*)t0)[3],t2);
t6=C_s_a_i_remainder(&a,2,t3,C_fix(256));
C_trace(C_text("foreign/c-bytevectors.sld:677: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word av2[5];
av2[0]=*((C_word*)lf[5]+1);
av2[1]=t4;
av2[2]=((C_word*)t0)[4];
av2[3]=t5;
av2[4]=t6;
tp(5,av2);}}}

/* k2529 in doloop595 in foreign.c-bytevectors#c-bytevector-uint-set! in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2531(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(34,c,3)))){
C_save_and_reclaim((void *)f_2531,c,av);}
a=C_alloc(34);
t2=C_s_a_i_minus(&a,2,((C_word*)t0)[2],C_fix(1));
t3=C_s_a_i_quotient(&a,2,((C_word*)t0)[3],C_fix(256));
t4=((C_word*)((C_word*)t0)[4])[1];
f_2518(t4,((C_word*)t0)[5],t2,t3);}

/* k2555 in foreign.c-bytevectors#c-bytevector-uint-set! in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2557(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,6)))){
C_save_and_reclaim((void *)f_2557,c,av);}
C_trace(C_text("foreign/c-bytevectors.sld:679: c-bytevector-uint-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[18]);
C_word *av2;
if(c >= 7) {
  av2=av;
} else {
  av2=C_alloc(7);
}
av2[0]=*((C_word*)lf[18]+1);
av2[1]=((C_word*)t0)[2];
av2[2]=((C_word*)t0)[3];
av2[3]=((C_word*)t0)[4];
av2[4]=((C_word*)t0)[5];
av2[5]=t1;
av2[6]=((C_word*)t0)[6];
tp(7,av2);}}

/* foreign.c-bytevectors#c-bytevector-sint-set! in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2559(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4=av[4];
C_word t5=av[5];
C_word t6=av[6];
C_word t7;
C_word t8;
C_word t9;
C_word *a;
if(c!=7) C_bad_argc_2(c,7,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(11,c,3)))){
C_save_and_reclaim((void *)f_2559,c,av);}
a=C_alloc(11);
t7=(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)f_2563,a[2]=t1,a[3]=t2,a[4]=t3,a[5]=t5,a[6]=t6,tmp=(C_word)a,a+=7,tmp);
if(C_truep(C_i_lessp(t4,C_fix(0)))){
t8=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_2576,a[2]=t7,a[3]=t4,tmp=(C_word)a,a+=4,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:683: scheme#expt"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[67]+1));
C_word *av2=av;
av2[0]=*((C_word*)lf[67]+1);
av2[1]=t8;
av2[2]=C_fix(256);
av2[3]=t6;
tp(4,av2);}}
else{
t8=t7;
f_2563(t8,t4);}}

/* k2561 in foreign.c-bytevectors#c-bytevector-sint-set! in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_fcall f_2563(C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,0,6)))){
C_save_and_reclaim_args((void *)trf_2563,2,t0,t1);}
C_trace(C_text("foreign/c-bytevectors.sld:685: c-bytevector-uint-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[18]);
C_word av2[7];
av2[0]=*((C_word*)lf[18]+1);
av2[1]=((C_word*)t0)[2];
av2[2]=((C_word*)t0)[3];
av2[3]=((C_word*)t0)[4];
av2[4]=t1;
av2[5]=((C_word*)t0)[5];
av2[6]=((C_word*)t0)[6];
tp(7,av2);}}

/* k2574 in foreign.c-bytevectors#c-bytevector-sint-set! in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2576(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(29,c,1)))){
C_save_and_reclaim((void *)f_2576,c,av);}
a=C_alloc(29);
t2=((C_word*)t0)[2];
f_2563(t2,C_s_a_i_plus(&a,2,((C_word*)t0)[3],t1));}

/* k2578 in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2580(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,2)))){
C_save_and_reclaim((void *)f_2580,c,av);}
a=C_alloc(3);
t2=C_mutate((C_word*)lf[85]+1 /* (set! foreign.c-bytevectors#c-bytevector-u16-ref ...) */,t1);
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2584,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:694: make-sint-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[15]);
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=*((C_word*)lf[15]+1);
av2[1]=t3;
av2[2]=C_fix(2);
tp(3,av2);}}

/* k2582 in k2578 in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2584(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,2)))){
C_save_and_reclaim((void *)f_2584,c,av);}
a=C_alloc(3);
t2=C_mutate((C_word*)lf[86]+1 /* (set! foreign.c-bytevectors#c-bytevector-s16-ref ...) */,t1);
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2588,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:695: make-uint-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[17]);
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=*((C_word*)lf[17]+1);
av2[1]=t3;
av2[2]=C_fix(2);
tp(3,av2);}}

/* k2586 in k2582 in k2578 in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2588(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,2)))){
C_save_and_reclaim((void *)f_2588,c,av);}
a=C_alloc(3);
t2=C_mutate((C_word*)lf[87]+1 /* (set! foreign.c-bytevectors#c-bytevector-u16-set! ...) */,t1);
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2592,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:696: make-sint-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[19]);
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=*((C_word*)lf[19]+1);
av2[1]=t3;
av2[2]=C_fix(2);
tp(3,av2);}}

/* k2590 in k2586 in k2582 in k2578 in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2592(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,3)))){
C_save_and_reclaim((void *)f_2592,c,av);}
a=C_alloc(3);
t2=C_mutate((C_word*)lf[88]+1 /* (set! foreign.c-bytevectors#c-bytevector-s16-set! ...) */,t1);
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2596,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:697: make-ref/native"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[21]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[21]+1);
av2[1]=t3;
av2[2]=C_fix(2);
av2[3]=C_fast_retrieve(lf[85]);
tp(4,av2);}}

/* k2594 in k2590 in k2586 in k2582 in k2578 in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2596(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,3)))){
C_save_and_reclaim((void *)f_2596,c,av);}
a=C_alloc(3);
t2=C_mutate((C_word*)lf[89]+1 /* (set! foreign.c-bytevectors#c-bytevector-u16-native-ref ...) */,t1);
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2600,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:698: make-ref/native"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[21]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[21]+1);
av2[1]=t3;
av2[2]=C_fix(2);
av2[3]=C_fast_retrieve(lf[86]);
tp(4,av2);}}

/* k2598 in k2594 in k2590 in k2586 in k2582 in k2578 in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2600(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,3)))){
C_save_and_reclaim((void *)f_2600,c,av);}
a=C_alloc(3);
t2=C_mutate((C_word*)lf[90]+1 /* (set! foreign.c-bytevectors#c-bytevector-s16-native-ref ...) */,t1);
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2604,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:699: make-set!/native"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[23]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[23]+1);
av2[1]=t3;
av2[2]=C_fix(2);
av2[3]=C_fast_retrieve(lf[87]);
tp(4,av2);}}

/* k2602 in k2598 in k2594 in k2590 in k2586 in k2582 in k2578 in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2604(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,3)))){
C_save_and_reclaim((void *)f_2604,c,av);}
a=C_alloc(3);
t2=C_mutate((C_word*)lf[91]+1 /* (set! foreign.c-bytevectors#c-bytevector-u16-native-set! ...) */,t1);
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2608,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:700: make-set!/native"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[23]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[23]+1);
av2[1]=t3;
av2[2]=C_fix(2);
av2[3]=C_fast_retrieve(lf[88]);
tp(4,av2);}}

/* k2606 in k2602 in k2598 in k2594 in k2590 in k2586 in k2582 in k2578 in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2608(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,2)))){
C_save_and_reclaim((void *)f_2608,c,av);}
a=C_alloc(3);
t2=C_mutate((C_word*)lf[92]+1 /* (set! foreign.c-bytevectors#c-bytevector-s16-native-set! ...) */,t1);
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2612,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:702: make-uint-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[13]);
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=*((C_word*)lf[13]+1);
av2[1]=t3;
av2[2]=C_fix(4);
tp(3,av2);}}

/* k2610 in k2606 in k2602 in k2598 in k2594 in k2590 in k2586 in k2582 in k2578 in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2612(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,2)))){
C_save_and_reclaim((void *)f_2612,c,av);}
a=C_alloc(3);
t2=C_mutate((C_word*)lf[93]+1 /* (set! foreign.c-bytevectors#c-bytevector-u32-ref ...) */,t1);
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2616,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:703: make-sint-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[15]);
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=*((C_word*)lf[15]+1);
av2[1]=t3;
av2[2]=C_fix(4);
tp(3,av2);}}

/* k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in k2590 in k2586 in k2582 in k2578 in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2616(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,2)))){
C_save_and_reclaim((void *)f_2616,c,av);}
a=C_alloc(3);
t2=C_mutate((C_word*)lf[94]+1 /* (set! foreign.c-bytevectors#c-bytevector-s32-ref ...) */,t1);
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2620,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:704: make-uint-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[17]);
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=*((C_word*)lf[17]+1);
av2[1]=t3;
av2[2]=C_fix(4);
tp(3,av2);}}

/* k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in k2590 in k2586 in k2582 in k2578 in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_ccall f_2620(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,2)))){
C_save_and_reclaim((void *)f_2620,c,av);}
a=C_alloc(3);
t2=C_mutate((C_word*)lf[95]+1 /* (set! foreign.c-bytevectors#c-bytevector-u32-set! ...) */,t1);
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2624,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:705: make-sint-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[19]);
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=*((C_word*)lf[19]+1);
av2[1]=t3;
av2[2]=C_fix(4);
tp(3,av2);}}

/* k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in k2590 in k2586 in k2582 in k2578 in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 in ... */
static void C_ccall f_2624(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,3)))){
C_save_and_reclaim((void *)f_2624,c,av);}
a=C_alloc(3);
t2=C_mutate((C_word*)lf[96]+1 /* (set! foreign.c-bytevectors#c-bytevector-s32-set! ...) */,t1);
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2628,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:706: make-ref/native"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[21]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[21]+1);
av2[1]=t3;
av2[2]=C_fix(4);
av2[3]=C_fast_retrieve(lf[93]);
tp(4,av2);}}

/* k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in k2590 in k2586 in k2582 in k2578 in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in ... */
static void C_ccall f_2628(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,3)))){
C_save_and_reclaim((void *)f_2628,c,av);}
a=C_alloc(3);
t2=C_mutate((C_word*)lf[97]+1 /* (set! foreign.c-bytevectors#c-bytevector-u32-native-ref ...) */,t1);
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2632,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:707: make-ref/native"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[21]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[21]+1);
av2[1]=t3;
av2[2]=C_fix(4);
av2[3]=C_fast_retrieve(lf[94]);
tp(4,av2);}}

/* k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in k2590 in k2586 in k2582 in k2578 in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in ... */
static void C_ccall f_2632(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,3)))){
C_save_and_reclaim((void *)f_2632,c,av);}
a=C_alloc(3);
t2=C_mutate((C_word*)lf[98]+1 /* (set! foreign.c-bytevectors#c-bytevector-s32-native-ref ...) */,t1);
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2636,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:708: make-set!/native"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[23]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[23]+1);
av2[1]=t3;
av2[2]=C_fix(4);
av2[3]=C_fast_retrieve(lf[95]);
tp(4,av2);}}

/* k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in k2590 in k2586 in k2582 in k2578 in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in ... */
static void C_ccall f_2636(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,3)))){
C_save_and_reclaim((void *)f_2636,c,av);}
a=C_alloc(3);
t2=C_mutate((C_word*)lf[99]+1 /* (set! foreign.c-bytevectors#c-bytevector-u32-native-set! ...) */,t1);
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2640,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:709: make-set!/native"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[23]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[23]+1);
av2[1]=t3;
av2[2]=C_fix(4);
av2[3]=C_fast_retrieve(lf[96]);
tp(4,av2);}}

/* k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in k2590 in k2586 in k2582 in k2578 in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in ... */
static void C_ccall f_2640(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,2)))){
C_save_and_reclaim((void *)f_2640,c,av);}
a=C_alloc(3);
t2=C_mutate((C_word*)lf[100]+1 /* (set! foreign.c-bytevectors#c-bytevector-s32-native-set! ...) */,t1);
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2644,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:711: make-uint-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[13]);
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=*((C_word*)lf[13]+1);
av2[1]=t3;
av2[2]=C_fix(8);
tp(3,av2);}}

/* k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in k2590 in k2586 in k2582 in k2578 in k1060 in k1057 in k1054 in k1051 in k1048 in ... */
static void C_ccall f_2644(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,2)))){
C_save_and_reclaim((void *)f_2644,c,av);}
a=C_alloc(3);
t2=C_mutate((C_word*)lf[101]+1 /* (set! foreign.c-bytevectors#c-bytevector-u64-ref ...) */,t1);
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2648,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:712: make-sint-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[15]);
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=*((C_word*)lf[15]+1);
av2[1]=t3;
av2[2]=C_fix(8);
tp(3,av2);}}

/* k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in k2590 in k2586 in k2582 in k2578 in k1060 in k1057 in k1054 in k1051 in ... */
static void C_ccall f_2648(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,2)))){
C_save_and_reclaim((void *)f_2648,c,av);}
a=C_alloc(3);
t2=C_mutate((C_word*)lf[102]+1 /* (set! foreign.c-bytevectors#c-bytevector-s64-ref ...) */,t1);
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2652,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:713: make-uint-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[17]);
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=*((C_word*)lf[17]+1);
av2[1]=t3;
av2[2]=C_fix(8);
tp(3,av2);}}

/* k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in k2590 in k2586 in k2582 in k2578 in k1060 in k1057 in k1054 in ... */
static void C_ccall f_2652(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,2)))){
C_save_and_reclaim((void *)f_2652,c,av);}
a=C_alloc(3);
t2=C_mutate((C_word*)lf[103]+1 /* (set! foreign.c-bytevectors#c-bytevector-u64-set! ...) */,t1);
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2656,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:714: make-sint-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[19]);
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=*((C_word*)lf[19]+1);
av2[1]=t3;
av2[2]=C_fix(8);
tp(3,av2);}}

/* k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in k2590 in k2586 in k2582 in k2578 in k1060 in k1057 in ... */
static void C_ccall f_2656(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,3)))){
C_save_and_reclaim((void *)f_2656,c,av);}
a=C_alloc(3);
t2=C_mutate((C_word*)lf[104]+1 /* (set! foreign.c-bytevectors#c-bytevector-s64-set! ...) */,t1);
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2660,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:715: make-ref/native"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[21]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[21]+1);
av2[1]=t3;
av2[2]=C_fix(8);
av2[3]=C_fast_retrieve(lf[101]);
tp(4,av2);}}

/* k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in k2590 in k2586 in k2582 in k2578 in k1060 in ... */
static void C_ccall f_2660(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,3)))){
C_save_and_reclaim((void *)f_2660,c,av);}
a=C_alloc(3);
t2=C_mutate((C_word*)lf[105]+1 /* (set! foreign.c-bytevectors#c-bytevector-u64-native-ref ...) */,t1);
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2664,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:716: make-ref/native"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[21]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[21]+1);
av2[1]=t3;
av2[2]=C_fix(8);
av2[3]=C_fast_retrieve(lf[102]);
tp(4,av2);}}

/* k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in k2590 in k2586 in k2582 in k2578 in ... */
static void C_ccall f_2664(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,3)))){
C_save_and_reclaim((void *)f_2664,c,av);}
a=C_alloc(3);
t2=C_mutate((C_word*)lf[106]+1 /* (set! foreign.c-bytevectors#c-bytevector-s64-native-ref ...) */,t1);
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2668,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:717: make-set!/native"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[23]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[23]+1);
av2[1]=t3;
av2[2]=C_fix(8);
av2[3]=C_fast_retrieve(lf[103]);
tp(4,av2);}}

/* k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in k2590 in k2586 in k2582 in ... */
static void C_ccall f_2668(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(3,c,3)))){
C_save_and_reclaim((void *)f_2668,c,av);}
a=C_alloc(3);
t2=C_mutate((C_word*)lf[107]+1 /* (set! foreign.c-bytevectors#c-bytevector-u64-native-set! ...) */,t1);
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2672,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:718: make-set!/native"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[23]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[23]+1);
av2[1]=t3;
av2[2]=C_fix(8);
av2[3]=C_fast_retrieve(lf[104]);
tp(4,av2);}}

/* k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in k2590 in k2586 in ... */
static void C_ccall f_2672(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word t9;
C_word t10;
C_word t11;
C_word t12;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(27,c,6)))){
C_save_and_reclaim((void *)f_2672,c,av);}
a=C_alloc(27);
t2=C_mutate((C_word*)lf[108]+1 /* (set! foreign.c-bytevectors#c-bytevector-s64-native-set! ...) */,t1);
t3=C_mutate((C_word*)lf[109]+1 /* (set! foreign.c-bytevectors#c-bytevector-ieee-single-native-ref ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2674,a[2]=((C_word)li63),tmp=(C_word)a,a+=3,tmp));
t4=C_mutate((C_word*)lf[111]+1 /* (set! foreign.c-bytevectors#c-bytevector-ieee-double-native-ref ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2727,a[2]=((C_word)li64),tmp=(C_word)a,a+=3,tmp));
t5=C_mutate((C_word*)lf[113]+1 /* (set! foreign.c-bytevectors#c-bytevector-ieee-single-native-set! ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2780,a[2]=((C_word)li65),tmp=(C_word)a,a+=3,tmp));
t6=C_mutate((C_word*)lf[116]+1 /* (set! foreign.c-bytevectors#c-bytevector-ieee-double-native-set! ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2833,a[2]=((C_word)li66),tmp=(C_word)a,a+=3,tmp));
t7=C_mutate((C_word*)lf[119]+1 /* (set! foreign.c-bytevectors#c-bytevector-ieee-single-ref ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2900,a[2]=((C_word)li67),tmp=(C_word)a,a+=3,tmp));
t8=C_mutate((C_word*)lf[121]+1 /* (set! foreign.c-bytevectors#c-bytevector-ieee-double-ref ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2924,a[2]=((C_word)li68),tmp=(C_word)a,a+=3,tmp));
t9=C_mutate((C_word*)lf[114]+1 /* (set! foreign.c-bytevectors#c-bytevector-ieee-single-set! ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2948,a[2]=((C_word)li72),tmp=(C_word)a,a+=3,tmp));
t10=C_mutate((C_word*)lf[118]+1 /* (set! foreign.c-bytevectors#c-bytevector-ieee-double-set! ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_3128,a[2]=((C_word)li77),tmp=(C_word)a,a+=3,tmp));
t11=C_mutate((C_word*)lf[123]+1 /* (set! foreign.c-bytevectors#string->utf16 ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_3367,a[2]=((C_word)li83),tmp=(C_word)a,a+=3,tmp));
t12=((C_word*)t0)[2];{
C_word *av2=av;
av2[0]=t12;
av2[1]=C_SCHEME_UNDEFINED;
((C_proc)(void*)(*((C_word*)t12+1)))(2,av2);}}

/* foreign.c-bytevectors#c-bytevector-ieee-single-native-ref in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in k2590 in ... */
static void C_ccall f_2674(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4;
C_word t5;
C_word *a;
if(c!=4) C_bad_argc_2(c,4,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(5,c,2)))){
C_save_and_reclaim((void *)f_2674,c,av);}
a=C_alloc(5);
t4=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_2725,a[2]=t1,a[3]=t2,a[4]=t3,tmp=(C_word)a,a+=5,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:724: native-endianness"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[2]);
C_word *av2=av;
av2[0]=*((C_word*)lf[2]+1);
av2[1]=t4;
tp(2,av2);}}

/* k2682 in k2723 in foreign.c-bytevectors#c-bytevector-ieee-single-native-ref in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in ... */
static void C_ccall f_2684(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,3)))){
C_save_and_reclaim((void *)f_2684,c,av);}
C_trace(C_text("foreign/c-bytevectors.sld:727: c-bytevector-ieee-single-little-endian-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[60]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[60]+1);
av2[1]=((C_word*)t0)[2];
av2[2]=((C_word*)t0)[3];
av2[3]=((C_word*)t0)[4];
tp(4,av2);}}

/* k2702 in k2723 in foreign.c-bytevectors#c-bytevector-ieee-single-native-ref in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in ... */
static void C_ccall f_2704(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,3)))){
C_save_and_reclaim((void *)f_2704,c,av);}
C_trace(C_text("foreign/c-bytevectors.sld:731: c-bytevector-ieee-single-big-endian-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[58]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[58]+1);
av2[1]=((C_word*)t0)[2];
av2[2]=((C_word*)t0)[3];
av2[3]=((C_word*)t0)[4];
tp(4,av2);}}

/* k2723 in foreign.c-bytevectors#c-bytevector-ieee-single-native-ref in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in ... */
static void C_ccall f_2725(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(10,c,4)))){
C_save_and_reclaim((void *)f_2725,c,av);}
a=C_alloc(10);
t2=C_eqp(t1,lf[3]);
if(C_truep(t2)){
t3=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_2684,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],tmp=(C_word)a,a+=5,tmp);
t4=C_s_a_i_remainder(&a,2,((C_word*)t0)[4],C_fix(4));
t5=C_i_nequalp(C_fix(0),t4);
if(C_truep(C_i_not(t5))){
C_trace(C_text("foreign/c-bytevectors.sld:726: complain"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[8]);
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=*((C_word*)lf[8]+1);
av2[1]=t3;
av2[2]=lf[110];
av2[3]=((C_word*)t0)[3];
av2[4]=((C_word*)t0)[4];
tp(5,av2);}}
else{
t6=t3;{
C_word *av2=av;
av2[0]=t6;
av2[1]=C_SCHEME_UNDEFINED;
f_2684(2,av2);}}}
else{
t3=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_2704,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],tmp=(C_word)a,a+=5,tmp);
t4=C_s_a_i_remainder(&a,2,((C_word*)t0)[4],C_fix(4));
t5=C_i_nequalp(C_fix(0),t4);
if(C_truep(C_i_not(t5))){
C_trace(C_text("foreign/c-bytevectors.sld:730: complain"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[8]);
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=*((C_word*)lf[8]+1);
av2[1]=t3;
av2[2]=lf[110];
av2[3]=((C_word*)t0)[3];
av2[4]=((C_word*)t0)[4];
tp(5,av2);}}
else{
t6=t3;{
C_word *av2=av;
av2[0]=t6;
av2[1]=C_SCHEME_UNDEFINED;
f_2704(2,av2);}}}}

/* foreign.c-bytevectors#c-bytevector-ieee-double-native-ref in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in k2590 in ... */
static void C_ccall f_2727(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4;
C_word t5;
C_word *a;
if(c!=4) C_bad_argc_2(c,4,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(5,c,2)))){
C_save_and_reclaim((void *)f_2727,c,av);}
a=C_alloc(5);
t4=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_2778,a[2]=t1,a[3]=t2,a[4]=t3,tmp=(C_word)a,a+=5,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:734: native-endianness"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[2]);
C_word *av2=av;
av2[0]=*((C_word*)lf[2]+1);
av2[1]=t4;
tp(2,av2);}}

/* k2735 in k2776 in foreign.c-bytevectors#c-bytevector-ieee-double-native-ref in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in ... */
static void C_ccall f_2737(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,3)))){
C_save_and_reclaim((void *)f_2737,c,av);}
C_trace(C_text("foreign/c-bytevectors.sld:737: c-bytevector-ieee-double-little-endian-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[57]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[57]+1);
av2[1]=((C_word*)t0)[2];
av2[2]=((C_word*)t0)[3];
av2[3]=((C_word*)t0)[4];
tp(4,av2);}}

/* k2755 in k2776 in foreign.c-bytevectors#c-bytevector-ieee-double-native-ref in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in ... */
static void C_ccall f_2757(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,3)))){
C_save_and_reclaim((void *)f_2757,c,av);}
C_trace(C_text("foreign/c-bytevectors.sld:741: c-bytevector-ieee-double-big-endian-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[55]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[55]+1);
av2[1]=((C_word*)t0)[2];
av2[2]=((C_word*)t0)[3];
av2[3]=((C_word*)t0)[4];
tp(4,av2);}}

/* k2776 in foreign.c-bytevectors#c-bytevector-ieee-double-native-ref in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in ... */
static void C_ccall f_2778(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(10,c,4)))){
C_save_and_reclaim((void *)f_2778,c,av);}
a=C_alloc(10);
t2=C_eqp(t1,lf[3]);
if(C_truep(t2)){
t3=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_2737,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],tmp=(C_word)a,a+=5,tmp);
t4=C_s_a_i_remainder(&a,2,((C_word*)t0)[4],C_fix(8));
t5=C_i_nequalp(C_fix(0),t4);
if(C_truep(C_i_not(t5))){
C_trace(C_text("foreign/c-bytevectors.sld:736: complain"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[8]);
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=*((C_word*)lf[8]+1);
av2[1]=t3;
av2[2]=lf[112];
av2[3]=((C_word*)t0)[3];
av2[4]=((C_word*)t0)[4];
tp(5,av2);}}
else{
t6=t3;{
C_word *av2=av;
av2[0]=t6;
av2[1]=C_SCHEME_UNDEFINED;
f_2737(2,av2);}}}
else{
t3=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_2757,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],tmp=(C_word)a,a+=5,tmp);
t4=C_s_a_i_remainder(&a,2,((C_word*)t0)[4],C_fix(8));
t5=C_i_nequalp(C_fix(0),t4);
if(C_truep(C_i_not(t5))){
C_trace(C_text("foreign/c-bytevectors.sld:740: complain"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[8]);
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=*((C_word*)lf[8]+1);
av2[1]=t3;
av2[2]=lf[112];
av2[3]=((C_word*)t0)[3];
av2[4]=((C_word*)t0)[4];
tp(5,av2);}}
else{
t6=t3;{
C_word *av2=av;
av2[0]=t6;
av2[1]=C_SCHEME_UNDEFINED;
f_2757(2,av2);}}}}

/* foreign.c-bytevectors#c-bytevector-ieee-single-native-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in k2590 in ... */
static void C_ccall f_2780(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4=av[4];
C_word t5;
C_word t6;
C_word *a;
if(c!=5) C_bad_argc_2(c,5,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(6,c,2)))){
C_save_and_reclaim((void *)f_2780,c,av);}
a=C_alloc(6);
t5=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_2831,a[2]=t1,a[3]=t2,a[4]=t3,a[5]=t4,tmp=(C_word)a,a+=6,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:744: native-endianness"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[2]);
C_word *av2=av;
av2[0]=*((C_word*)lf[2]+1);
av2[1]=t5;
tp(2,av2);}}

/* k2788 in k2829 in foreign.c-bytevectors#c-bytevector-ieee-single-native-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in ... */
static void C_ccall f_2790(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,5)))){
C_save_and_reclaim((void *)f_2790,c,av);}
C_trace(C_text("foreign/c-bytevectors.sld:747: c-bytevector-ieee-single-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[114]);
C_word *av2;
if(c >= 6) {
  av2=av;
} else {
  av2=C_alloc(6);
}
av2[0]=*((C_word*)lf[114]+1);
av2[1]=((C_word*)t0)[2];
av2[2]=((C_word*)t0)[3];
av2[3]=((C_word*)t0)[4];
av2[4]=((C_word*)t0)[5];
av2[5]=lf[3];
tp(6,av2);}}

/* k2808 in k2829 in foreign.c-bytevectors#c-bytevector-ieee-single-native-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in ... */
static void C_ccall f_2810(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,5)))){
C_save_and_reclaim((void *)f_2810,c,av);}
C_trace(C_text("foreign/c-bytevectors.sld:751: c-bytevector-ieee-single-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[114]);
C_word *av2;
if(c >= 6) {
  av2=av;
} else {
  av2=C_alloc(6);
}
av2[0]=*((C_word*)lf[114]+1);
av2[1]=((C_word*)t0)[2];
av2[2]=((C_word*)t0)[3];
av2[3]=((C_word*)t0)[4];
av2[4]=((C_word*)t0)[5];
av2[5]=lf[84];
tp(6,av2);}}

/* k2829 in foreign.c-bytevectors#c-bytevector-ieee-single-native-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in ... */
static void C_ccall f_2831(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(11,c,5)))){
C_save_and_reclaim((void *)f_2831,c,av);}
a=C_alloc(11);
t2=C_eqp(t1,lf[3]);
if(C_truep(t2)){
t3=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_2790,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[5],tmp=(C_word)a,a+=6,tmp);
t4=C_s_a_i_remainder(&a,2,((C_word*)t0)[4],C_fix(4));
t5=C_i_nequalp(C_fix(0),t4);
if(C_truep(C_i_not(t5))){
C_trace(C_text("foreign/c-bytevectors.sld:746: complain"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[8]);
C_word *av2;
if(c >= 6) {
  av2=av;
} else {
  av2=C_alloc(6);
}
av2[0]=*((C_word*)lf[8]+1);
av2[1]=t3;
av2[2]=lf[115];
av2[3]=((C_word*)t0)[3];
av2[4]=((C_word*)t0)[4];
av2[5]=((C_word*)t0)[5];
tp(6,av2);}}
else{
t6=t3;{
C_word *av2=av;
av2[0]=t6;
av2[1]=C_SCHEME_UNDEFINED;
f_2790(2,av2);}}}
else{
t3=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_2810,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[5],tmp=(C_word)a,a+=6,tmp);
t4=C_s_a_i_remainder(&a,2,((C_word*)t0)[4],C_fix(4));
t5=C_i_nequalp(C_fix(0),t4);
if(C_truep(C_i_not(t5))){
C_trace(C_text("foreign/c-bytevectors.sld:750: complain"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[8]);
C_word *av2;
if(c >= 6) {
  av2=av;
} else {
  av2=C_alloc(6);
}
av2[0]=*((C_word*)lf[8]+1);
av2[1]=t3;
av2[2]=lf[115];
av2[3]=((C_word*)t0)[3];
av2[4]=((C_word*)t0)[4];
av2[5]=((C_word*)t0)[5];
tp(6,av2);}}
else{
t6=t3;{
C_word *av2=av;
av2[0]=t6;
av2[1]=C_SCHEME_UNDEFINED;
f_2810(2,av2);}}}}

/* foreign.c-bytevectors#c-bytevector-ieee-double-native-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in k2590 in ... */
static void C_ccall f_2833(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4=av[4];
C_word t5;
C_word t6;
C_word *a;
if(c!=5) C_bad_argc_2(c,5,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(6,c,2)))){
C_save_and_reclaim((void *)f_2833,c,av);}
a=C_alloc(6);
t5=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_2898,a[2]=t3,a[3]=t1,a[4]=t2,a[5]=t4,tmp=(C_word)a,a+=6,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:754: native-endianness"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[2]);
C_word *av2=av;
av2[0]=*((C_word*)lf[2]+1);
av2[1]=t5;
tp(2,av2);}}

/* k2875 in k2896 in foreign.c-bytevectors#c-bytevector-ieee-double-native-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in ... */
static void C_ccall f_2877(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,5)))){
C_save_and_reclaim((void *)f_2877,c,av);}
C_trace(C_text("foreign/c-bytevectors.sld:762: c-bytevector-ieee-double-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[118]);
C_word *av2;
if(c >= 6) {
  av2=av;
} else {
  av2=C_alloc(6);
}
av2[0]=*((C_word*)lf[118]+1);
av2[1]=((C_word*)t0)[2];
av2[2]=((C_word*)t0)[3];
av2[3]=((C_word*)t0)[4];
av2[4]=((C_word*)t0)[5];
av2[5]=lf[84];
tp(6,av2);}}

/* k2896 in foreign.c-bytevectors#c-bytevector-ieee-double-native-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in ... */
static void C_ccall f_2898(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(11,c,5)))){
C_save_and_reclaim((void *)f_2898,c,av);}
a=C_alloc(11);
t2=C_eqp(t1,lf[3]);
if(C_truep(t2)){
t3=C_s_a_i_remainder(&a,2,((C_word*)t0)[2],C_fix(4));
t4=C_i_nequalp(C_fix(0),t3);
if(C_truep(C_i_not(t4))){
t5=C_s_a_i_remainder(&a,2,((C_word*)t0)[2],C_fix(8));
t6=C_i_nequalp(C_fix(0),t5);
if(C_truep(C_i_not(t6))){
C_trace(C_text("foreign/c-bytevectors.sld:757: complain"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[8]);
C_word *av2;
if(c >= 6) {
  av2=av;
} else {
  av2=C_alloc(6);
}
av2[0]=*((C_word*)lf[8]+1);
av2[1]=((C_word*)t0)[3];
av2[2]=lf[117];
av2[3]=((C_word*)t0)[4];
av2[4]=((C_word*)t0)[2];
av2[5]=((C_word*)t0)[5];
tp(6,av2);}}
else{
t7=((C_word*)t0)[3];{
C_word *av2=av;
av2[0]=t7;
av2[1]=C_SCHEME_UNDEFINED;
((C_proc)(void*)(*((C_word*)t7+1)))(2,av2);}}}
else{
C_trace(C_text("foreign/c-bytevectors.sld:758: c-bytevector-ieee-double-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[118]);
C_word *av2;
if(c >= 6) {
  av2=av;
} else {
  av2=C_alloc(6);
}
av2[0]=*((C_word*)lf[118]+1);
av2[1]=((C_word*)t0)[3];
av2[2]=((C_word*)t0)[4];
av2[3]=((C_word*)t0)[2];
av2[4]=((C_word*)t0)[5];
av2[5]=lf[3];
tp(6,av2);}}}
else{
t3=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_2877,a[2]=((C_word*)t0)[3],a[3]=((C_word*)t0)[4],a[4]=((C_word*)t0)[2],a[5]=((C_word*)t0)[5],tmp=(C_word)a,a+=6,tmp);
t4=C_s_a_i_remainder(&a,2,((C_word*)t0)[2],C_fix(8));
t5=C_i_nequalp(C_fix(0),t4);
if(C_truep(C_i_not(t5))){
C_trace(C_text("foreign/c-bytevectors.sld:761: complain"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[8]);
C_word *av2;
if(c >= 6) {
  av2=av;
} else {
  av2=C_alloc(6);
}
av2[0]=*((C_word*)lf[8]+1);
av2[1]=t3;
av2[2]=lf[117];
av2[3]=((C_word*)t0)[4];
av2[4]=((C_word*)t0)[2];
av2[5]=((C_word*)t0)[5];
tp(6,av2);}}
else{
t6=t3;{
C_word *av2=av;
av2[0]=t6;
av2[1]=C_SCHEME_UNDEFINED;
f_2877(2,av2);}}}}

/* foreign.c-bytevectors#c-bytevector-ieee-single-ref in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in k2590 in ... */
static void C_ccall f_2900(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4=av[4];
C_word t5;
C_word t6;
C_word t7;
C_word *a;
if(c!=5) C_bad_argc_2(c,5,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,5)))){
C_save_and_reclaim((void *)f_2900,c,av);}
t5=C_eqp(t4,lf[84]);
if(C_truep(t5)){
C_trace(C_text("foreign/c-bytevectors.sld:785: c-bytevector-ieee-single-big-endian-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[58]);
C_word *av2=av;
av2[0]=*((C_word*)lf[58]+1);
av2[1]=t1;
av2[2]=t2;
av2[3]=t3;
tp(4,av2);}}
else{
t6=C_eqp(t4,lf[3]);
if(C_truep(t6)){
C_trace(C_text("foreign/c-bytevectors.sld:787: c-bytevector-ieee-single-little-endian-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[60]);
C_word *av2=av;
av2[0]=*((C_word*)lf[60]+1);
av2[1]=t1;
av2[2]=t2;
av2[3]=t3;
tp(4,av2);}}
else{
C_trace(C_text("foreign/c-bytevectors.sld:789: complain"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[8]);
C_word *av2;
if(c >= 6) {
  av2=av;
} else {
  av2=C_alloc(6);
}
av2[0]=*((C_word*)lf[8]+1);
av2[1]=t1;
av2[2]=lf[120];
av2[3]=t2;
av2[4]=t3;
av2[5]=t4;
tp(6,av2);}}}}

/* foreign.c-bytevectors#c-bytevector-ieee-double-ref in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in k2590 in ... */
static void C_ccall f_2924(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4=av[4];
C_word t5;
C_word t6;
C_word t7;
C_word *a;
if(c!=5) C_bad_argc_2(c,5,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,5)))){
C_save_and_reclaim((void *)f_2924,c,av);}
t5=C_eqp(t4,lf[84]);
if(C_truep(t5)){
C_trace(C_text("foreign/c-bytevectors.sld:794: c-bytevector-ieee-double-big-endian-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[55]);
C_word *av2=av;
av2[0]=*((C_word*)lf[55]+1);
av2[1]=t1;
av2[2]=t2;
av2[3]=t3;
tp(4,av2);}}
else{
t6=C_eqp(t4,lf[3]);
if(C_truep(t6)){
C_trace(C_text("foreign/c-bytevectors.sld:796: c-bytevector-ieee-double-little-endian-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[57]);
C_word *av2=av;
av2[0]=*((C_word*)lf[57]+1);
av2[1]=t1;
av2[2]=t2;
av2[3]=t3;
tp(4,av2);}}
else{
C_trace(C_text("foreign/c-bytevectors.sld:798: complain"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[8]);
C_word *av2;
if(c >= 6) {
  av2=av;
} else {
  av2=C_alloc(6);
}
av2[0]=*((C_word*)lf[8]+1);
av2[1]=t1;
av2[2]=lf[122];
av2[3]=t2;
av2[4]=t3;
av2[5]=t4;
tp(6,av2);}}}}

/* foreign.c-bytevectors#c-bytevector-ieee-single-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in k2590 in ... */
static void C_ccall f_2948(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4=av[4];
C_word t5=av[5];
C_word t6;
C_word t7;
C_word t8;
C_word *a;
if(c!=6) C_bad_argc_2(c,6,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(10,c,5)))){
C_save_and_reclaim((void *)f_2948,c,av);}
a=C_alloc(10);
t6=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_2954,a[2]=t4,a[3]=((C_word)li69),tmp=(C_word)a,a+=4,tmp);
t7=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_2960,a[2]=t5,a[3]=t3,a[4]=t2,a[5]=((C_word)li71),tmp=(C_word)a,a+=6,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:801: scheme#call-with-values"));{
C_word *av2=av;
av2[0]=0;
av2[1]=t1;
av2[2]=t6;
av2[3]=t7;
C_call_with_values(4,av2);}}

/* a2953 in foreign.c-bytevectors#c-bytevector-ieee-single-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in ... */
static void C_ccall f_2954(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
if(c!=2) C_bad_argc_2(c,2,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,4)))){
C_save_and_reclaim((void *)f_2954,c,av);}
C_trace(C_text("foreign/c-bytevectors.sld:803: c-bytevector:ieee-parts"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[43]);
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=*((C_word*)lf[43]+1);
av2[1]=t1;
av2[2]=((C_word*)t0)[2];
av2[3]=C_fast_retrieve(lf[27]);
av2[4]=C_fast_retrieve(lf[28]);
tp(5,av2);}}

/* a2959 in foreign.c-bytevectors#c-bytevector-ieee-single-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in ... */
static void C_ccall f_2960(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4=av[4];
C_word t5;
C_word t6;
C_word t7;
C_word *a;
if(c!=5) C_bad_argc_2(c,5,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(35,c,5)))){
C_save_and_reclaim((void *)f_2960,c,av);}
a=C_alloc(35);
t5=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_2963,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word)li70),tmp=(C_word)a,a+=6,tmp);
if(C_truep(C_i_nequalp(t3,C_fast_retrieve(lf[26])))){
C_trace(C_text("foreign/c-bytevectors.sld:835: store!"));
t6=t5;
f_2963(t6,t1,t2,t3,t4);}
else{
if(C_truep(C_i_lessp(t4,C_fast_retrieve(lf[28])))){
C_trace(C_text("foreign/c-bytevectors.sld:837: store!"));
t6=t5;
f_2963(t6,t1,t2,C_fix(0),t4);}
else{
t6=C_s_a_i_minus(&a,2,t4,C_fast_retrieve(lf[28]));
C_trace(C_text("foreign/c-bytevectors.sld:839: store!"));
t7=t5;
f_2963(t7,t1,t2,t3,t6);}}}

/* store! in a2959 in foreign.c-bytevectors#c-bytevector-ieee-single-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in ... */
static void C_fcall f_2963(C_word t0,C_word t1,C_word t2,C_word t3,C_word t4){
C_word tmp;
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word t9;
C_word t10;
C_word t11;
C_word t12;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(106,0,4)))){
C_save_and_reclaim_args((void *)trf_2963,5,t0,t1,t2,t3,t4);}
a=C_alloc(106);
t5=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_2967,a[2]=t1,tmp=(C_word)a,a+=3,tmp);
t6=C_eqp(lf[84],((C_word*)t0)[2]);
if(C_truep(t6)){
t7=(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)f_2976,a[2]=((C_word*)t0)[3],a[3]=t4,a[4]=t5,a[5]=((C_word*)t0)[4],a[6]=t3,tmp=(C_word)a,a+=7,tmp);
t8=C_s_a_i_times(&a,2,C_fix(128),t2);
t9=C_s_a_i_quotient(&a,2,t3,C_fix(2));
t10=C_s_a_i_plus(&a,2,t8,t9);
C_trace(C_text("foreign/c-bytevectors.sld:810: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word av2[5];
av2[0]=*((C_word*)lf[5]+1);
av2[1]=t7;
av2[2]=((C_word*)t0)[4];
av2[3]=((C_word*)t0)[3];
av2[4]=t10;
tp(5,av2);}}
else{
t7=(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)f_3040,a[2]=t4,a[3]=t5,a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[3],a[6]=t3,tmp=(C_word)a,a+=7,tmp);
t8=C_s_a_i_plus(&a,2,((C_word*)t0)[3],C_fix(3));
t9=C_s_a_i_times(&a,2,C_fix(128),t2);
t10=C_s_a_i_quotient(&a,2,t3,C_fix(2));
t11=C_s_a_i_plus(&a,2,t9,t10);
C_trace(C_text("foreign/c-bytevectors.sld:822: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word av2[5];
av2[0]=*((C_word*)lf[5]+1);
av2[1]=t7;
av2[2]=((C_word*)t0)[4];
av2[3]=t8;
av2[4]=t11;
tp(5,av2);}}}

/* k2965 in store! in a2959 in foreign.c-bytevectors#c-bytevector-ieee-single-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in ... */
static void C_ccall f_2967(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,1)))){
C_save_and_reclaim((void *)f_2967,c,av);}
t2=((C_word*)t0)[2];{
C_word *av2=av;
av2[0]=t2;
av2[1]=C_SCHEME_UNDEFINED;
((C_proc)(void*)(*((C_word*)t2+1)))(2,av2);}}

/* k2974 in store! in a2959 in foreign.c-bytevectors#c-bytevector-ieee-single-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in ... */
static void C_ccall f_2976(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(107,c,4)))){
C_save_and_reclaim((void *)f_2976,c,av);}
a=C_alloc(107);
t2=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_2979,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[5],tmp=(C_word)a,a+=6,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[2],C_fix(1));
t4=C_s_a_i_remainder(&a,2,((C_word*)t0)[6],C_fix(2));
t5=C_s_a_i_times(&a,2,C_fix(128),t4);
t6=C_s_a_i_quotient(&a,2,((C_word*)t0)[3],C_fix(65536));
t7=C_s_a_i_plus(&a,2,t5,t6);
C_trace(C_text("foreign/c-bytevectors.sld:813: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=*((C_word*)lf[5]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[5];
av2[3]=t3;
av2[4]=t7;
tp(5,av2);}}

/* k2977 in k2974 in store! in a2959 in foreign.c-bytevectors#c-bytevector-ieee-single-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in ... */
static void C_ccall f_2979(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(45,c,4)))){
C_save_and_reclaim((void *)f_2979,c,av);}
a=C_alloc(45);
t2=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_2982,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[5],tmp=(C_word)a,a+=6,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[2],C_fix(2));
t4=C_s_a_i_remainder(&a,2,((C_word*)t0)[3],C_fix(65536));
t5=C_s_a_i_quotient(&a,2,t4,C_fix(256));
C_trace(C_text("foreign/c-bytevectors.sld:816: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=*((C_word*)lf[5]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[5];
av2[3]=t3;
av2[4]=t5;
tp(5,av2);}}

/* k2980 in k2977 in k2974 in store! in a2959 in foreign.c-bytevectors#c-bytevector-ieee-single-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in ... */
static void C_ccall f_2982(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(34,c,4)))){
C_save_and_reclaim((void *)f_2982,c,av);}
a=C_alloc(34);
t2=C_s_a_i_plus(&a,2,((C_word*)t0)[2],C_fix(3));
t3=C_s_a_i_remainder(&a,2,((C_word*)t0)[3],C_fix(256));
C_trace(C_text("foreign/c-bytevectors.sld:819: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=*((C_word*)lf[5]+1);
av2[1]=((C_word*)t0)[4];
av2[2]=((C_word*)t0)[5];
av2[3]=t2;
av2[4]=t3;
tp(5,av2);}}

/* k3038 in store! in a2959 in foreign.c-bytevectors#c-bytevector-ieee-single-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in ... */
static void C_ccall f_3040(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(107,c,4)))){
C_save_and_reclaim((void *)f_3040,c,av);}
a=C_alloc(107);
t2=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_3043,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[5],tmp=(C_word)a,a+=6,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[5],C_fix(2));
t4=C_s_a_i_remainder(&a,2,((C_word*)t0)[6],C_fix(2));
t5=C_s_a_i_times(&a,2,C_fix(128),t4);
t6=C_s_a_i_quotient(&a,2,((C_word*)t0)[2],C_fix(65536));
t7=C_s_a_i_plus(&a,2,t5,t6);
C_trace(C_text("foreign/c-bytevectors.sld:825: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=*((C_word*)lf[5]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[4];
av2[3]=t3;
av2[4]=t7;
tp(5,av2);}}

/* k3041 in k3038 in store! in a2959 in foreign.c-bytevectors#c-bytevector-ieee-single-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in ... */
static void C_ccall f_3043(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(45,c,4)))){
C_save_and_reclaim((void *)f_3043,c,av);}
a=C_alloc(45);
t2=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_3046,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[5],tmp=(C_word)a,a+=6,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[5],C_fix(1));
t4=C_s_a_i_remainder(&a,2,((C_word*)t0)[2],C_fix(65536));
t5=C_s_a_i_quotient(&a,2,t4,C_fix(256));
C_trace(C_text("foreign/c-bytevectors.sld:828: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=*((C_word*)lf[5]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[4];
av2[3]=t3;
av2[4]=t5;
tp(5,av2);}}

/* k3044 in k3041 in k3038 in store! in a2959 in foreign.c-bytevectors#c-bytevector-ieee-single-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in ... */
static void C_ccall f_3046(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(5,c,4)))){
C_save_and_reclaim((void *)f_3046,c,av);}
a=C_alloc(5);
t2=C_s_a_i_remainder(&a,2,((C_word*)t0)[2],C_fix(256));
C_trace(C_text("foreign/c-bytevectors.sld:831: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=*((C_word*)lf[5]+1);
av2[1]=((C_word*)t0)[3];
av2[2]=((C_word*)t0)[4];
av2[3]=((C_word*)t0)[5];
av2[4]=t2;
tp(5,av2);}}

/* foreign.c-bytevectors#c-bytevector-ieee-double-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in k2590 in ... */
static void C_ccall f_3128(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4=av[4];
C_word t5=av[5];
C_word t6;
C_word t7;
C_word t8;
C_word *a;
if(c!=6) C_bad_argc_2(c,6,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(10,c,5)))){
C_save_and_reclaim((void *)f_3128,c,av);}
a=C_alloc(10);
t6=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_3134,a[2]=t4,a[3]=((C_word)li73),tmp=(C_word)a,a+=4,tmp);
t7=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_3140,a[2]=t5,a[3]=t3,a[4]=t2,a[5]=((C_word)li76),tmp=(C_word)a,a+=6,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:843: scheme#call-with-values"));{
C_word *av2=av;
av2[0]=0;
av2[1]=t1;
av2[2]=t6;
av2[3]=t7;
C_call_with_values(4,av2);}}

/* a3133 in foreign.c-bytevectors#c-bytevector-ieee-double-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in ... */
static void C_ccall f_3134(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
if(c!=2) C_bad_argc_2(c,2,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,4)))){
C_save_and_reclaim((void *)f_3134,c,av);}
C_trace(C_text("foreign/c-bytevectors.sld:845: c-bytevector:ieee-parts"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[43]);
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=*((C_word*)lf[43]+1);
av2[1]=t1;
av2[2]=((C_word*)t0)[2];
av2[3]=C_fast_retrieve(lf[30]);
av2[4]=C_fast_retrieve(lf[31]);
tp(5,av2);}}

/* a3139 in foreign.c-bytevectors#c-bytevector-ieee-double-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in ... */
static void C_ccall f_3140(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3=av[3];
C_word t4=av[4];
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word t9;
C_word t10;
C_word t11;
C_word *a;
if(c!=5) C_bad_argc_2(c,5,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(42,c,5)))){
C_save_and_reclaim((void *)f_3140,c,av);}
a=C_alloc(42);
t5=C_SCHEME_UNDEFINED;
t6=C_SCHEME_UNDEFINED;
t7=(*a=C_VECTOR_TYPE|1,a[1]=t6,tmp=(C_word)a,a+=2,tmp);
t8=t5=(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)f_3143,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=t7,a[5]=((C_word*)t0)[4],a[6]=((C_word)li74),tmp=(C_word)a,a+=7,tmp);
t9=C_set_block_item(t7,0,(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_3327,a[2]=((C_word*)t0)[4],a[3]=((C_word)li75),tmp=(C_word)a,a+=4,tmp));
if(C_truep(C_i_nequalp(t3,C_fast_retrieve(lf[29])))){
C_trace(C_text("foreign/c-bytevectors.sld:888: store!"));
t10=t5;
f_3143(t10,t1,t2,t3,t4);}
else{
if(C_truep(C_i_lessp(t4,C_fast_retrieve(lf[31])))){
C_trace(C_text("foreign/c-bytevectors.sld:890: store!"));
t10=t5;
f_3143(t10,t1,t2,C_fix(0),t4);}
else{
t10=C_s_a_i_minus(&a,2,t4,C_fast_retrieve(lf[31]));
C_trace(C_text("foreign/c-bytevectors.sld:892: store!"));
t11=t5;
f_3143(t11,t1,t2,t3,t10);}}}

/* store! in a3139 in foreign.c-bytevectors#c-bytevector-ieee-double-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in ... */
static void C_fcall f_3143(C_word t0,C_word t1,C_word t2,C_word t3,C_word t4){
C_word tmp;
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word t9;
C_word t10;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(105,0,4)))){
C_save_and_reclaim_args((void *)trf_3143,5,t0,t1,t2,t3,t4);}
a=C_alloc(105);
t5=(*a=C_CLOSURE_TYPE|8,a[1]=(C_word)f_3147,a[2]=t1,a[3]=((C_word*)t0)[2],a[4]=((C_word*)t0)[3],a[5]=((C_word*)t0)[4],a[6]=t4,a[7]=((C_word*)t0)[5],a[8]=t3,tmp=(C_word)a,a+=9,tmp);
t6=C_s_a_i_plus(&a,2,((C_word*)t0)[3],C_fix(7));
t7=C_s_a_i_times(&a,2,C_fix(128),t2);
t8=C_s_a_i_quotient(&a,2,t3,C_fix(16));
t9=C_s_a_i_plus(&a,2,t7,t8);
C_trace(C_text("foreign/c-bytevectors.sld:851: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word av2[5];
av2[0]=*((C_word*)lf[5]+1);
av2[1]=t5;
av2[2]=((C_word*)t0)[5];
av2[3]=t6;
av2[4]=t9;
tp(5,av2);}}

/* k3145 in store! in a3139 in foreign.c-bytevectors#c-bytevector-ieee-double-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in ... */
static void C_ccall f_3147(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(109,c,4)))){
C_save_and_reclaim((void *)f_3147,c,av);}
a=C_alloc(109);
t2=(*a=C_CLOSURE_TYPE|7,a[1]=(C_word)f_3150,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[5],a[6]=((C_word*)t0)[6],a[7]=((C_word*)t0)[7],tmp=(C_word)a,a+=8,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[4],C_fix(6));
t4=C_s_a_i_remainder(&a,2,((C_word*)t0)[8],C_fix(16));
t5=C_s_a_i_times(&a,2,C_fix(16),t4);
t6=C_s_a_i_quotient(&a,2,((C_word*)t0)[6],C_fast_retrieve(lf[33]));
t7=C_s_a_i_plus(&a,2,t5,t6);
C_trace(C_text("foreign/c-bytevectors.sld:854: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=*((C_word*)lf[5]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[7];
av2[3]=t3;
av2[4]=t7;
tp(5,av2);}}

/* k3148 in k3145 in store! in a3139 in foreign.c-bytevectors#c-bytevector-ieee-double-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in ... */
static void C_ccall f_3150(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(47,c,4)))){
C_save_and_reclaim((void *)f_3150,c,av);}
a=C_alloc(47);
t2=(*a=C_CLOSURE_TYPE|7,a[1]=(C_word)f_3153,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[5],a[6]=((C_word*)t0)[6],a[7]=((C_word*)t0)[7],tmp=(C_word)a,a+=8,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[4],C_fix(5));
t4=C_s_a_i_remainder(&a,2,((C_word*)t0)[6],C_fast_retrieve(lf[33]));
t5=C_s_a_i_quotient(&a,2,t4,C_fast_retrieve(lf[35]));
C_trace(C_text("foreign/c-bytevectors.sld:857: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=*((C_word*)lf[5]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[7];
av2[3]=t3;
av2[4]=t5;
tp(5,av2);}}

/* k3151 in k3148 in k3145 in store! in a3139 in foreign.c-bytevectors#c-bytevector-ieee-double-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in ... */
static void C_ccall f_3153(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(47,c,4)))){
C_save_and_reclaim((void *)f_3153,c,av);}
a=C_alloc(47);
t2=(*a=C_CLOSURE_TYPE|7,a[1]=(C_word)f_3156,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[5],a[6]=((C_word*)t0)[6],a[7]=((C_word*)t0)[7],tmp=(C_word)a,a+=8,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[4],C_fix(4));
t4=C_s_a_i_remainder(&a,2,((C_word*)t0)[6],C_fast_retrieve(lf[35]));
t5=C_s_a_i_quotient(&a,2,t4,C_fast_retrieve(lf[37]));
C_trace(C_text("foreign/c-bytevectors.sld:860: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=*((C_word*)lf[5]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[7];
av2[3]=t3;
av2[4]=t5;
tp(5,av2);}}

/* k3154 in k3151 in k3148 in k3145 in store! in a3139 in foreign.c-bytevectors#c-bytevector-ieee-double-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in ... */
static void C_ccall f_3156(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(47,c,4)))){
C_save_and_reclaim((void *)f_3156,c,av);}
a=C_alloc(47);
t2=(*a=C_CLOSURE_TYPE|7,a[1]=(C_word)f_3159,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[5],a[6]=((C_word*)t0)[6],a[7]=((C_word*)t0)[7],tmp=(C_word)a,a+=8,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[4],C_fix(3));
t4=C_s_a_i_remainder(&a,2,((C_word*)t0)[6],C_fast_retrieve(lf[37]));
t5=C_s_a_i_quotient(&a,2,t4,C_fast_retrieve(lf[39]));
C_trace(C_text("foreign/c-bytevectors.sld:863: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=*((C_word*)lf[5]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[7];
av2[3]=t3;
av2[4]=t5;
tp(5,av2);}}

/* k3157 in k3154 in k3151 in k3148 in k3145 in store! in a3139 in foreign.c-bytevectors#c-bytevector-ieee-double-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in ... */
static void C_ccall f_3159(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(47,c,4)))){
C_save_and_reclaim((void *)f_3159,c,av);}
a=C_alloc(47);
t2=(*a=C_CLOSURE_TYPE|7,a[1]=(C_word)f_3162,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[5],a[6]=((C_word*)t0)[6],a[7]=((C_word*)t0)[7],tmp=(C_word)a,a+=8,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[4],C_fix(2));
t4=C_s_a_i_remainder(&a,2,((C_word*)t0)[6],C_fast_retrieve(lf[39]));
t5=C_s_a_i_quotient(&a,2,t4,C_fast_retrieve(lf[40]));
C_trace(C_text("foreign/c-bytevectors.sld:866: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=*((C_word*)lf[5]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[7];
av2[3]=t3;
av2[4]=t5;
tp(5,av2);}}

/* k3160 in k3157 in k3154 in k3151 in k3148 in k3145 in store! in a3139 in foreign.c-bytevectors#c-bytevector-ieee-double-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in ... */
static void C_ccall f_3162(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(47,c,4)))){
C_save_and_reclaim((void *)f_3162,c,av);}
a=C_alloc(47);
t2=(*a=C_CLOSURE_TYPE|7,a[1]=(C_word)f_3165,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[5],a[6]=((C_word*)t0)[6],a[7]=((C_word*)t0)[7],tmp=(C_word)a,a+=8,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[4],C_fix(1));
t4=C_s_a_i_remainder(&a,2,((C_word*)t0)[6],C_fast_retrieve(lf[40]));
t5=C_s_a_i_quotient(&a,2,t4,C_fix(256));
C_trace(C_text("foreign/c-bytevectors.sld:869: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=*((C_word*)lf[5]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[7];
av2[3]=t3;
av2[4]=t5;
tp(5,av2);}}

/* k3163 in k3160 in k3157 in k3154 in k3151 in k3148 in k3145 in store! in a3139 in foreign.c-bytevectors#c-bytevector-ieee-double-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in ... */
static void C_ccall f_3165(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(11,c,4)))){
C_save_and_reclaim((void *)f_3165,c,av);}
a=C_alloc(11);
t2=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_3168,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[5],tmp=(C_word)a,a+=6,tmp);
t3=C_s_a_i_remainder(&a,2,((C_word*)t0)[6],C_fix(256));
C_trace(C_text("foreign/c-bytevectors.sld:872: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=*((C_word*)lf[5]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[7];
av2[3]=((C_word*)t0)[4];
av2[4]=t3;
tp(5,av2);}}

/* k3166 in k3163 in k3160 in k3157 in k3154 in k3151 in k3148 in k3145 in store! in a3139 in foreign.c-bytevectors#c-bytevector-ieee-double-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in ... */
static void C_ccall f_3168(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(66,c,3)))){
C_save_and_reclaim((void *)f_3168,c,av);}
a=C_alloc(66);
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_3171,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
t3=C_eqp(((C_word*)t0)[3],lf[3]);
if(C_truep(C_i_not(t3))){
t4=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_3180,a[2]=((C_word*)t0)[4],a[3]=((C_word*)t0)[5],a[4]=t2,tmp=(C_word)a,a+=5,tmp);
t5=C_s_a_i_plus(&a,2,((C_word*)t0)[4],C_fix(0));
t6=C_s_a_i_plus(&a,2,((C_word*)t0)[4],C_fix(7));
C_trace(C_text("foreign/c-bytevectors.sld:875: swap!"));
t7=((C_word*)((C_word*)t0)[5])[1];
f_3327(t7,t4,t5,t6);}
else{
t4=t2;{
C_word *av2=av;
av2[0]=t4;
av2[1]=C_SCHEME_UNDEFINED;
f_3171(2,av2);}}}

/* k3169 in k3166 in k3163 in k3160 in k3157 in k3154 in k3151 in k3148 in k3145 in store! in a3139 in foreign.c-bytevectors#c-bytevector-ieee-double-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in ... */
static void C_ccall f_3171(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,1)))){
C_save_and_reclaim((void *)f_3171,c,av);}
t2=((C_word*)t0)[2];{
C_word *av2=av;
av2[0]=t2;
av2[1]=C_SCHEME_UNDEFINED;
((C_proc)(void*)(*((C_word*)t2+1)))(2,av2);}}

/* k3178 in k3166 in k3163 in k3160 in k3157 in k3154 in k3151 in k3148 in k3145 in store! in a3139 in foreign.c-bytevectors#c-bytevector-ieee-double-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in ... */
static void C_ccall f_3180(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(63,c,3)))){
C_save_and_reclaim((void *)f_3180,c,av);}
a=C_alloc(63);
t2=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_3183,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],tmp=(C_word)a,a+=5,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[2],C_fix(1));
t4=C_s_a_i_plus(&a,2,((C_word*)t0)[2],C_fix(6));
C_trace(C_text("foreign/c-bytevectors.sld:876: swap!"));
t5=((C_word*)((C_word*)t0)[3])[1];
f_3327(t5,t2,t3,t4);}

/* k3181 in k3178 in k3166 in k3163 in k3160 in k3157 in k3154 in k3151 in k3148 in k3145 in store! in a3139 in foreign.c-bytevectors#c-bytevector-ieee-double-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in ... */
static void C_ccall f_3183(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(63,c,3)))){
C_save_and_reclaim((void *)f_3183,c,av);}
a=C_alloc(63);
t2=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_3186,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],tmp=(C_word)a,a+=5,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[2],C_fix(2));
t4=C_s_a_i_plus(&a,2,((C_word*)t0)[2],C_fix(5));
C_trace(C_text("foreign/c-bytevectors.sld:877: swap!"));
t5=((C_word*)((C_word*)t0)[3])[1];
f_3327(t5,t2,t3,t4);}

/* k3184 in k3181 in k3178 in k3166 in k3163 in k3160 in k3157 in k3154 in k3151 in k3148 in k3145 in store! in a3139 in foreign.c-bytevectors#c-bytevector-ieee-double-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in ... */
static void C_ccall f_3186(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(58,c,3)))){
C_save_and_reclaim((void *)f_3186,c,av);}
a=C_alloc(58);
t2=C_s_a_i_plus(&a,2,((C_word*)t0)[2],C_fix(3));
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[2],C_fix(4));
C_trace(C_text("foreign/c-bytevectors.sld:878: swap!"));
t4=((C_word*)((C_word*)t0)[3])[1];
f_3327(t4,((C_word*)t0)[4],t2,t3);}

/* swap! in a3139 in foreign.c-bytevectors#c-bytevector-ieee-double-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in ... */
static void C_fcall f_3327(C_word t0,C_word t1,C_word t2,C_word t3){
C_word tmp;
C_word t4;
C_word t5;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(6,0,3)))){
C_save_and_reclaim_args((void *)trf_3327,4,t0,t1,t2,t3);}
a=C_alloc(6);
t4=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_3331,a[2]=t1,a[3]=((C_word*)t0)[2],a[4]=t3,a[5]=t2,tmp=(C_word)a,a+=6,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:882: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word av2[4];
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t4;
av2[2]=((C_word*)t0)[2];
av2[3]=t2;
tp(4,av2);}}

/* k3329 in swap! in a3139 in foreign.c-bytevectors#c-bytevector-ieee-double-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in ... */
static void C_ccall f_3331(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(7,c,3)))){
C_save_and_reclaim((void *)f_3331,c,av);}
a=C_alloc(7);
t2=(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)f_3334,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=t1,a[6]=((C_word*)t0)[5],tmp=(C_word)a,a+=7,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:883: c-bytevector-u8-ref"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[6]);
C_word *av2;
if(c >= 4) {
  av2=av;
} else {
  av2=C_alloc(4);
}
av2[0]=*((C_word*)lf[6]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[3];
av2[3]=((C_word*)t0)[4];
tp(4,av2);}}

/* k3332 in k3329 in swap! in a3139 in foreign.c-bytevectors#c-bytevector-ieee-double-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in ... */
static void C_ccall f_3334(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(6,c,4)))){
C_save_and_reclaim((void *)f_3334,c,av);}
a=C_alloc(6);
t2=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_3337,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[5],tmp=(C_word)a,a+=6,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:884: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=*((C_word*)lf[5]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[3];
av2[3]=((C_word*)t0)[6];
av2[4]=t1;
tp(5,av2);}}

/* k3335 in k3332 in k3329 in swap! in a3139 in foreign.c-bytevectors#c-bytevector-ieee-double-set! in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in ... */
static void C_ccall f_3337(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,4)))){
C_save_and_reclaim((void *)f_3337,c,av);}
C_trace(C_text("foreign/c-bytevectors.sld:885: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=*((C_word*)lf[5]+1);
av2[1]=((C_word*)t0)[2];
av2[2]=((C_word*)t0)[3];
av2[3]=((C_word*)t0)[4];
av2[4]=((C_word*)t0)[5];
tp(5,av2);}}

/* foreign.c-bytevectors#string->utf16 in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in k2590 in ... */
static void C_ccall f_3367(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2=av[2];
C_word t3;
C_word *a;
if(c<3) C_bad_min_argc_2(c,3,t0);
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand((c-3)*C_SIZEOF_PAIR +4,c,5)))){
C_save_and_reclaim((void*)f_3367,c,av);}
a=C_alloc((c-3)*C_SIZEOF_PAIR+4);
t3=C_build_rest(&a,c,3,av);
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word t9;
C_word t10;
t4=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_3371,a[2]=t2,a[3]=t1,tmp=(C_word)a,a+=4,tmp);
if(C_truep(C_rest_nullp(c,3))){
t5=t4;{
C_word *av2=av;
av2[0]=t5;
av2[1]=lf[84];
f_3371(2,av2);}}
else{
t5=C_rest_nullp(c,4);
if(C_truep(C_i_not(t5))){{
C_word *av2;
if(c >= 6) {
  av2=av;
} else {
  av2=C_alloc(6);
}
av2[0]=0;
av2[1]=t4;
av2[2]=C_fast_retrieve(lf[8]);
av2[3]=lf[124];
av2[4]=t2;
av2[5]=t3;
C_apply(6,av2);}}
else{
t6=C_get_rest_arg(c,3,av,3,t0);
t7=C_eqp(t6,lf[84]);
if(C_truep(t7)){
t8=t4;{
C_word *av2=av;
av2[0]=t8;
av2[1]=lf[84];
f_3371(2,av2);}}
else{
t8=C_get_rest_arg(c,3,av,3,t0);
t9=C_eqp(t8,lf[3]);
if(C_truep(t9)){
t10=t4;{
C_word *av2=av;
av2[0]=t10;
av2[1]=lf[3];
f_3371(2,av2);}}
else{{
C_word *av2;
if(c >= 6) {
  av2=av;
} else {
  av2=C_alloc(6);
}
av2[0]=0;
av2[1]=t4;
av2[2]=C_fast_retrieve(lf[8]);
av2[3]=lf[124];
av2[4]=t2;
av2[5]=t3;
C_apply(6,av2);}}}}}}

/* k3369 in foreign.c-bytevectors#string->utf16 in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in k2594 in ... */
static void C_ccall f_3371(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word t9;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(44,c,2)))){
C_save_and_reclaim((void *)f_3371,c,av);}
a=C_alloc(44);
t2=C_eqp(lf[84],t1);
t3=(C_truep(t2)?C_fix(0):C_fix(1));
t4=C_s_a_i_minus(&a,2,C_fix(1),t3);
t5=C_i_string_length(((C_word*)t0)[2]);
t6=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_3382,a[2]=t5,a[3]=((C_word*)t0)[2],a[4]=((C_word)li79),tmp=(C_word)a,a+=5,tmp);
t7=(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)f_3425,a[2]=t5,a[3]=((C_word*)t0)[2],a[4]=t4,a[5]=t3,a[6]=((C_word*)t0)[3],tmp=(C_word)a,a+=7,tmp);
t8=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_3551,a[2]=t7,tmp=(C_word)a,a+=3,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:934: result-length"));
t9=t6;
f_3382(t9,t8);}

/* result-length in k3369 in foreign.c-bytevectors#string->utf16 in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in ... */
static void C_fcall f_3382(C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(8,0,4)))){
C_save_and_reclaim_args((void *)trf_3382,2,t0,t1);}
a=C_alloc(8);
t2=C_SCHEME_UNDEFINED;
t3=(*a=C_VECTOR_TYPE|1,a[1]=t2,tmp=(C_word)a,a+=2,tmp);
t4=C_set_block_item(t3,0,(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_3388,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=t3,a[5]=((C_word)li78),tmp=(C_word)a,a+=6,tmp));
t5=((C_word*)t3)[1];
f_3388(t5,t1,C_fix(0),C_fix(0));}

/* doloop792 in result-length in k3369 in foreign.c-bytevectors#string->utf16 in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in ... */
static void C_fcall f_3388(C_word t0,C_word t1,C_word t2,C_word t3){
C_word tmp;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word t9;
C_word t10;
C_word t11;
C_word t12;
C_word *a;
loop:
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(58,0,3)))){
C_save_and_reclaim_args((void *)trf_3388,4,t0,t1,t2,t3);}
a=C_alloc(58);
if(C_truep(C_i_nequalp(t2,((C_word*)t0)[2]))){
t4=t1;{
C_word av2[2];
av2[0]=t4;
av2[1]=t3;
((C_proc)(void*)(*((C_word*)t4+1)))(2,av2);}}
else{
t4=C_s_a_i_plus(&a,2,t2,C_fix(1));
t5=C_i_string_ref(((C_word*)t0)[3],t2);
t6=C_fix(C_character_code(t5));
t7=C_i_lessp(t6,C_fix(65536));
t8=(C_truep(t7)?C_s_a_i_plus(&a,2,t3,C_fix(2)):C_s_a_i_plus(&a,2,t3,C_fix(4)));
t10=t1;
t11=t4;
t12=t8;
t1=t10;
t2=t11;
t3=t12;
goto loop;}}

/* k3423 in k3369 in foreign.c-bytevectors#string->utf16 in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in ... */
static void C_ccall f_3425(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(15,c,4)))){
C_save_and_reclaim((void *)f_3425,c,av);}
a=C_alloc(15);
t2=C_SCHEME_UNDEFINED;
t3=(*a=C_VECTOR_TYPE|1,a[1]=t2,tmp=(C_word)a,a+=2,tmp);
t4=C_set_block_item(t3,0,(*a=C_CLOSURE_TYPE|8,a[1]=(C_word)f_3427,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=t3,a[5]=((C_word*)t0)[4],a[6]=t1,a[7]=((C_word*)t0)[5],a[8]=((C_word)li82),tmp=(C_word)a,a+=9,tmp));
t5=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_3547,a[2]=((C_word*)t0)[6],a[3]=t1,tmp=(C_word)a,a+=4,tmp);
C_trace(C_text("foreign/c-bytevectors.sld:960: loop"));
t6=((C_word*)t3)[1];
f_3427(t6,t5,C_fix(0),C_fix(0));}

/* loop in k3423 in k3369 in foreign.c-bytevectors#string->utf16 in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in ... */
static void C_fcall f_3427(C_word t0,C_word t1,C_word t2,C_word t3){
C_word tmp;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word t9;
C_word t10;
C_word t11;
C_word t12;
C_word t13;
C_word t14;
C_word t15;
C_word t16;
C_word t17;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(158,0,4)))){
C_save_and_reclaim_args((void *)trf_3427,4,t0,t1,t2,t3);}
a=C_alloc(158);
if(C_truep(C_i_lessp(t2,((C_word*)t0)[2]))){
t4=C_i_string_ref(((C_word*)t0)[3],t2);
t5=C_fix(C_character_code(t4));
if(C_truep(C_i_lessp(t5,C_fix(65536)))){
t6=C_s_a_i_quotient(&a,2,t5,C_fix(256));
t7=C_s_a_i_remainder(&a,2,t5,C_fix(256));
t8=(*a=C_CLOSURE_TYPE|8,a[1]=(C_word)f_3452,a[2]=t2,a[3]=t3,a[4]=((C_word*)t0)[4],a[5]=t1,a[6]=((C_word*)t0)[5],a[7]=((C_word*)t0)[6],a[8]=t7,tmp=(C_word)a,a+=9,tmp);
t9=C_s_a_i_plus(&a,2,t3,((C_word*)t0)[7]);
C_trace(C_text("foreign/c-bytevectors.sld:942: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word av2[5];
av2[0]=*((C_word*)lf[5]+1);
av2[1]=t8;
av2[2]=((C_word*)t0)[6];
av2[3]=t9;
av2[4]=t6;
tp(5,av2);}}
else{
t6=C_s_a_i_minus(&a,2,t5,C_fix(65536));
t7=C_s_a_i_quotient(&a,2,t6,C_fix(1024));
t8=C_s_a_i_remainder(&a,2,t6,C_fix(1024));
t9=C_s_a_i_plus(&a,2,C_fix(55296),t7);
t10=C_s_a_i_plus(&a,2,C_fix(56320),t8);
t11=C_s_a_i_quotient(&a,2,t9,C_fix(256));
t12=C_s_a_i_remainder(&a,2,t9,C_fix(256));
t13=C_s_a_i_quotient(&a,2,t10,C_fix(256));
t14=C_s_a_i_remainder(&a,2,t10,C_fix(256));
t15=(*a=C_CLOSURE_TYPE|11,a[1]=(C_word)f_3504,a[2]=t2,a[3]=t3,a[4]=((C_word*)t0)[4],a[5]=t1,a[6]=((C_word*)t0)[6],a[7]=t14,a[8]=((C_word*)t0)[5],a[9]=t13,a[10]=((C_word*)t0)[7],a[11]=t12,tmp=(C_word)a,a+=12,tmp);
t16=C_s_a_i_plus(&a,2,t3,((C_word*)t0)[7]);
C_trace(C_text("foreign/c-bytevectors.sld:954: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word av2[5];
av2[0]=*((C_word*)lf[5]+1);
av2[1]=t15;
av2[2]=((C_word*)t0)[6];
av2[3]=t16;
av2[4]=t11;
tp(5,av2);}}}
else{
t4=t1;{
C_word av2[2];
av2[0]=t4;
av2[1]=C_SCHEME_UNDEFINED;
((C_proc)(void*)(*((C_word*)t4+1)))(2,av2);}}}

/* k3450 in loop in k3423 in k3369 in foreign.c-bytevectors#string->utf16 in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in ... */
static void C_ccall f_3452(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(35,c,4)))){
C_save_and_reclaim((void *)f_3452,c,av);}
a=C_alloc(35);
t2=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_3455,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[5],tmp=(C_word)a,a+=6,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[3],((C_word*)t0)[6]);
C_trace(C_text("foreign/c-bytevectors.sld:943: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=*((C_word*)lf[5]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[7];
av2[3]=t3;
av2[4]=((C_word*)t0)[8];
tp(5,av2);}}

/* k3453 in k3450 in loop in k3423 in k3369 in foreign.c-bytevectors#string->utf16 in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in ... */
static void C_ccall f_3455(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(58,c,3)))){
C_save_and_reclaim((void *)f_3455,c,av);}
a=C_alloc(58);
t2=C_s_a_i_plus(&a,2,((C_word*)t0)[2],C_fix(1));
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[3],C_fix(2));
C_trace(C_text("foreign/c-bytevectors.sld:944: loop"));
t4=((C_word*)((C_word*)t0)[4])[1];
f_3427(t4,((C_word*)t0)[5],t2,t3);}

/* k3502 in loop in k3423 in k3369 in foreign.c-bytevectors#string->utf16 in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in ... */
static void C_ccall f_3504(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(40,c,4)))){
C_save_and_reclaim((void *)f_3504,c,av);}
a=C_alloc(40);
t2=(*a=C_CLOSURE_TYPE|10,a[1]=(C_word)f_3507,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[5],a[6]=((C_word*)t0)[6],a[7]=((C_word*)t0)[7],a[8]=((C_word*)t0)[8],a[9]=((C_word*)t0)[9],a[10]=((C_word*)t0)[10],tmp=(C_word)a,a+=11,tmp);
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[3],((C_word*)t0)[8]);
C_trace(C_text("foreign/c-bytevectors.sld:955: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word *av2;
if(c >= 5) {
  av2=av;
} else {
  av2=C_alloc(5);
}
av2[0]=*((C_word*)lf[5]+1);
av2[1]=t2;
av2[2]=((C_word*)t0)[6];
av2[3]=t3;
av2[4]=((C_word*)t0)[11];
tp(5,av2);}}

/* k3505 in k3502 in loop in k3423 in k3369 in foreign.c-bytevectors#string->utf16 in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in ... */
static void C_ccall f_3507(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(44,c,2)))){
C_save_and_reclaim((void *)f_3507,c,av);}
a=C_alloc(44);
t2=(*a=C_CLOSURE_TYPE|8,a[1]=(C_word)f_3510,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[5],a[6]=((C_word*)t0)[6],a[7]=((C_word*)t0)[7],a[8]=((C_word*)t0)[8],tmp=(C_word)a,a+=9,tmp);
t3=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)va3725,a[2]=t2,a[3]=((C_word*)t0)[6],a[4]=((C_word*)t0)[9],a[5]=((C_word)li81),tmp=(C_word)a,a+=6,tmp);
t4=t3;
va3725(t4,C_s_a_i_plus(&a,2,((C_word*)t0)[3],((C_word*)t0)[10]));}

/* k3508 in k3505 in k3502 in loop in k3423 in k3369 in foreign.c-bytevectors#string->utf16 in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in ... */
static void C_ccall f_3510(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(41,c,2)))){
C_save_and_reclaim((void *)f_3510,c,av);}
a=C_alloc(41);
t2=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_3513,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[5],tmp=(C_word)a,a+=6,tmp);
t3=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)va3723,a[2]=t2,a[3]=((C_word*)t0)[6],a[4]=((C_word*)t0)[7],a[5]=((C_word)li80),tmp=(C_word)a,a+=6,tmp);
t4=t3;
va3723(t4,C_s_a_i_plus(&a,2,((C_word*)t0)[3],((C_word*)t0)[8]));}

/* k3511 in k3508 in k3505 in k3502 in loop in k3423 in k3369 in foreign.c-bytevectors#string->utf16 in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in ... */
static void C_ccall f_3513(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(58,c,3)))){
C_save_and_reclaim((void *)f_3513,c,av);}
a=C_alloc(58);
t2=C_s_a_i_plus(&a,2,((C_word*)t0)[2],C_fix(1));
t3=C_s_a_i_plus(&a,2,((C_word*)t0)[3],C_fix(4));
C_trace(C_text("foreign/c-bytevectors.sld:958: loop"));
t4=((C_word*)((C_word*)t0)[4])[1];
f_3427(t4,((C_word*)t0)[5],t2,t3);}

/* k3545 in k3423 in k3369 in foreign.c-bytevectors#string->utf16 in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in ... */
static void C_ccall f_3547(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,1)))){
C_save_and_reclaim((void *)f_3547,c,av);}
t2=((C_word*)t0)[2];{
C_word *av2=av;
av2[0]=t2;
av2[1]=((C_word*)t0)[3];
((C_proc)(void*)(*((C_word*)t2+1)))(2,av2);}}

/* k3549 in k3369 in foreign.c-bytevectors#string->utf16 in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in k2610 in k2606 in k2602 in k2598 in ... */
static void C_ccall f_3551(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(0,c,2)))){
C_save_and_reclaim((void *)f_3551,c,av);}
C_trace(C_text("foreign/c-bytevectors.sld:934: make-c-bytevector"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[4]);
C_word *av2;
if(c >= 3) {
  av2=av;
} else {
  av2=C_alloc(3);
}
av2[0]=*((C_word*)lf[4]+1);
av2[1]=((C_word*)t0)[2];
av2[2]=t1;
tp(3,av2);}}

/* toplevel */
static C_TLS int toplevel_initialized=0;

void C_ccall C_foreign_2ec_2dbytevectors_toplevel(C_word c,C_word *av){
C_word tmp;
C_word t0=av[0];
C_word t1=av[1];
C_word t2;
C_word t3;
C_word *a;
if(toplevel_initialized) {C_kontinue(t1,C_SCHEME_UNDEFINED);}
else C_toplevel_entry(C_text("foreign.c-bytevectors"));
C_check_nursery_minimum(C_calculate_demand(3,c,2));
if(C_unlikely(!C_demand(C_calculate_demand(3,c,2)))){
C_save_and_reclaim((void*)C_foreign_2ec_2dbytevectors_toplevel,c,av);}
toplevel_initialized=1;
if(C_unlikely(!C_demand_2(799))){
C_save(t1);
C_rereclaim2(799*sizeof(C_word),1);
t1=C_restore;}
a=C_alloc(3);
C_initialize_lf(lf,126);
lf[0]=C_h_intern(&lf[0],21, C_text("foreign.c-bytevectors"));
lf[1]=C_h_intern(&lf[1],22, C_text("foreign.c-bytevectors#"));
lf[2]=C_h_intern(&lf[2],39, C_text("foreign.c-bytevectors#native-endianness"));
lf[3]=C_h_intern(&lf[3],6, C_text("little"));
lf[4]=C_h_intern(&lf[4],39, C_text("foreign.c-bytevectors#make-c-bytevector"));
lf[5]=C_h_intern(&lf[5],42, C_text("foreign.c-bytevectors#c-bytevector-u8-set!"));
lf[6]=C_h_intern(&lf[6],41, C_text("foreign.c-bytevectors#c-bytevector-u8-ref"));
lf[7]=C_h_intern(&lf[7],40, C_text("foreign.c-bytevectors#c-bytevectors-init"));
lf[8]=C_h_intern(&lf[8],30, C_text("foreign.c-bytevectors#complain"));
lf[9]=C_h_intern(&lf[9],18, C_text("chicken.base#error"));
lf[10]=C_h_intern(&lf[10],20, C_text("scheme#string-append"));
lf[11]=C_decode_literal(C_heaptop,C_text("\376B\000\000\034illegal arguments passed to "));
lf[12]=C_h_intern(&lf[12],21, C_text("scheme#symbol->string"));
lf[13]=C_h_intern(&lf[13],35, C_text("foreign.c-bytevectors#make-uint-ref"));
lf[14]=C_h_intern(&lf[14],43, C_text("foreign.c-bytevectors#c-bytevector-uint-ref"));
lf[15]=C_h_intern(&lf[15],35, C_text("foreign.c-bytevectors#make-sint-ref"));
lf[16]=C_h_intern(&lf[16],43, C_text("foreign.c-bytevectors#c-bytevector-sint-ref"));
lf[17]=C_h_intern(&lf[17],36, C_text("foreign.c-bytevectors#make-uint-set!"));
lf[18]=C_h_intern(&lf[18],44, C_text("foreign.c-bytevectors#c-bytevector-uint-set!"));
lf[19]=C_h_intern(&lf[19],36, C_text("foreign.c-bytevectors#make-sint-set!"));
lf[20]=C_h_intern(&lf[20],44, C_text("foreign.c-bytevectors#c-bytevector-sint-set!"));
lf[21]=C_h_intern(&lf[21],37, C_text("foreign.c-bytevectors#make-ref/native"));
lf[22]=C_h_intern(&lf[22],36, C_text("foreign.c-bytevectors#ensure-aligned"));
lf[23]=C_h_intern(&lf[23],38, C_text("foreign.c-bytevectors#make-set!/native"));
lf[24]=C_decode_literal(C_heaptop,C_text("\376B\000\000\037non-aligned c-bytevector access"));
lf[25]=C_h_intern(&lf[25],49, C_text("foreign.c-bytevectors#make-int-list->c-bytevector"));
lf[26]=C_h_intern(&lf[26],53, C_text("foreign.c-bytevectors#c-bytevector:single-maxexponent"));
lf[27]=C_h_intern(&lf[27],46, C_text("foreign.c-bytevectors#c-bytevector:single-bias"));
lf[28]=C_h_intern(&lf[28],52, C_text("foreign.c-bytevectors#c-bytevector:single-hidden-bit"));
lf[29]=C_h_intern(&lf[29],53, C_text("foreign.c-bytevectors#c-bytevector:double-maxexponent"));
lf[30]=C_h_intern(&lf[30],46, C_text("foreign.c-bytevectors#c-bytevector:double-bias"));
lf[31]=C_h_intern(&lf[31],52, C_text("foreign.c-bytevectors#c-bytevector:double-hidden-bit"));
lf[32]=C_decode_literal(C_heaptop,C_text("\376\302\000\000\01610000000000000"));
lf[33]=C_h_intern(&lf[33],28, C_text("foreign.c-bytevectors#two^48"));
lf[34]=C_decode_literal(C_heaptop,C_text("\376\302\000\000\0151000000000000"));
lf[35]=C_h_intern(&lf[35],28, C_text("foreign.c-bytevectors#two^40"));
lf[36]=C_decode_literal(C_heaptop,C_text("\376\302\000\000\01310000000000"));
lf[37]=C_h_intern(&lf[37],28, C_text("foreign.c-bytevectors#two^32"));
lf[38]=C_decode_literal(C_heaptop,C_text("\376\302\000\000\011100000000"));
lf[39]=C_h_intern(&lf[39],28, C_text("foreign.c-bytevectors#two^24"));
lf[40]=C_h_intern(&lf[40],28, C_text("foreign.c-bytevectors#two^16"));
lf[41]=C_h_intern(&lf[41],27, C_text("foreign.c-bytevectors#two^8"));
lf[42]=C_h_intern(&lf[42],56, C_text("foreign.c-bytevectors#c-bytevector:normalized-ieee-parts"));
lf[43]=C_h_intern(&lf[43],45, C_text("foreign.c-bytevectors#c-bytevector:ieee-parts"));
lf[44]=C_decode_literal(C_heaptop,C_text("\376U-0.0\000"));
lf[45]=C_h_intern(&lf[45],23, C_text("c-bytevector:ieee-parts"));
lf[46]=C_decode_literal(C_heaptop,C_text("\376B\000\000\027this shouldn\047t happen: "));
lf[47]=C_h_intern(&lf[47],8, C_text("scheme#/"));
lf[48]=C_h_intern(&lf[48],12, C_text("scheme#round"));
lf[49]=C_h_intern(&lf[49],18, C_text("scheme#denominator"));
lf[50]=C_h_intern(&lf[50],16, C_text("scheme#numerator"));
lf[51]=C_h_intern(&lf[51],21, C_text("scheme#inexact->exact"));
lf[52]=C_h_intern(&lf[52],10, C_text("scheme#abs"));
lf[53]=C_h_intern(&lf[53],22, C_text("chicken.base#infinite\077"));
lf[54]=C_h_intern(&lf[54],17, C_text("chicken.base#nan\077"));
lf[55]=C_h_intern(&lf[55],61, C_text("foreign.c-bytevectors#c-bytevector-ieee-double-big-endian-ref"));
lf[56]=C_h_intern(&lf[56],38, C_text("foreign.c-bytevectors#make-ieee-double"));
lf[57]=C_h_intern(&lf[57],64, C_text("foreign.c-bytevectors#c-bytevector-ieee-double-little-endian-ref"));
lf[58]=C_h_intern(&lf[58],61, C_text("foreign.c-bytevectors#c-bytevector-ieee-single-big-endian-ref"));
lf[59]=C_h_intern(&lf[59],38, C_text("foreign.c-bytevectors#make-ieee-single"));
lf[60]=C_h_intern(&lf[60],64, C_text("foreign.c-bytevectors#c-bytevector-ieee-single-little-endian-ref"));
lf[61]=C_decode_literal(C_heaptop,C_text("\376U+inf.0\000"));
lf[62]=C_decode_literal(C_heaptop,C_text("\376U-inf.0\000"));
lf[63]=C_decode_literal(C_heaptop,C_text("\376U+nan.0\000"));
lf[64]=C_decode_literal(C_heaptop,C_text("\376U+nan.0\000"));
lf[65]=C_decode_literal(C_heaptop,C_text("\376U0.0\000"));
lf[66]=C_decode_literal(C_heaptop,C_text("\376U65536.0\000"));
lf[67]=C_h_intern(&lf[67],11, C_text("scheme#expt"));
lf[68]=C_decode_literal(C_heaptop,C_text("\376U2.0\000"));
lf[69]=C_decode_literal(C_heaptop,C_text("\376U2251799813685248.0\000"));
lf[70]=C_h_intern(&lf[70],21, C_text("scheme#exact->inexact"));
lf[71]=C_decode_literal(C_heaptop,C_text("\376U4503599627370496.0\000"));
lf[72]=C_decode_literal(C_heaptop,C_text("\376U+nan.0\000"));
lf[73]=C_decode_literal(C_heaptop,C_text("\376U+nan.0\000"));
lf[74]=C_decode_literal(C_heaptop,C_text("\376U4194304.0\000"));
lf[75]=C_decode_literal(C_heaptop,C_text("\376U8388608.0\000"));
lf[76]=C_h_intern(&lf[76],45, C_text("foreign.c-bytevectors#r6rs:c-bytevector-copy!"));
lf[77]=C_h_intern(&lf[77],41, C_text("foreign.c-bytevectors#c-bytevector-s8-ref"));
lf[78]=C_h_intern(&lf[78],42, C_text("foreign.c-bytevectors#c-bytevector-s8-set!"));
lf[79]=C_h_intern(&lf[79],43, C_text("foreign.c-bytevectors#u8-list->c-bytevector"));
lf[80]=C_h_intern(&lf[80],44, C_text("foreign.c-bytevectors#c-bytevector-uchar-ref"));
lf[81]=C_h_intern(&lf[81],45, C_text("foreign.c-bytevectors#c-bytevector-uchar-set!"));
lf[82]=C_h_intern(&lf[82],43, C_text("foreign.c-bytevectors#c-bytevector-char-ref"));
lf[83]=C_h_intern(&lf[83],44, C_text("foreign.c-bytevectors#c-bytevector-char-set!"));
lf[84]=C_h_intern(&lf[84],3, C_text("big"));
lf[85]=C_h_intern(&lf[85],42, C_text("foreign.c-bytevectors#c-bytevector-u16-ref"));
lf[86]=C_h_intern(&lf[86],42, C_text("foreign.c-bytevectors#c-bytevector-s16-ref"));
lf[87]=C_h_intern(&lf[87],43, C_text("foreign.c-bytevectors#c-bytevector-u16-set!"));
lf[88]=C_h_intern(&lf[88],43, C_text("foreign.c-bytevectors#c-bytevector-s16-set!"));
lf[89]=C_h_intern(&lf[89],49, C_text("foreign.c-bytevectors#c-bytevector-u16-native-ref"));
lf[90]=C_h_intern(&lf[90],49, C_text("foreign.c-bytevectors#c-bytevector-s16-native-ref"));
lf[91]=C_h_intern(&lf[91],50, C_text("foreign.c-bytevectors#c-bytevector-u16-native-set!"));
lf[92]=C_h_intern(&lf[92],50, C_text("foreign.c-bytevectors#c-bytevector-s16-native-set!"));
lf[93]=C_h_intern(&lf[93],42, C_text("foreign.c-bytevectors#c-bytevector-u32-ref"));
lf[94]=C_h_intern(&lf[94],42, C_text("foreign.c-bytevectors#c-bytevector-s32-ref"));
lf[95]=C_h_intern(&lf[95],43, C_text("foreign.c-bytevectors#c-bytevector-u32-set!"));
lf[96]=C_h_intern(&lf[96],43, C_text("foreign.c-bytevectors#c-bytevector-s32-set!"));
lf[97]=C_h_intern(&lf[97],49, C_text("foreign.c-bytevectors#c-bytevector-u32-native-ref"));
lf[98]=C_h_intern(&lf[98],49, C_text("foreign.c-bytevectors#c-bytevector-s32-native-ref"));
lf[99]=C_h_intern(&lf[99],50, C_text("foreign.c-bytevectors#c-bytevector-u32-native-set!"));
lf[100]=C_h_intern(&lf[100],50, C_text("foreign.c-bytevectors#c-bytevector-s32-native-set!"));
lf[101]=C_h_intern(&lf[101],42, C_text("foreign.c-bytevectors#c-bytevector-u64-ref"));
lf[102]=C_h_intern(&lf[102],42, C_text("foreign.c-bytevectors#c-bytevector-s64-ref"));
lf[103]=C_h_intern(&lf[103],43, C_text("foreign.c-bytevectors#c-bytevector-u64-set!"));
lf[104]=C_h_intern(&lf[104],43, C_text("foreign.c-bytevectors#c-bytevector-s64-set!"));
lf[105]=C_h_intern(&lf[105],49, C_text("foreign.c-bytevectors#c-bytevector-u64-native-ref"));
lf[106]=C_h_intern(&lf[106],49, C_text("foreign.c-bytevectors#c-bytevector-s64-native-ref"));
lf[107]=C_h_intern(&lf[107],50, C_text("foreign.c-bytevectors#c-bytevector-u64-native-set!"));
lf[108]=C_h_intern(&lf[108],50, C_text("foreign.c-bytevectors#c-bytevector-s64-native-set!"));
lf[109]=C_h_intern(&lf[109],57, C_text("foreign.c-bytevectors#c-bytevector-ieee-single-native-ref"));
lf[110]=C_h_intern(&lf[110],35, C_text("c-bytevector-ieee-single-native-ref"));
lf[111]=C_h_intern(&lf[111],57, C_text("foreign.c-bytevectors#c-bytevector-ieee-double-native-ref"));
lf[112]=C_h_intern(&lf[112],35, C_text("c-bytevector-ieee-double-native-ref"));
lf[113]=C_h_intern(&lf[113],58, C_text("foreign.c-bytevectors#c-bytevector-ieee-single-native-set!"));
lf[114]=C_h_intern(&lf[114],51, C_text("foreign.c-bytevectors#c-bytevector-ieee-single-set!"));
lf[115]=C_h_intern(&lf[115],36, C_text("c-bytevector-ieee-single-native-set!"));
lf[116]=C_h_intern(&lf[116],58, C_text("foreign.c-bytevectors#c-bytevector-ieee-double-native-set!"));
lf[117]=C_h_intern(&lf[117],36, C_text("c-bytevector-ieee-double-native-set!"));
lf[118]=C_h_intern(&lf[118],51, C_text("foreign.c-bytevectors#c-bytevector-ieee-double-set!"));
lf[119]=C_h_intern(&lf[119],50, C_text("foreign.c-bytevectors#c-bytevector-ieee-single-ref"));
lf[120]=C_h_intern(&lf[120],28, C_text("c-bytevector-ieee-single-ref"));
lf[121]=C_h_intern(&lf[121],50, C_text("foreign.c-bytevectors#c-bytevector-ieee-double-ref"));
lf[122]=C_h_intern(&lf[122],28, C_text("c-bytevector-ieee-double-ref"));
lf[123]=C_h_intern(&lf[123],35, C_text("foreign.c-bytevectors#string->utf16"));
lf[124]=C_h_intern(&lf[124],13, C_text("string->utf16"));
lf[125]=C_h_intern(&lf[125],13, C_text("##sys#provide"));
C_register_lf2(lf,126,create_ptable());{}
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1035,a[2]=t1,tmp=(C_word)a,a+=3,tmp);{
C_word *av2=av;
av2[0]=C_SCHEME_UNDEFINED;
av2[1]=t2;
C_library_toplevel(2,av2);}}

/* va3683 in k1324 in foreign.c-bytevectors#c-bytevector:ieee-parts in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_fcall va3683(C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(58,0,4)))){
C_save_and_reclaim_args((void *)trva3683,2,t0,t1);}
a=C_alloc(58);
t2=C_s_a_i_plus(&a,2,t1,C_fix(1));
t3=C_s_a_i_minus(&a,2,((C_word*)t0)[2],C_fix(1));
C_trace(C_text("foreign/c-bytevectors.sld:335: scheme#values"));{
C_word av2[5];
av2[0]=0;
av2[1]=((C_word*)t0)[3];
av2[2]=C_fix(0);
av2[3]=t2;
av2[4]=t3;
C_values(5,av2);}}

/* va3685 in k1341 in k1324 in foreign.c-bytevectors#c-bytevector:ieee-parts in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_fcall va3685(C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(29,0,4)))){
C_save_and_reclaim_args((void *)trva3685,2,t0,t1);}
a=C_alloc(29);
t2=C_s_a_i_plus(&a,2,t1,C_fix(1));
C_trace(C_text("foreign/c-bytevectors.sld:337: scheme#values"));{
C_word av2[5];
av2[0]=0;
av2[1]=((C_word*)t0)[2];
av2[2]=((C_word*)t0)[3];
av2[3]=t2;
av2[4]=C_fix(0);
C_values(5,av2);}}

/* va3687 */
static void C_fcall va3687(C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(29,0,4)))){
C_save_and_reclaim_args((void *)trva3687,2,t0,t1);}
a=C_alloc(29);
t2=C_s_a_i_plus(&a,2,t1,C_fix(1));
C_trace(C_text("foreign/c-bytevectors.sld:365: scheme#values"));{
C_word av2[5];
av2[0]=0;
av2[1]=((C_word*)t0)[2];
av2[2]=((C_word*)t0)[3];
av2[3]=t2;
av2[4]=C_fix(0);
C_values(5,av2);}}

/* va3691 in k1404 in a1395 in k1383 in k1380 in k1377 in k1341 in k1324 in foreign.c-bytevectors#c-bytevector:ieee-parts in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_fcall va3691(C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(71,0,3)))){
C_save_and_reclaim_args((void *)trva3691,2,t0,t1);}
a=C_alloc(71);
t2=C_s_a_i_plus(&a,2,t1,C_fix(1));
if(C_truep(C_i_greater_or_equalp(((C_word*)t0)[2],t2))){
t3=C_i_positivep(((C_word*)t0)[3]);
t4=(C_truep(t3)?C_fix(0):C_fix(1));
t5=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)va3687,a[2]=((C_word*)t0)[4],a[3]=t4,a[4]=((C_word)li26),tmp=(C_word)a,a+=5,tmp);
t6=t5;
va3687(t6,C_s_a_i_plus(&a,2,((C_word*)t0)[5],((C_word*)t0)[5]));}
else{
t3=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_1470,a[2]=((C_word*)t0)[6],a[3]=((C_word*)t0)[7],a[4]=((C_word*)t0)[4],a[5]=((C_word*)t0)[2],tmp=(C_word)a,a+=6,tmp);
t4=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1507,a[2]=t3,tmp=(C_word)a,a+=3,tmp);
t5=C_s_a_i_times(&a,2,((C_word*)t0)[6],((C_word*)t0)[8]);
C_trace(C_text("foreign/c-bytevectors.sld:370: scheme#/"));
{C_proc tp=(C_proc)C_fast_retrieve_proc(*((C_word*)lf[47]+1));
C_word av2[4];
av2[0]=*((C_word*)lf[47]+1);
av2[1]=t4;
av2[2]=t5;
av2[3]=((C_word*)t0)[9];
tp(4,av2);}}}

/* va3693 in a1395 in k1383 in k1380 in k1377 in k1341 in k1324 in foreign.c-bytevectors#c-bytevector:ieee-parts in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_fcall va3693(C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(29,0,4)))){
C_save_and_reclaim_args((void *)trva3693,2,t0,t1);}
a=C_alloc(29);
t2=C_s_a_i_plus(&a,2,t1,C_fix(1));
C_trace(C_text("foreign/c-bytevectors.sld:349: scheme#<"));{
C_word av2[5];
av2[0]=0;
av2[1]=((C_word*)t0)[2];
av2[2]=C_fix(0);
av2[3]=((C_word*)t0)[3];
av2[4]=t2;
C_lessp(5,av2);}}

/* va3695 in k1551 in k1548 in k1545 in k1542 in k1539 in k1536 in k1533 in k1530 in foreign.c-bytevectors#c-bytevector-ieee-double-big-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_fcall va3695(C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(153,0,6)))){
C_save_and_reclaim_args((void *)trva3695,2,t0,t1);}
a=C_alloc(153);
t2=C_s_a_i_plus(&a,2,t1,((C_word*)t0)[2]);
t3=C_s_a_i_times(&a,2,C_fix(256),((C_word*)t0)[3]);
t4=C_s_a_i_plus(&a,2,t3,((C_word*)t0)[4]);
t5=C_s_a_i_times(&a,2,C_fix(256),((C_word*)t0)[5]);
t6=C_s_a_i_plus(&a,2,t5,((C_word*)t0)[6]);
C_trace(C_text("foreign/c-bytevectors.sld:399: make-ieee-double"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[56]);
C_word av2[7];
av2[0]=*((C_word*)lf[56]+1);
av2[1]=((C_word*)t0)[7];
av2[2]=((C_word*)t0)[8];
av2[3]=((C_word*)t0)[9];
av2[4]=t2;
av2[5]=t4;
av2[6]=t6;
tp(7,av2);}}

/* va3697 in k1660 in k1657 in k1654 in k1651 in k1648 in k1645 in k1642 in k1639 in foreign.c-bytevectors#c-bytevector-ieee-double-little-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_fcall va3697(C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(153,0,6)))){
C_save_and_reclaim_args((void *)trva3697,2,t0,t1);}
a=C_alloc(153);
t2=C_s_a_i_plus(&a,2,t1,((C_word*)t0)[2]);
t3=C_s_a_i_times(&a,2,C_fix(256),((C_word*)t0)[3]);
t4=C_s_a_i_plus(&a,2,t3,((C_word*)t0)[4]);
t5=C_s_a_i_times(&a,2,C_fix(256),((C_word*)t0)[5]);
t6=C_s_a_i_plus(&a,2,t5,((C_word*)t0)[6]);
C_trace(C_text("foreign/c-bytevectors.sld:418: make-ieee-double"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[56]);
C_word av2[7];
av2[0]=*((C_word*)lf[56]+1);
av2[1]=((C_word*)t0)[7];
av2[2]=((C_word*)t0)[8];
av2[3]=((C_word*)t0)[9];
av2[4]=t2;
av2[5]=t4;
av2[6]=t6;
tp(7,av2);}}

/* va3699 in k1757 in k1754 in k1751 in k1748 in foreign.c-bytevectors#c-bytevector-ieee-single-big-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_fcall va3699(C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(29,0,4)))){
C_save_and_reclaim_args((void *)trva3699,2,t0,t1);}
a=C_alloc(29);
t2=C_s_a_i_plus(&a,2,t1,((C_word*)t0)[2]);
C_trace(C_text("foreign/c-bytevectors.sld:435: make-ieee-single"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[59]);
C_word av2[5];
av2[0]=*((C_word*)lf[59]+1);
av2[1]=((C_word*)t0)[3];
av2[2]=((C_word*)t0)[4];
av2[3]=((C_word*)t0)[5];
av2[4]=t2;
tp(5,av2);}}

/* va3701 in k1824 in k1821 in k1818 in k1815 in foreign.c-bytevectors#c-bytevector-ieee-single-little-endian-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_fcall va3701(C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(29,0,4)))){
C_save_and_reclaim_args((void *)trva3701,2,t0,t1);}
a=C_alloc(29);
t2=C_s_a_i_plus(&a,2,t1,((C_word*)t0)[2]);
C_trace(C_text("foreign/c-bytevectors.sld:448: make-ieee-single"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[59]);
C_word av2[5];
av2[0]=*((C_word*)lf[59]+1);
av2[1]=((C_word*)t0)[3];
av2[2]=((C_word*)t0)[4];
av2[3]=((C_word*)t0)[5];
av2[4]=t2;
tp(5,av2);}}

/* va3703 in foreign.c-bytevectors#make-ieee-double in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_fcall va3703(C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(29,0,1)))){
C_save_and_reclaim_args((void *)trva3703,2,t0,t1);}
a=C_alloc(29);
t2=C_s_a_i_plus(&a,2,t1,((C_word*)t0)[2]);
if(C_truep(C_i_zerop(t2))){
t3=C_i_nequalp(C_fix(0),((C_word*)t0)[3]);
t4=((C_word*)t0)[4];{
C_word av2[2];
av2[0]=t4;
av2[1]=(C_truep(t3)?lf[61]:lf[62]);
((C_proc)(void*)(*((C_word*)t4+1)))(2,av2);}}
else{
t3=C_i_nequalp(C_fix(0),((C_word*)t0)[3]);
t4=((C_word*)t0)[4];{
C_word av2[2];
av2[0]=t4;
av2[1]=(C_truep(t3)?lf[63]:lf[64]);
((C_proc)(void*)(*((C_word*)t4+1)))(2,av2);}}}

/* va3715 in foreign.c-bytevectors#c-bytevector-sint-ref in k1060 in k1057 in k1054 in k1051 in k1048 in k1045 in k1042 in k1039 in k1036 in k1033 */
static void C_fcall va3715(C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(29,0,1)))){
C_save_and_reclaim_args((void *)trva3715,2,t0,t1);}
a=C_alloc(29);
t2=((C_word*)t0)[2];
f_2451(t2,C_s_a_i_plus(&a,2,t1,C_fix(-1)));}

/* va3723 in k3508 in k3505 in k3502 in loop in k3423 in k3369 in foreign.c-bytevectors#string->utf16 in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in ... */
static void C_fcall va3723(C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(29,0,4)))){
C_save_and_reclaim_args((void *)trva3723,2,t0,t1);}
a=C_alloc(29);
t2=C_s_a_i_plus(&a,2,t1,C_fix(2));
C_trace(C_text("foreign/c-bytevectors.sld:957: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word av2[5];
av2[0]=*((C_word*)lf[5]+1);
av2[1]=((C_word*)t0)[2];
av2[2]=((C_word*)t0)[3];
av2[3]=t2;
av2[4]=((C_word*)t0)[4];
tp(5,av2);}}

/* va3725 in k3505 in k3502 in loop in k3423 in k3369 in foreign.c-bytevectors#string->utf16 in k2670 in k2666 in k2662 in k2658 in k2654 in k2650 in k2646 in k2642 in k2638 in k2634 in k2630 in k2626 in k2622 in k2618 in k2614 in ... */
static void C_fcall va3725(C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word *a;
C_check_for_interrupt;
if(C_unlikely(!C_demand(C_calculate_demand(29,0,4)))){
C_save_and_reclaim_args((void *)trva3725,2,t0,t1);}
a=C_alloc(29);
t2=C_s_a_i_plus(&a,2,t1,C_fix(2));
C_trace(C_text("foreign/c-bytevectors.sld:956: c-bytevector-u8-set!"));
{C_proc tp=(C_proc)C_fast_retrieve_symbol_proc(lf[5]);
C_word av2[5];
av2[0]=*((C_word*)lf[5]+1);
av2[1]=((C_word*)t0)[2];
av2[2]=((C_word*)t0)[3];
av2[3]=t2;
av2[4]=((C_word*)t0)[4];
tp(5,av2);}}

#ifdef C_ENABLE_PTABLES
static C_PTABLE_ENTRY ptable[250] = {
{C_text("f_1035:foreign_2fc_2dbytevectors_2esld"),(void*)f_1035},
{C_text("f_1038:foreign_2fc_2dbytevectors_2esld"),(void*)f_1038},
{C_text("f_1041:foreign_2fc_2dbytevectors_2esld"),(void*)f_1041},
{C_text("f_1044:foreign_2fc_2dbytevectors_2esld"),(void*)f_1044},
{C_text("f_1047:foreign_2fc_2dbytevectors_2esld"),(void*)f_1047},
{C_text("f_1050:foreign_2fc_2dbytevectors_2esld"),(void*)f_1050},
{C_text("f_1053:foreign_2fc_2dbytevectors_2esld"),(void*)f_1053},
{C_text("f_1056:foreign_2fc_2dbytevectors_2esld"),(void*)f_1056},
{C_text("f_1059:foreign_2fc_2dbytevectors_2esld"),(void*)f_1059},
{C_text("f_1062:foreign_2fc_2dbytevectors_2esld"),(void*)f_1062},
{C_text("f_1064:foreign_2fc_2dbytevectors_2esld"),(void*)f_1064},
{C_text("f_1070:foreign_2fc_2dbytevectors_2esld"),(void*)f_1070},
{C_text("f_1076:foreign_2fc_2dbytevectors_2esld"),(void*)f_1076},
{C_text("f_1084:foreign_2fc_2dbytevectors_2esld"),(void*)f_1084},
{C_text("f_1088:foreign_2fc_2dbytevectors_2esld"),(void*)f_1088},
{C_text("f_1090:foreign_2fc_2dbytevectors_2esld"),(void*)f_1090},
{C_text("f_1092:foreign_2fc_2dbytevectors_2esld"),(void*)f_1092},
{C_text("f_1098:foreign_2fc_2dbytevectors_2esld"),(void*)f_1098},
{C_text("f_1100:foreign_2fc_2dbytevectors_2esld"),(void*)f_1100},
{C_text("f_1106:foreign_2fc_2dbytevectors_2esld"),(void*)f_1106},
{C_text("f_1108:foreign_2fc_2dbytevectors_2esld"),(void*)f_1108},
{C_text("f_1114:foreign_2fc_2dbytevectors_2esld"),(void*)f_1114},
{C_text("f_1116:foreign_2fc_2dbytevectors_2esld"),(void*)f_1116},
{C_text("f_1122:foreign_2fc_2dbytevectors_2esld"),(void*)f_1122},
{C_text("f_1124:foreign_2fc_2dbytevectors_2esld"),(void*)f_1124},
{C_text("f_1128:foreign_2fc_2dbytevectors_2esld"),(void*)f_1128},
{C_text("f_1135:foreign_2fc_2dbytevectors_2esld"),(void*)f_1135},
{C_text("f_1137:foreign_2fc_2dbytevectors_2esld"),(void*)f_1137},
{C_text("f_1139:foreign_2fc_2dbytevectors_2esld"),(void*)f_1139},
{C_text("f_1143:foreign_2fc_2dbytevectors_2esld"),(void*)f_1143},
{C_text("f_1150:foreign_2fc_2dbytevectors_2esld"),(void*)f_1150},
{C_text("f_1152:foreign_2fc_2dbytevectors_2esld"),(void*)f_1152},
{C_text("f_1172:foreign_2fc_2dbytevectors_2esld"),(void*)f_1172},
{C_text("f_1174:foreign_2fc_2dbytevectors_2esld"),(void*)f_1174},
{C_text("f_1178:foreign_2fc_2dbytevectors_2esld"),(void*)f_1178},
{C_text("f_1179:foreign_2fc_2dbytevectors_2esld"),(void*)f_1179},
{C_text("f_1188:foreign_2fc_2dbytevectors_2esld"),(void*)f_1188},
{C_text("f_1198:foreign_2fc_2dbytevectors_2esld"),(void*)f_1198},
{C_text("f_1241:foreign_2fc_2dbytevectors_2esld"),(void*)f_1241},
{C_text("f_1253:foreign_2fc_2dbytevectors_2esld"),(void*)f_1253},
{C_text("f_1285:foreign_2fc_2dbytevectors_2esld"),(void*)f_1285},
{C_text("f_1319:foreign_2fc_2dbytevectors_2esld"),(void*)f_1319},
{C_text("f_1326:foreign_2fc_2dbytevectors_2esld"),(void*)f_1326},
{C_text("f_1343:foreign_2fc_2dbytevectors_2esld"),(void*)f_1343},
{C_text("f_1379:foreign_2fc_2dbytevectors_2esld"),(void*)f_1379},
{C_text("f_1382:foreign_2fc_2dbytevectors_2esld"),(void*)f_1382},
{C_text("f_1385:foreign_2fc_2dbytevectors_2esld"),(void*)f_1385},
{C_text("f_1390:foreign_2fc_2dbytevectors_2esld"),(void*)f_1390},
{C_text("f_1396:foreign_2fc_2dbytevectors_2esld"),(void*)f_1396},
{C_text("f_1406:foreign_2fc_2dbytevectors_2esld"),(void*)f_1406},
{C_text("f_1415:foreign_2fc_2dbytevectors_2esld"),(void*)f_1415},
{C_text("f_1433:foreign_2fc_2dbytevectors_2esld"),(void*)f_1433},
{C_text("f_1436:foreign_2fc_2dbytevectors_2esld"),(void*)f_1436},
{C_text("f_1443:foreign_2fc_2dbytevectors_2esld"),(void*)f_1443},
{C_text("f_1470:foreign_2fc_2dbytevectors_2esld"),(void*)f_1470},
{C_text("f_1472:foreign_2fc_2dbytevectors_2esld"),(void*)f_1472},
{C_text("f_1493:foreign_2fc_2dbytevectors_2esld"),(void*)f_1493},
{C_text("f_1507:foreign_2fc_2dbytevectors_2esld"),(void*)f_1507},
{C_text("f_1523:foreign_2fc_2dbytevectors_2esld"),(void*)f_1523},
{C_text("f_1528:foreign_2fc_2dbytevectors_2esld"),(void*)f_1528},
{C_text("f_1532:foreign_2fc_2dbytevectors_2esld"),(void*)f_1532},
{C_text("f_1535:foreign_2fc_2dbytevectors_2esld"),(void*)f_1535},
{C_text("f_1538:foreign_2fc_2dbytevectors_2esld"),(void*)f_1538},
{C_text("f_1541:foreign_2fc_2dbytevectors_2esld"),(void*)f_1541},
{C_text("f_1544:foreign_2fc_2dbytevectors_2esld"),(void*)f_1544},
{C_text("f_1547:foreign_2fc_2dbytevectors_2esld"),(void*)f_1547},
{C_text("f_1550:foreign_2fc_2dbytevectors_2esld"),(void*)f_1550},
{C_text("f_1553:foreign_2fc_2dbytevectors_2esld"),(void*)f_1553},
{C_text("f_1637:foreign_2fc_2dbytevectors_2esld"),(void*)f_1637},
{C_text("f_1641:foreign_2fc_2dbytevectors_2esld"),(void*)f_1641},
{C_text("f_1644:foreign_2fc_2dbytevectors_2esld"),(void*)f_1644},
{C_text("f_1647:foreign_2fc_2dbytevectors_2esld"),(void*)f_1647},
{C_text("f_1650:foreign_2fc_2dbytevectors_2esld"),(void*)f_1650},
{C_text("f_1653:foreign_2fc_2dbytevectors_2esld"),(void*)f_1653},
{C_text("f_1656:foreign_2fc_2dbytevectors_2esld"),(void*)f_1656},
{C_text("f_1659:foreign_2fc_2dbytevectors_2esld"),(void*)f_1659},
{C_text("f_1662:foreign_2fc_2dbytevectors_2esld"),(void*)f_1662},
{C_text("f_1746:foreign_2fc_2dbytevectors_2esld"),(void*)f_1746},
{C_text("f_1750:foreign_2fc_2dbytevectors_2esld"),(void*)f_1750},
{C_text("f_1753:foreign_2fc_2dbytevectors_2esld"),(void*)f_1753},
{C_text("f_1756:foreign_2fc_2dbytevectors_2esld"),(void*)f_1756},
{C_text("f_1759:foreign_2fc_2dbytevectors_2esld"),(void*)f_1759},
{C_text("f_1813:foreign_2fc_2dbytevectors_2esld"),(void*)f_1813},
{C_text("f_1817:foreign_2fc_2dbytevectors_2esld"),(void*)f_1817},
{C_text("f_1820:foreign_2fc_2dbytevectors_2esld"),(void*)f_1820},
{C_text("f_1823:foreign_2fc_2dbytevectors_2esld"),(void*)f_1823},
{C_text("f_1826:foreign_2fc_2dbytevectors_2esld"),(void*)f_1826},
{C_text("f_1880:foreign_2fc_2dbytevectors_2esld"),(void*)f_1880},
{C_text("f_1921:foreign_2fc_2dbytevectors_2esld"),(void*)f_1921},
{C_text("f_1930:foreign_2fc_2dbytevectors_2esld"),(void*)f_1930},
{C_text("f_1939:foreign_2fc_2dbytevectors_2esld"),(void*)f_1939},
{C_text("f_1955:foreign_2fc_2dbytevectors_2esld"),(void*)f_1955},
{C_text("f_1959:foreign_2fc_2dbytevectors_2esld"),(void*)f_1959},
{C_text("f_1967:foreign_2fc_2dbytevectors_2esld"),(void*)f_1967},
{C_text("f_1975:foreign_2fc_2dbytevectors_2esld"),(void*)f_1975},
{C_text("f_1993:foreign_2fc_2dbytevectors_2esld"),(void*)f_1993},
{C_text("f_2002:foreign_2fc_2dbytevectors_2esld"),(void*)f_2002},
{C_text("f_2018:foreign_2fc_2dbytevectors_2esld"),(void*)f_2018},
{C_text("f_2030:foreign_2fc_2dbytevectors_2esld"),(void*)f_2030},
{C_text("f_2038:foreign_2fc_2dbytevectors_2esld"),(void*)f_2038},
{C_text("f_2040:foreign_2fc_2dbytevectors_2esld"),(void*)f_2040},
{C_text("f_2086:foreign_2fc_2dbytevectors_2esld"),(void*)f_2086},
{C_text("f_2089:foreign_2fc_2dbytevectors_2esld"),(void*)f_2089},
{C_text("f_2105:foreign_2fc_2dbytevectors_2esld"),(void*)f_2105},
{C_text("f_2109:foreign_2fc_2dbytevectors_2esld"),(void*)f_2109},
{C_text("f_2115:foreign_2fc_2dbytevectors_2esld"),(void*)f_2115},
{C_text("f_2118:foreign_2fc_2dbytevectors_2esld"),(void*)f_2118},
{C_text("f_2134:foreign_2fc_2dbytevectors_2esld"),(void*)f_2134},
{C_text("f_2140:foreign_2fc_2dbytevectors_2esld"),(void*)f_2140},
{C_text("f_2152:foreign_2fc_2dbytevectors_2esld"),(void*)f_2152},
{C_text("f_2162:foreign_2fc_2dbytevectors_2esld"),(void*)f_2162},
{C_text("f_2177:foreign_2fc_2dbytevectors_2esld"),(void*)f_2177},
{C_text("f_2190:foreign_2fc_2dbytevectors_2esld"),(void*)f_2190},
{C_text("f_2200:foreign_2fc_2dbytevectors_2esld"),(void*)f_2200},
{C_text("f_2215:foreign_2fc_2dbytevectors_2esld"),(void*)f_2215},
{C_text("f_2221:foreign_2fc_2dbytevectors_2esld"),(void*)f_2221},
{C_text("f_2225:foreign_2fc_2dbytevectors_2esld"),(void*)f_2225},
{C_text("f_2236:foreign_2fc_2dbytevectors_2esld"),(void*)f_2236},
{C_text("f_2252:foreign_2fc_2dbytevectors_2esld"),(void*)f_2252},
{C_text("f_2259:foreign_2fc_2dbytevectors_2esld"),(void*)f_2259},
{C_text("f_2262:foreign_2fc_2dbytevectors_2esld"),(void*)f_2262},
{C_text("f_2264:foreign_2fc_2dbytevectors_2esld"),(void*)f_2264},
{C_text("f_2274:foreign_2fc_2dbytevectors_2esld"),(void*)f_2274},
{C_text("f_2291:foreign_2fc_2dbytevectors_2esld"),(void*)f_2291},
{C_text("f_2299:foreign_2fc_2dbytevectors_2esld"),(void*)f_2299},
{C_text("f_2301:foreign_2fc_2dbytevectors_2esld"),(void*)f_2301},
{C_text("f_2311:foreign_2fc_2dbytevectors_2esld"),(void*)f_2311},
{C_text("f_2319:foreign_2fc_2dbytevectors_2esld"),(void*)f_2319},
{C_text("f_2321:foreign_2fc_2dbytevectors_2esld"),(void*)f_2321},
{C_text("f_2331:foreign_2fc_2dbytevectors_2esld"),(void*)f_2331},
{C_text("f_2343:foreign_2fc_2dbytevectors_2esld"),(void*)f_2343},
{C_text("f_2369:foreign_2fc_2dbytevectors_2esld"),(void*)f_2369},
{C_text("f_2388:foreign_2fc_2dbytevectors_2esld"),(void*)f_2388},
{C_text("f_2414:foreign_2fc_2dbytevectors_2esld"),(void*)f_2414},
{C_text("f_2425:foreign_2fc_2dbytevectors_2esld"),(void*)f_2425},
{C_text("f_2427:foreign_2fc_2dbytevectors_2esld"),(void*)f_2427},
{C_text("f_2431:foreign_2fc_2dbytevectors_2esld"),(void*)f_2431},
{C_text("f_2434:foreign_2fc_2dbytevectors_2esld"),(void*)f_2434},
{C_text("f_2447:foreign_2fc_2dbytevectors_2esld"),(void*)f_2447},
{C_text("f_2451:foreign_2fc_2dbytevectors_2esld"),(void*)f_2451},
{C_text("f_2459:foreign_2fc_2dbytevectors_2esld"),(void*)f_2459},
{C_text("f_2471:foreign_2fc_2dbytevectors_2esld"),(void*)f_2471},
{C_text("f_2484:foreign_2fc_2dbytevectors_2esld"),(void*)f_2484},
{C_text("f_2518:foreign_2fc_2dbytevectors_2esld"),(void*)f_2518},
{C_text("f_2531:foreign_2fc_2dbytevectors_2esld"),(void*)f_2531},
{C_text("f_2557:foreign_2fc_2dbytevectors_2esld"),(void*)f_2557},
{C_text("f_2559:foreign_2fc_2dbytevectors_2esld"),(void*)f_2559},
{C_text("f_2563:foreign_2fc_2dbytevectors_2esld"),(void*)f_2563},
{C_text("f_2576:foreign_2fc_2dbytevectors_2esld"),(void*)f_2576},
{C_text("f_2580:foreign_2fc_2dbytevectors_2esld"),(void*)f_2580},
{C_text("f_2584:foreign_2fc_2dbytevectors_2esld"),(void*)f_2584},
{C_text("f_2588:foreign_2fc_2dbytevectors_2esld"),(void*)f_2588},
{C_text("f_2592:foreign_2fc_2dbytevectors_2esld"),(void*)f_2592},
{C_text("f_2596:foreign_2fc_2dbytevectors_2esld"),(void*)f_2596},
{C_text("f_2600:foreign_2fc_2dbytevectors_2esld"),(void*)f_2600},
{C_text("f_2604:foreign_2fc_2dbytevectors_2esld"),(void*)f_2604},
{C_text("f_2608:foreign_2fc_2dbytevectors_2esld"),(void*)f_2608},
{C_text("f_2612:foreign_2fc_2dbytevectors_2esld"),(void*)f_2612},
{C_text("f_2616:foreign_2fc_2dbytevectors_2esld"),(void*)f_2616},
{C_text("f_2620:foreign_2fc_2dbytevectors_2esld"),(void*)f_2620},
{C_text("f_2624:foreign_2fc_2dbytevectors_2esld"),(void*)f_2624},
{C_text("f_2628:foreign_2fc_2dbytevectors_2esld"),(void*)f_2628},
{C_text("f_2632:foreign_2fc_2dbytevectors_2esld"),(void*)f_2632},
{C_text("f_2636:foreign_2fc_2dbytevectors_2esld"),(void*)f_2636},
{C_text("f_2640:foreign_2fc_2dbytevectors_2esld"),(void*)f_2640},
{C_text("f_2644:foreign_2fc_2dbytevectors_2esld"),(void*)f_2644},
{C_text("f_2648:foreign_2fc_2dbytevectors_2esld"),(void*)f_2648},
{C_text("f_2652:foreign_2fc_2dbytevectors_2esld"),(void*)f_2652},
{C_text("f_2656:foreign_2fc_2dbytevectors_2esld"),(void*)f_2656},
{C_text("f_2660:foreign_2fc_2dbytevectors_2esld"),(void*)f_2660},
{C_text("f_2664:foreign_2fc_2dbytevectors_2esld"),(void*)f_2664},
{C_text("f_2668:foreign_2fc_2dbytevectors_2esld"),(void*)f_2668},
{C_text("f_2672:foreign_2fc_2dbytevectors_2esld"),(void*)f_2672},
{C_text("f_2674:foreign_2fc_2dbytevectors_2esld"),(void*)f_2674},
{C_text("f_2684:foreign_2fc_2dbytevectors_2esld"),(void*)f_2684},
{C_text("f_2704:foreign_2fc_2dbytevectors_2esld"),(void*)f_2704},
{C_text("f_2725:foreign_2fc_2dbytevectors_2esld"),(void*)f_2725},
{C_text("f_2727:foreign_2fc_2dbytevectors_2esld"),(void*)f_2727},
{C_text("f_2737:foreign_2fc_2dbytevectors_2esld"),(void*)f_2737},
{C_text("f_2757:foreign_2fc_2dbytevectors_2esld"),(void*)f_2757},
{C_text("f_2778:foreign_2fc_2dbytevectors_2esld"),(void*)f_2778},
{C_text("f_2780:foreign_2fc_2dbytevectors_2esld"),(void*)f_2780},
{C_text("f_2790:foreign_2fc_2dbytevectors_2esld"),(void*)f_2790},
{C_text("f_2810:foreign_2fc_2dbytevectors_2esld"),(void*)f_2810},
{C_text("f_2831:foreign_2fc_2dbytevectors_2esld"),(void*)f_2831},
{C_text("f_2833:foreign_2fc_2dbytevectors_2esld"),(void*)f_2833},
{C_text("f_2877:foreign_2fc_2dbytevectors_2esld"),(void*)f_2877},
{C_text("f_2898:foreign_2fc_2dbytevectors_2esld"),(void*)f_2898},
{C_text("f_2900:foreign_2fc_2dbytevectors_2esld"),(void*)f_2900},
{C_text("f_2924:foreign_2fc_2dbytevectors_2esld"),(void*)f_2924},
{C_text("f_2948:foreign_2fc_2dbytevectors_2esld"),(void*)f_2948},
{C_text("f_2954:foreign_2fc_2dbytevectors_2esld"),(void*)f_2954},
{C_text("f_2960:foreign_2fc_2dbytevectors_2esld"),(void*)f_2960},
{C_text("f_2963:foreign_2fc_2dbytevectors_2esld"),(void*)f_2963},
{C_text("f_2967:foreign_2fc_2dbytevectors_2esld"),(void*)f_2967},
{C_text("f_2976:foreign_2fc_2dbytevectors_2esld"),(void*)f_2976},
{C_text("f_2979:foreign_2fc_2dbytevectors_2esld"),(void*)f_2979},
{C_text("f_2982:foreign_2fc_2dbytevectors_2esld"),(void*)f_2982},
{C_text("f_3040:foreign_2fc_2dbytevectors_2esld"),(void*)f_3040},
{C_text("f_3043:foreign_2fc_2dbytevectors_2esld"),(void*)f_3043},
{C_text("f_3046:foreign_2fc_2dbytevectors_2esld"),(void*)f_3046},
{C_text("f_3128:foreign_2fc_2dbytevectors_2esld"),(void*)f_3128},
{C_text("f_3134:foreign_2fc_2dbytevectors_2esld"),(void*)f_3134},
{C_text("f_3140:foreign_2fc_2dbytevectors_2esld"),(void*)f_3140},
{C_text("f_3143:foreign_2fc_2dbytevectors_2esld"),(void*)f_3143},
{C_text("f_3147:foreign_2fc_2dbytevectors_2esld"),(void*)f_3147},
{C_text("f_3150:foreign_2fc_2dbytevectors_2esld"),(void*)f_3150},
{C_text("f_3153:foreign_2fc_2dbytevectors_2esld"),(void*)f_3153},
{C_text("f_3156:foreign_2fc_2dbytevectors_2esld"),(void*)f_3156},
{C_text("f_3159:foreign_2fc_2dbytevectors_2esld"),(void*)f_3159},
{C_text("f_3162:foreign_2fc_2dbytevectors_2esld"),(void*)f_3162},
{C_text("f_3165:foreign_2fc_2dbytevectors_2esld"),(void*)f_3165},
{C_text("f_3168:foreign_2fc_2dbytevectors_2esld"),(void*)f_3168},
{C_text("f_3171:foreign_2fc_2dbytevectors_2esld"),(void*)f_3171},
{C_text("f_3180:foreign_2fc_2dbytevectors_2esld"),(void*)f_3180},
{C_text("f_3183:foreign_2fc_2dbytevectors_2esld"),(void*)f_3183},
{C_text("f_3186:foreign_2fc_2dbytevectors_2esld"),(void*)f_3186},
{C_text("f_3327:foreign_2fc_2dbytevectors_2esld"),(void*)f_3327},
{C_text("f_3331:foreign_2fc_2dbytevectors_2esld"),(void*)f_3331},
{C_text("f_3334:foreign_2fc_2dbytevectors_2esld"),(void*)f_3334},
{C_text("f_3337:foreign_2fc_2dbytevectors_2esld"),(void*)f_3337},
{C_text("f_3367:foreign_2fc_2dbytevectors_2esld"),(void*)f_3367},
{C_text("f_3371:foreign_2fc_2dbytevectors_2esld"),(void*)f_3371},
{C_text("f_3382:foreign_2fc_2dbytevectors_2esld"),(void*)f_3382},
{C_text("f_3388:foreign_2fc_2dbytevectors_2esld"),(void*)f_3388},
{C_text("f_3425:foreign_2fc_2dbytevectors_2esld"),(void*)f_3425},
{C_text("f_3427:foreign_2fc_2dbytevectors_2esld"),(void*)f_3427},
{C_text("f_3452:foreign_2fc_2dbytevectors_2esld"),(void*)f_3452},
{C_text("f_3455:foreign_2fc_2dbytevectors_2esld"),(void*)f_3455},
{C_text("f_3504:foreign_2fc_2dbytevectors_2esld"),(void*)f_3504},
{C_text("f_3507:foreign_2fc_2dbytevectors_2esld"),(void*)f_3507},
{C_text("f_3510:foreign_2fc_2dbytevectors_2esld"),(void*)f_3510},
{C_text("f_3513:foreign_2fc_2dbytevectors_2esld"),(void*)f_3513},
{C_text("f_3547:foreign_2fc_2dbytevectors_2esld"),(void*)f_3547},
{C_text("f_3551:foreign_2fc_2dbytevectors_2esld"),(void*)f_3551},
{C_text("toplevel:foreign_2fc_2dbytevectors_2esld"),(void*)C_foreign_2ec_2dbytevectors_toplevel},
{C_text("va3683:foreign_2fc_2dbytevectors_2esld"),(void*)va3683},
{C_text("va3685:foreign_2fc_2dbytevectors_2esld"),(void*)va3685},
{C_text("va3687:foreign_2fc_2dbytevectors_2esld"),(void*)va3687},
{C_text("va3691:foreign_2fc_2dbytevectors_2esld"),(void*)va3691},
{C_text("va3693:foreign_2fc_2dbytevectors_2esld"),(void*)va3693},
{C_text("va3695:foreign_2fc_2dbytevectors_2esld"),(void*)va3695},
{C_text("va3697:foreign_2fc_2dbytevectors_2esld"),(void*)va3697},
{C_text("va3699:foreign_2fc_2dbytevectors_2esld"),(void*)va3699},
{C_text("va3701:foreign_2fc_2dbytevectors_2esld"),(void*)va3701},
{C_text("va3703:foreign_2fc_2dbytevectors_2esld"),(void*)va3703},
{C_text("va3715:foreign_2fc_2dbytevectors_2esld"),(void*)va3715},
{C_text("va3723:foreign_2fc_2dbytevectors_2esld"),(void*)va3723},
{C_text("va3725:foreign_2fc_2dbytevectors_2esld"),(void*)va3725},
{NULL,NULL}};
#endif

static C_PTABLE_ENTRY *create_ptable(void){
#ifdef C_ENABLE_PTABLES
return ptable;
#else
return NULL;
#endif
}

/*
o|folded constant expression: (scheme#expt (quote 2) (quote 23)) 
o|folded constant expression: (scheme#expt (quote 2) (quote 52)) 
o|folded constant expression: (scheme#expt (quote 2) (quote 48)) 
o|folded constant expression: (scheme#expt (quote 2) (quote 40)) 
o|folded constant expression: (scheme#expt (quote 2) (quote 32)) 
o|folded constant expression: (scheme#expt (quote 2) (quote 24)) 
o|folded constant expression: (scheme#expt (quote 2) (quote 16)) 
o|folded constant expression: (scheme#expt (quote 2) (quote 8)) 
o|folded constant expression: (scheme#* (quote 256) (quote 256)) 
o|folded constant expression: (scheme#* (quote 256) (quote 256)) 
o|folded constant expression: (scheme#* (quote 256) (quote 256)) 
o|folded constant expression: (scheme#* (quote 256) (quote 256)) 
(o e)|assignments to immediate values: 6 
o|substituted constant variable: two^51429 
o|substituted constant variable: two^52436 
o|substituted constant variable: two^22448 
o|substituted constant variable: two^23453 
o|replaced variables: 646 
o|removed binding forms: 153 
o|removed conditional forms: 4 
o|converted assignments to bindings: (store!704) 
o|converted assignments to bindings: (result-length791) 
o|simplifications: ((let . 2)) 
o|removed binding forms: 531 
o|simplifications: ((if . 16) (##core#call . 371)) 
o|  call simplifications:
o|    scheme#string-length
o|    scheme#string-ref	2
o|    scheme#eq?	6
o|    scheme#equal?	6
o|    scheme#char->integer	4
o|    scheme#integer->char	2
o|    scheme#>	2
o|    scheme#negative?	2
o|    scheme#call-with-values	3
o|    scheme#=	31
o|    scheme#quotient	30
o|    scheme#integer?
o|    scheme#eqv?	7
o|    scheme#positive?	2
o|    scheme#<=	2
o|    scheme#<	13
o|    scheme#>=	6
o|    scheme#-	22
o|    scheme#values	10
o|    scheme#length	2
o|    scheme#*	35
o|    scheme#null?	4
o|    scheme#car	4
o|    scheme#+	115
o|    scheme#cdr	3
o|    scheme#remainder	37
o|    scheme#zero?	4
o|    scheme#not	12
o|    scheme#apply	3
o|contracted procedure: k1168 
o|contracted procedure: k1164 
o|contracted procedure: k1157 
o|contracted procedure: k1193 
o|contracted procedure: k1203 
o|contracted procedure: k1207 
o|contracted procedure: k1211 
o|contracted procedure: k1219 
o|contracted procedure: k1215 
o|contracted procedure: k1224 
o|contracted procedure: k1230 
o|contracted procedure: k1246 
o|contracted procedure: k1258 
o|contracted procedure: k1268 
o|contracted procedure: k1272 
o|contracted procedure: k1315 
o|contracted procedure: k1278 
o|contracted procedure: k1308 
o|contracted procedure: k1290 
o|contracted procedure: k1300 
o|contracted procedure: k1304 
o|contracted procedure: k1335 
o|contracted procedure: k1355 
o|contracted procedure: k1348 
o|contracted procedure: k1361 
o|contracted procedure: k1371 
o|contracted procedure: k1368 
o|contracted procedure: k1524 
o|contracted procedure: k1374 
o|contracted procedure: k1398 
o|contracted procedure: k1410 
o|contracted procedure: k1416 
o|contracted procedure: k1422 
o|contracted procedure: k1447 
o|contracted procedure: k1461 
o|contracted procedure: k1454 
o|contracted procedure: k1498 
o|contracted procedure: k1477 
o|contracted procedure: k1487 
o|contracted procedure: k1495 
o|contracted procedure: k1509 
o|contracted procedure: k1554 
o|contracted procedure: k1601 
o|contracted procedure: k1593 
o|contracted procedure: k1597 
o|contracted procedure: k1557 
o|contracted procedure: k1577 
o|contracted procedure: k1563 
o|contracted procedure: k1573 
o|contracted procedure: k1566 
o|contracted procedure: k1589 
o|contracted procedure: k1581 
o|contracted procedure: k1585 
o|contracted procedure: k1605 
o|contracted procedure: k1609 
o|contracted procedure: k1613 
o|contracted procedure: k1617 
o|contracted procedure: k1621 
o|contracted procedure: k1625 
o|contracted procedure: k1629 
o|contracted procedure: k1633 
o|contracted procedure: k1663 
o|contracted procedure: k1710 
o|contracted procedure: k1702 
o|contracted procedure: k1706 
o|contracted procedure: k1666 
o|contracted procedure: k1686 
o|contracted procedure: k1672 
o|contracted procedure: k1682 
o|contracted procedure: k1675 
o|contracted procedure: k1698 
o|contracted procedure: k1690 
o|contracted procedure: k1694 
o|contracted procedure: k1714 
o|contracted procedure: k1718 
o|contracted procedure: k1722 
o|contracted procedure: k1726 
o|contracted procedure: k1730 
o|contracted procedure: k1734 
o|contracted procedure: k1738 
o|contracted procedure: k1742 
o|contracted procedure: k1760 
o|contracted procedure: k1793 
o|contracted procedure: k1785 
o|contracted procedure: k1789 
o|contracted procedure: k1763 
o|contracted procedure: k1781 
o|contracted procedure: k1773 
o|contracted procedure: k1777 
o|contracted procedure: k1797 
o|contracted procedure: k1801 
o|contracted procedure: k1805 
o|contracted procedure: k1809 
o|contracted procedure: k1827 
o|contracted procedure: k1860 
o|contracted procedure: k1852 
o|contracted procedure: k1856 
o|contracted procedure: k1830 
o|contracted procedure: k1848 
o|contracted procedure: k1840 
o|contracted procedure: k1844 
o|contracted procedure: k1864 
o|contracted procedure: k1868 
o|contracted procedure: k1872 
o|contracted procedure: k1876 
o|contracted procedure: k1885 
o|contracted procedure: k1891 
o|contracted procedure: k1897 
o|contracted procedure: k1903 
o|contracted procedure: k1913 
o|contracted procedure: k1925 
o|contracted procedure: k1969 
o|contracted procedure: k1931 
o|contracted procedure: k1961 
o|contracted procedure: k1934 
o|contracted procedure: k1940 
o|contracted procedure: k1946 
o|contracted procedure: k1976 
o|contracted procedure: k1982 
o|contracted procedure: k1988 
o|contracted procedure: k2032 
o|contracted procedure: k1994 
o|contracted procedure: k2024 
o|contracted procedure: k1997 
o|contracted procedure: k2003 
o|contracted procedure: k2009 
o|contracted procedure: k2020 
o|contracted procedure: k2045 
o|contracted procedure: k2051 
o|contracted procedure: k2057 
o|contracted procedure: k2063 
o|contracted procedure: k2069 
o|contracted procedure: k2075 
o|contracted procedure: k2081 
o|contracted procedure: k2090 
o|contracted procedure: k2096 
o|contracted procedure: k2110 
o|contracted procedure: k2119 
o|contracted procedure: k2125 
o|contracted procedure: k2136 
o|contracted procedure: k2145 
o|contracted procedure: k2157 
o|contracted procedure: k2167 
o|contracted procedure: k2171 
o|contracted procedure: k2179 
o|contracted procedure: k2186 
o|contracted procedure: k2195 
o|contracted procedure: k2205 
o|contracted procedure: k2209 
o|contracted procedure: k2217 
o|contracted procedure: k2229 
o|contracted procedure: k2245 
o|contracted procedure: k2242 
o|contracted procedure: k2254 
o|contracted procedure: k2269 
o|contracted procedure: k2279 
o|contracted procedure: k2283 
o|contracted procedure: k2287 
o|contracted procedure: k2307 
o|contracted procedure: k2327 
o|contracted procedure: k2336 
o|contracted procedure: k2348 
o|contracted procedure: k2355 
o|contracted procedure: k2363 
o|contracted procedure: k2359 
o|contracted procedure: k2371 
o|contracted procedure: k2377 
o|contracted procedure: k2384 
o|contracted procedure: k2393 
o|contracted procedure: k2400 
o|contracted procedure: k2408 
o|contracted procedure: k2404 
o|contracted procedure: k2416 
o|contracted procedure: k2438 
o|contracted procedure: k2452 
o|contracted procedure: k2464 
o|contracted procedure: k2476 
o|contracted procedure: k2489 
o|contracted procedure: k2493 
o|contracted procedure: k2497 
o|contracted procedure: k2501 
o|contracted procedure: k2507 
o|contracted procedure: k2514 
o|contracted procedure: k2523 
o|contracted procedure: k2536 
o|contracted procedure: k2540 
o|contracted procedure: k2544 
o|contracted procedure: k2548 
o|contracted procedure: k2567 
o|contracted procedure: k2679 
o|contracted procedure: k2699 
o|contracted procedure: k2695 
o|contracted procedure: k2688 
o|contracted procedure: k2719 
o|contracted procedure: k2715 
o|contracted procedure: k2708 
o|contracted procedure: k2732 
o|contracted procedure: k2752 
o|contracted procedure: k2748 
o|contracted procedure: k2741 
o|contracted procedure: k2772 
o|contracted procedure: k2768 
o|contracted procedure: k2761 
o|contracted procedure: k2785 
o|contracted procedure: k2805 
o|contracted procedure: k2801 
o|contracted procedure: k2794 
o|contracted procedure: k2825 
o|contracted procedure: k2821 
o|contracted procedure: k2814 
o|contracted procedure: k2838 
o|contracted procedure: k2872 
o|contracted procedure: k2868 
o|contracted procedure: k2844 
o|contracted procedure: k2861 
o|contracted procedure: k2857 
o|contracted procedure: k2850 
o|contracted procedure: k2892 
o|contracted procedure: k2888 
o|contracted procedure: k2881 
o|contracted procedure: k2905 
o|contracted procedure: k2914 
o|contracted procedure: k2929 
o|contracted procedure: k2938 
o|contracted procedure: k2971 
o|contracted procedure: k2987 
o|contracted procedure: k2991 
o|contracted procedure: k2995 
o|contracted procedure: k3003 
o|contracted procedure: k2999 
o|contracted procedure: k3007 
o|contracted procedure: k3023 
o|contracted procedure: k3015 
o|contracted procedure: k3019 
o|contracted procedure: k3011 
o|contracted procedure: k3031 
o|contracted procedure: k3035 
o|contracted procedure: k3027 
o|contracted procedure: k3051 
o|contracted procedure: k3055 
o|contracted procedure: k3063 
o|contracted procedure: k3059 
o|contracted procedure: k3067 
o|contracted procedure: k3083 
o|contracted procedure: k3075 
o|contracted procedure: k3079 
o|contracted procedure: k3071 
o|contracted procedure: k3087 
o|contracted procedure: k3095 
o|contracted procedure: k3099 
o|contracted procedure: k3091 
o|contracted procedure: k3105 
o|contracted procedure: k3114 
o|contracted procedure: k3124 
o|contracted procedure: k3223 
o|contracted procedure: k3175 
o|contracted procedure: k3191 
o|contracted procedure: k3195 
o|contracted procedure: k3199 
o|contracted procedure: k3203 
o|contracted procedure: k3207 
o|contracted procedure: k3211 
o|contracted procedure: k3215 
o|contracted procedure: k3219 
o|contracted procedure: k3227 
o|contracted procedure: k3231 
o|contracted procedure: k3239 
o|contracted procedure: k3235 
o|contracted procedure: k3243 
o|contracted procedure: k3251 
o|contracted procedure: k3247 
o|contracted procedure: k3255 
o|contracted procedure: k3263 
o|contracted procedure: k3259 
o|contracted procedure: k3267 
o|contracted procedure: k3275 
o|contracted procedure: k3271 
o|contracted procedure: k3279 
o|contracted procedure: k3287 
o|contracted procedure: k3283 
o|contracted procedure: k3291 
o|contracted procedure: k3307 
o|contracted procedure: k3299 
o|contracted procedure: k3303 
o|contracted procedure: k3295 
o|contracted procedure: k3311 
o|contracted procedure: k3319 
o|contracted procedure: k3323 
o|contracted procedure: k3315 
o|contracted procedure: k3344 
o|contracted procedure: k3353 
o|contracted procedure: k3363 
o|contracted procedure: k3552 
o|contracted procedure: k3372 
o|contracted procedure: k3375 
o|contracted procedure: k3378 
o|contracted procedure: k3393 
o|contracted procedure: k3400 
o|contracted procedure: k3420 
o|contracted procedure: k3404 
o|contracted procedure: k3410 
o|contracted procedure: k3407 
o|contracted procedure: k3432 
o|contracted procedure: k3542 
o|contracted procedure: k3435 
o|contracted procedure: k3441 
o|contracted procedure: k3444 
o|contracted procedure: k3447 
o|contracted procedure: k3460 
o|contracted procedure: k3464 
o|contracted procedure: k3468 
o|contracted procedure: k3472 
o|contracted procedure: k3475 
o|contracted procedure: k3478 
o|contracted procedure: k3481 
o|contracted procedure: k3484 
o|contracted procedure: k3487 
o|contracted procedure: k3490 
o|contracted procedure: k3493 
o|contracted procedure: k3496 
o|contracted procedure: k3499 
o|contracted procedure: k3518 
o|contracted procedure: k3522 
o|contracted procedure: k3534 
o|contracted procedure: k3538 
o|contracted procedure: k3555 
o|contracted procedure: k3595 
o|contracted procedure: k3591 
o|contracted procedure: k3561 
o|contracted procedure: k3587 
o|contracted procedure: k3570 
o|contracted procedure: k3583 
o|contracted procedure: k3576 
o|simplifications: ((##core#call . 26) (let . 56)) 
o|  call simplifications:
o|    scheme#+	26
o|removed binding forms: 333 
o|contracted procedure: k1331 
o|contracted procedure: k1352 
o|contracted procedure: k1513 
o|contracted procedure: k1458 
o|contracted procedure: k1517 
o|contracted procedure: k1560 
o|contracted procedure: k1669 
o|contracted procedure: k1766 
o|contracted procedure: k1833 
o|contracted procedure: k1907 
o|contracted procedure: k3526 
o|contracted procedure: k3530 
(o x)|known list op on rest arg sublist: ##core#rest-null? rest782 0 
(o x)|known list op on rest arg sublist: ##core#rest-cdr rest782 0 
(o x)|known list op on rest arg sublist: ##core#rest-car rest782 0 
(o x)|known list op on rest arg sublist: ##core#rest-car rest782 0 
o|removed binding forms: 12 
(o x)|known list op on rest arg sublist: ##core#rest-null? r3596 1 
o|removed binding forms: 1 
o|customizable procedures: (result-length791 va3725 va3723 loop799 doloop792793 store!741 swap!742 store!704 k2561 doloop595596 doloop586587 va3715 k2449 doloop562563 doloop557558 doloop527528 doloop499500 doloop494495 k1919 va3703 va3701 va3699 va3697 va3695 va3693 va3691 doloop355356 va3687 va3685 va3683 doloop326327 doloop321322 setter!292 loop295) 
o|calls to known targets: 69 
o|identified direct recursive calls: f_1253 1 
o|identified direct recursive calls: f_1285 1 
o|identified direct recursive calls: f_3388 1 
o|fast box initializations: 14 
*/
/* end of file */
