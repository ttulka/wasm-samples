(module
  (import "js" "simplelog" 
    (func $simplelog (param i32)))

  (import "js" "log" 
    (func $log (param i32 i32)))

  (import "js" "mem" (memory 1))
  (data (i32.const 0) "Hello")

  (global $g2 (import "js" "glob") (mut i32))
  
  (global $g1 (mut i32) (i32.const 42))
  
  (func (export "simplelog")
    i32.const 42
    call $simplelog)

  (func (export "log")
    i32.const 0  ;; offset to log
    i32.const 5  ;; length to log
    call $log)

  (func (export "getGlobal1") 
        (result i32)
    (global.get $g1))

  (func (export "setGlobal1") 
        (param $value i32)
    local.get $value
    global.set $g1)

  (func (export "getGlobal2") 
        (result i32)
    (global.get $g2))

  (func (export "setGlobal2") 
        (param $value i32)
    local.get $value
    global.set $g2)
)
