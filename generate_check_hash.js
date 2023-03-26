// The purpose of this is to generate a hash given the balloon orderings and a salt, 
// performed so it can be easily compared to what was generated by the zk circuit.

const fs = require('fs');
const toml = require('toml');
const crypto = require('crypto');
const prover = toml.parse(fs.readFileSync('./circuits/hash-gen/Prover.toml', 'utf-8'));
const verifier = toml.parse(fs.readFileSync('./circuits/hash-gen/Verifier.toml', 'utf-8'));

const balloonOrdering = prover.balloon_ordering;
const salt = prover.salt;

const arrayBuffer = new ArrayBuffer(20);
const view = new DataView(arrayBuffer);
for (let i = 0; i < balloonOrdering.length; i++) {
    view.setUint8(i, balloonOrdering[i]);
}
for (let i = 0; i < salt.length; i++) {
    view.setUint8(i + balloonOrdering.length, salt[i]);
}

const hash = crypto.createHash('sha256').update(view).digest('hex');
console.log("Generated hash");
console.log(hash);

const hexNums = verifier.return;
let digest = "";
for (const hexNum of hexNums) {
    const num = Number(hexNum);
    digest += num.toString(16).padStart(2, '0');
}
console.log("Digest hash");
console.log(digest);

console.log("Match?");
console.log(hash === digest);