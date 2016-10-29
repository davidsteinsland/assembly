#ifndef SYSCALLS_H
#define SYSCALLS_H

extern void put_char(char c);
extern int put_str(int len, char* str);
extern int put_strz(char* str);

extern int getpid(void);
extern void exit(int);

#endif
