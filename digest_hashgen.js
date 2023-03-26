const fs = require('fs');
const toml = require('toml');
const config = toml.parse(fs.readFileSync('./circuits/hash-gen/Verifier.toml', 'utf-8'));

const hexNums = config.return;
let digest = "";
for (const hexNum of hexNums) {
    const num = Number(hexNum);
    digest += num.toString(16).padStart(2, '0');
}
console.log(digest);