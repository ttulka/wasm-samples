(module
  (memory $m 1)
  (export "mem" (memory $m))
  (data (i32.const 0) "Hello")
  
  (func (export "dataLength") 
        (result i32)
    i32.const 5  ;; data length
    return))
