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
    )
)
