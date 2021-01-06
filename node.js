const fs = require('fs');

WebAssembly
  .instantiate(fs.readFileSync('./hello.wasm'))
  .then(obj => console.log(obj.instance.exports.main()));


var mem = new WebAssembly.Memory({initial:1});
var glob = new WebAssembly.Global({value: "i32", mutable: true}, 2);

WebAssembly
  .instantiate(fs.readFileSync('browser.wasm'), { 
    js: { 
      mem,
      glob,
      simplelog: console.log,
      log: (offset, length) => decodeAndLog(mem, offset, length)
    } 
  })
  .then(({instance}) => {      
    instance.exports.simplelog();
    instance.exports.log();

    console.log('getGlobal1', instance.exports.getGlobal1());
    instance.exports.setGlobal1(12);
    console.log('getGlobal1', instance.exports.getGlobal1());

    console.log('getGlobal2', instance.exports.getGlobal2());
    glob.value = 3;
    console.log('getGlobal2', instance.exports.getGlobal2());
    instance.exports.setGlobal2(4);
    console.log('getGlobal2', instance.exports.getGlobal2());
  });

function decodeAndLog(memory, offset, length) {
  var bytes = new Uint8Array(memory.buffer, offset, length);
  var str = new TextDecoder('utf8').decode(bytes);
  
  console.log(str);
}