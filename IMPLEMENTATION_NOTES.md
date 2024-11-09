## Error early

Always load with RTLD_NOW if possible so loading happens at start of program.

Always to to find the function when pffi-define is run, not when the function itself is run so
any errors will happen on the program start.
