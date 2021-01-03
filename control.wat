(module
  
  (func (export "control1")
        (result i32)
    i32.const -1
    if (result i32)
      i32.const 1      
    else
      i32.const 2
    end
    return)

  (func (export "control2")
        (result i32)
        (local $i i32)
        (local $n i32)
    i32.const 0
    local.set $i
    
    i32.const 42
    local.set $n

    loop
      local.get $i
      i32.const 1
      i32.add
      local.set $i

      local.get $n
      local.get $i
      i32.gt_s
      br_if 0
    end

    local.get $i
    return)

  (func $caller
        (export "control3")
        (result i32)
    i32.const 42
    call $callie)

  (func $callie
        (param $x i32)
        (result i32)
    local.get $x
    i32.const 1
    i32.add)
)