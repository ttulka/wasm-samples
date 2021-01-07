(module
  (import "wasi_unstable" "fd_read" 
    (func $fd_read 
      (param i32 i32 i32 i32) 
      (result i32)))
  (import "wasi_unstable" "fd_write" 
    (func $fd_write 
      (param i32 i32 i32 i32) 
      (result i32)))

  (memory 1)
  (export "memory" (memory 0))

  (data (i32.const 8) "hello\n")

  (func $main (export "_start") (local $n i32)

    ;;  0 | nread/nwritten
    ;;  4 | *iovs
    ;;  8 | read iovs_len
    ;; 12 | data space

    ;; memory space to read into
    (i32.store (i32.const 4) (i32.const 12))
    (i32.store (i32.const 8) (i32.const 1))

    (call $fd_read
      (i32.const 0) ;; file_descriptor - 0 for stdin
      (i32.const 4) ;; *iovs - The pointer to the iov vector, which is stored at memory location 4
      (i32.const 1) ;; iovs_len - We're reading 1 string to an iov - so one.
      (i32.const 8) ;; nread - A place in memory to store the number of bytes read, 8+2=10
    )
    drop

    (call $fd_write
      (i32.const 1) ;; file_descriptor - 1 for stdout
      (i32.const 4) ;; *iovs - The pointer to the iov vector, which is stored at memory location 4
      (i32.const 1) ;; iovs_len - We're printing 1 string stored in an iov - so one.
      (i32.const 0) ;; nwritten - A place in memory to store the number of bytes written, 8+6=14
    )
    drop
  )
)