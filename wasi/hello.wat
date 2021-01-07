(module
  (import "wasi_unstable" "fd_write" 
    (func $fd_write (param i32 i32 i32 i32) 
                    (result i32)))

  (memory 1)
  (export "memory" (memory 0))

  (data (i32.const 8) "hello\n")

  (func $main (export "_start")
    ;; Creating a new io vector within linear memory
    ;;; store 8 (index of data in memory) onto position 0 in memory
    (i32.store (i32.const 0) (i32.const 8))  ;; iov.iov_base - This is a pointer to the start of the 'hello\n' string
    ;;; store 5 (legth of "hello\n" data) onto position 4
    (i32.store (i32.const 4) (i32.const 6))  ;; iov.iov_len - The length of the 'hello\n' string

    ;;; the code above could be written on the level of the module:
    ;; (data (i32.const 0) (i32.const 8))
    ;; (data (i32.const 4) (i32.const 5))
    ;; (data (i32.const 8) "hello\n")

    ;; then, the memory array looks like:
    ;;; 0000 8   -- index of data (i32 ~ 32 bits to store an integer ~ 32/8 = 4 bytes)
    ;;; 0004 6   -- length of data (i32 ~ 32 bits to store an integer ~ 32/8 = 4 bytes)
    ;;; 0008 h
    ;;; 0008 e
    ;;; 0009 l
    ;;; 000a l
    ;;; 000b o
    ;;; 000c \n
    ;;; etc...

    (call $fd_write
        (i32.const 1) ;; file_descriptor - 1 for stdout
        (i32.const 0) ;; *iovs - The pointer to the iov vector, which is stored at memory location 0
        (i32.const 1) ;; iovs_len - We're printing 1 string stored in an iov - so one.
        (i32.const 14) ;; nwritten - A place in memory to store the number of bytes written, 8+6=14
    )
    drop ;; Discard the number of bytes written from the top of the stack
  )
)