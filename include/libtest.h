void print_string_pointer(char* p);
void print_offsets();
void check_offset(int member_index, int offset);
struct test* init_struct(struct test* test);
struct color {
    int8_t r;
    int8_t g;
    int8_t b;
    int8_t a;
};
int color_check(struct color* test);
int color_check_by_value(struct color color);
int test_check(struct test* test);
int test_check_by_value(struct test test);
struct test* test_new();
void takes_no_args();
int takes_no_args_returns_int();
