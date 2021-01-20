const fs = require("fs");
const loader = require("@assemblyscript/loader");
const wasm = loader.instantiateSync(fs.readFileSync(__dirname + "/build/optimized.wasm"), { 
  "index": {
    log: function(value) {
        console.log(value);
    },
    logstr: function(value) {
        console.log(wasm.exports.__getString(value));
    }
  }
});

console.log(loader);

console.log(wasm.instance.exports.add(2,3));
wasm.exports.main();
wasm.exports.hello();