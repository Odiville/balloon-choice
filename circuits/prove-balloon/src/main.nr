use dep::std;

// Balloon orderings are tokenIDs of the balloon NFTs: 3,4,5,6
// If the VRF contract was to spit out 0, the balloon picked would be 0th ordering, etc.
// balloon_to_reveal should be the token ID of the balloon that is revealed
fn main(balloon_ordering: [u8; 4], salt: [u8; 16], vrf_chosen: pub Field, input_hash: pub [u8; 32], balloon_to_reveal: pub u8) -> pub bool {
    verify_hash(balloon_ordering, salt, input_hash);
    constrain (balloon_to_reveal == 3) | (balloon_to_reveal == 4) | (balloon_to_reveal == 5) | (balloon_to_reveal == 6);
    // Can't index an array with a non-comptime Field, so instead
    // let balloon_picked = balloon_ordering[vrf_chosen];
    let mut balloon_picked = 9999;
    for i in 0..4 {
        if i == vrf_chosen {
            balloon_picked = balloon_ordering[i];
        }
    }
    constrain balloon_picked != 9999;
    // If balloon_to_reveal is the same as the balloon picked (to be popped), the result is true
    // Otherwise its false
    balloon_picked == balloon_to_reveal
}

fn verify_hash(balloon_ordering: [u8; 4], salt: [u8; 16], input_hash: [u8; 32]) {
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
    let sha = std::hash::sha256(sha_bytes);
    
    constrain sha == input_hash;
}