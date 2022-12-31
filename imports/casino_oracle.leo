program casino_oracle.aleo {
    record CasinoTableSeatVoucher {
        owner: address,
        gates: u64,
        nonce: group,
        dealer: address,
        player: address,
        random_seed: u64,
    }

    transition claim(random_seed: u64, nonce: group, dealer: address) -> (CasinoTableSeatVoucher, CasinoTableSeatVoucher) {
        return (CasinoTableSeatVoucher {
            owner: self.caller,
            gates: 0u64,
            nonce,
            dealer,
            player: self.caller,
            random_seed,
        }, CasinoTableSeatVoucher {
            owner: aleo1s2hkr9nw7vp2vrlfzewwluqqfg8pfykcffm9gx90qmhk8vrj7urqum9yqn,
            gates: 0u64,
            nonce,
            dealer,
            player: self.caller,
            random_seed,
        });
    }
}