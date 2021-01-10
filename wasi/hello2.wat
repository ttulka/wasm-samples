(module
  (import "wasi_unstable" "fd_write" 
    (func $fd_write (param i32 i32 i32 i32) 
                    (result i32)))

  (memory 1)
  (export "memory" (memory 0))

  (data (i32.const 16) "hello")
  (data (i32.const 22) "world")

  (func $main (export "_start")

    ;; Creating two new io vectors
    (i32.store (i32.const 0) (i32.const 16)) ;; iov_base
    (i32.store (i32.const 4) (i32.const 5))  ;; iov_len
    (i32.store (i32.const 8) (i32.const 22)) ;; iov_base
    (i32.store (i32.const 12) (i32.const 5)) ;; iov_len

    ;; Then, the memory array looks like:
    ;; 0000 16  -- index of "hello"
    ;; 0004 5   -- length of "hello"
    ;; 0008 22  -- index of "world"
    ;; 0008 5   -- length of "world"
    ;; 0009 h
    ;; 000a e
    ;; 000b l
    ;; 000c l
    ;; 000d o
    ;; 000e w
    ;; 000f o
    ;; 0010 r
    ;; 0011 l
    ;; 0012 d

    (call $fd_write
        (i32.const 1)  ;; file_descriptor - 1 for stdout
        (i32.const 0)  ;; *iovs - list of IO vectors starts on index 0
        (i32.const 2)  ;; iovs_len - we have two IO vectors (two strings)
        (i32.const 27) ;; nwritten - 22 + 5 = 27
    )
    drop
  )
)