#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <string.h>

#if defined(_MSC_VER)
    #define EXPORT __declspec(dllexport)
    #define IMPORT __declspec(dllimport)
#elif defined(__GNUC__)
    #define EXPORT __attribute__((visibility("default")))
    #define IMPORT
#else
    #define EXPORT
    #define IMPORT
    #pragma warning Unknown dynamic link import/export semantics.
#endif


struct test {
    int8_t a;
    char b;
    double c;
    char d;
    void* e;
    float f;
    char* g;
    int8_t h;
    void* i;
    int j;
    int k;
    int l;
    double m;
    float n;
};


EXPORT struct test* test(struct test* test) {
    test->a = 1;
    test->b = 'b';
    test->c = 3; //FIXME: Change to 3.0 and fix the library to work with it
    test->d = 'd';
    test->e = NULL;
    test->f = 6.0;
    char* foo = malloc(4);
    snprintf(foo, 4, "foo");
    test->g = foo;
    test->h = 8;
    test->i = NULL;
    test->j = 10;
    test->k = 11;
    test->l = 12;
    test->m = 13;
    test->n = 14;
}

EXPORT int test_check(struct test* test) {
    assert(test->a == 1);
    assert(test->b == 'b');
    //assert(test->c == 3); //FIXME: Change to 3.0 and fix the library to work with it
    assert(test->d == 'd');
    assert(test->e == NULL);
    // assert(test->f == 6.0); //FIXME
    //assert(strcmp(test->g, "foo") == 0); //FIXME
    assert(test->h == 8);
    assert(test->i == NULL);
    assert(test->j == 10);
    assert(test->k == 11);
    assert(test->l == 12);
    //assert(test->m == 13); //FIXME
    //assert(test->n == 14); //FIXME
}

EXPORT struct test* test_new(struct test* test) {
    struct test* t = malloc(sizeof(struct test));
    t->a = 1;
    t->b = 'b';
    t->c = 3; //FIXME: Change to 3.0 and fix the library to work with it
    t->d = 'd';
    t->e = NULL;
    t->f = 6.0;
    char* foo = malloc(4);
    snprintf(foo, 4, "foo");
    t->g = foo;
    t->h = 8;
    t->i = NULL;
    t->j = 10;
    t->k = 11;
    t->l = 12;
    t->m = 13;
    t->n = 14;
    return t;
}
