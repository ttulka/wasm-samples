const fs = require("fs");
const loader = require("@assemblyscript/loader");
const imports = { 
  "index": {
    log: function(value) {
        console.log(value);
    }
  }
};
const wasm = loader.instantiateSync(fs.readFileSync(__dirname + "/build/optimized.wasm"), imports);
//module.exports = wasm.exports;

console.log(wasm.instance.exports.add(2,3));
wasm.exports.main();