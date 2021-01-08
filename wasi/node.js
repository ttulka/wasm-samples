const fs = require('fs');
const { WASI } = require('wasi');

const wasmFilename = process.argv[2];

const wasi = new WASI({
  // args: process.argv,
  // env: process.env
});
const importObject = { 
  wasi_unstable: wasi.wasiImport
};

(async () => {
  const wasm = await WebAssembly
    .compile(fs.readFileSync(wasmFilename));

  const instance = await WebAssembly
    .instantiate(wasm, importObject);

  wasi.start(instance);
})();