echo '#define BOOTFILE "/home/xyh/.ikarus/lib/ikarus/ikarus.boot"' >bootfileloc.h
echo '#define EXEFILE "/home/xyh/.ikarus/bin/ikarus"' >>bootfileloc.h

gcc -DNDEBUG -DHAVE_CONFIG_H -I. -I..     -m64 -c -o ikarus-collect.o ikarus-collect.c
gcc -DNDEBUG -DHAVE_CONFIG_H -I. -I..     -m64 -c -o ikarus-exec.o ikarus-exec.c
gcc -DNDEBUG -DHAVE_CONFIG_H -I. -I..     -m64 -c -o ikarus-fasl.o ikarus-fasl.c
gcc -DNDEBUG -DHAVE_CONFIG_H -I. -I..     -m64 -c -o ikarus-flonums.o ikarus-flonums.c
gcc -DNDEBUG -DHAVE_CONFIG_H -I. -I..     -m64 -c -o ikarus-main.o ikarus-main.c
gcc -DNDEBUG -DHAVE_CONFIG_H -I. -I..     -m64 -c -o ikarus-numerics.o ikarus-numerics.c
gcc -DNDEBUG -DHAVE_CONFIG_H -I. -I..     -m64 -c -o ikarus-print.o ikarus-print.c
gcc -DNDEBUG -DHAVE_CONFIG_H -I. -I..     -m64 -c -o ikarus-runtime.o ikarus-runtime.c
gcc -DNDEBUG -DHAVE_CONFIG_H -I. -I..     -m64 -c -o ikarus-symbol-table.o ikarus-symbol-table.c
gcc -DNDEBUG -DHAVE_CONFIG_H -I. -I..     -m64 -c -o ikarus-verify-integrity.o ikarus-verify-integrity.c
gcc -DNDEBUG -DHAVE_CONFIG_H -I. -I..     -m64 -c -o ikarus-weak-pairs.o ikarus-weak-pairs.c
gcc -DNDEBUG -DHAVE_CONFIG_H -I. -I..     -m64 -c -o ikarus-winmmap.o ikarus-winmmap.c
gcc -DNDEBUG -DHAVE_CONFIG_H -I. -I..     -m64 -c -o ikarus-enter.o ikarus-enter.S
gcc -DNDEBUG -DHAVE_CONFIG_H -I. -I..     -m64 -c -o cpu_has_sse2.o cpu_has_sse2.S
gcc -DNDEBUG -DHAVE_CONFIG_H -I. -I..     -m64 -c -o ikarus-io.o ikarus-io.c
gcc -DNDEBUG -DHAVE_CONFIG_H -I. -I..     -m64 -c -o ikarus-process.o ikarus-process.c
gcc -DNDEBUG -DHAVE_CONFIG_H -I. -I..     -m64 -c -o ikarus-getaddrinfo.o ikarus-getaddrinfo.c
gcc -DNDEBUG -DHAVE_CONFIG_H -I. -I..     -m64 -c -o ikarus-errno.o ikarus-errno.c
gcc -DNDEBUG -DHAVE_CONFIG_H -I. -I..     -m64 -c -o ikarus-pointers.o ikarus-pointers.c
gcc -DNDEBUG -DHAVE_CONFIG_H -I. -I..     -m64 -c -o ikarus-ffi.o ikarus-ffi.c

gcc -DNDEBUG -DHAVE_CONFIG_H -I. -I..     -m64 -c -o ikarus.o ikarus.c

gcc -DNDEBUG -m64 -rdynamic -m64 -o ikarus ikarus-collect.o ikarus-exec.o ikarus-fasl.o ikarus-flonums.o ikarus-main.o ikarus-numerics.o ikarus-print.o ikarus-runtime.o ikarus-symbol-table.o ikarus-verify-integrity.o ikarus-weak-pairs.o ikarus-winmmap.o ikarus-enter.o cpu_has_sse2.o ikarus-io.o ikarus-process.o ikarus-getaddrinfo.o ikarus-errno.o ikarus-pointers.o ikarus-ffi.o ikarus.o  -lgmp -lpthread -lm -ldl

gcc -DNDEBUG -DHAVE_CONFIG_H -I. -I..     -m64 -c -o scheme-script.o scheme-script.c

gcc -DNDEBUG -m64 -rdynamic -m64 -o scheme-script ikarus-collect.o ikarus-exec.o ikarus-fasl.o ikarus-flonums.o ikarus-main.o ikarus-numerics.o ikarus-print.o ikarus-runtime.o ikarus-symbol-table.o ikarus-verify-integrity.o ikarus-weak-pairs.o ikarus-winmmap.o ikarus-enter.o cpu_has_sse2.o ikarus-io.o ikarus-process.o ikarus-getaddrinfo.o ikarus-errno.o ikarus-pointers.o ikarus-ffi.o scheme-script.o -lgmp -lpthread -lm -ldl
