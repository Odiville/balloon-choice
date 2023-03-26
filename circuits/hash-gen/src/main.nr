use dep::std;

fn main(balloon_ordering: [u8; 4], salt: [u8; 16]) -> pub [u8; 32] {
    let mut seen: [u8; 4] = [0; 4];
    for i in 0..4 {
        let balloon = balloon_ordering[i];
        constrain (balloon == 3) | (balloon == 4) | (balloon == 5) | (balloon == 6);
        for j in 0..i {
            constrain seen[j] != balloon;
        }
        seen[i] = balloon;
    }
    let mut sha_bytes: [u8; 20] = [0;20];
    for i in 0..4 {
        sha_bytes[i] = balloon_ordering[i];
    }
    for i in 0..16 {
        sha_bytes[i + 4] = salt[i];
    }
    std::hash::sha256(sha_bytes)
}