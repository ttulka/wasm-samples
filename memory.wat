(module
  (import "js" "mem" (memory 1))
  (data (i32.const 0) "Hello")
  
  (func (export "memory1") 
        (result i32)
    i32.const 5  ;; length of data  
    return))
