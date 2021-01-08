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

  (func $main (export "_start") (local $i i32) (local $continue i32)

    ;; memory structure:
    ;;  0 | nread/nwritten
    ;;  4 | *iovs
    ;;  8 | iovs_len
    ;; 12 | data space

    ;; memory space to read into
    (i32.store (i32.const 4) (i32.const 12))
    (i32.store (i32.const 8) (i32.const 1))   ;; buffer of 1 char max

    (local.set $i (i32.const 12))

    loop
      (call $fd_read
        (i32.const 0) ;; 0 for stdin
        (i32.const 4) ;; *iovs
        (i32.const 1) ;; iovs_len
        (i32.const 0) ;; nread
      )
      drop

      (local.set $continue
        (i32.ne (i32.const 10)
                (i32.load (local.get $i))))

      (local.set $i (i32.add (local.get $i) (i32.const 1)))
      (i32.store (i32.const 4) (local.get $i))
      
      (br_if 0 (local.get $continue))
    end

    (i32.store (i32.const 4) (i32.const 12))
    (i32.store (i32.const 8) (i32.sub (local.get $i) (i32.const 13)))
    
    (call $fd_write
      (i32.const 1) ;; 1 for stdout
      (i32.const 4) ;; *iovs 
      (i32.const 1) ;; iovs_len
      (i32.const 0) ;; nwritten
    )
    drop
  )
)