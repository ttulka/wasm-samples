(module
  (func (export "Answer_to_the_Ultimate_Question") 
        (result i32)
    i32.const 42 
    return)

  (func (export "sum") 
        (param $a i32)
        (param $b i32)
        (result i32)
    local.get $a
    local.get $b
    i32.add
    return)

  (func (export "fac_loop")
        (param $n i32)
        (result i32)
        (local $i i32)
        (local $fac i32)
    i32.const 1
    local.set $fac
    i32.const 2
    local.set $i

    loop
      local.get $i
      local.get $fac
      i32.mul
      local.set $fac

      local.get $i
      i32.const 1
      i32.add
      local.set $i
      
      local.get $n
      local.get $i
      i32.ge_s
      br_if 0
    end

    local.get $fac
    return)

  (func $fac_rec
        (export "fac_rec")
        (param $n i32)
        (result i32)
    i32.const 1
    local.get $n
    i32.ge_s
    if (result i32)
      local.get $n     
    else
      local.get $n
      i32.const 1
      i32.sub
      call $fac_rec
      local.get $n
      i32.mul
    end
    return)
)
