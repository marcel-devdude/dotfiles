const crypto = require("crypto");

const length = Number(process.argv[2]) || 256;
const alg = process.argv[3] || "base64";

const possibleAlgs = ["base64", "hex"];

if (!possibleAlgs.includes(alg)) {
  console.error(
    `Invalid algorithm given. Possible values: ${possibleAlgs.join(", ")}`
  );
  process.exit(1);
}

console.log(crypto.randomBytes(length).toString(alg));
