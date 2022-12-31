// The 'casino_table_seat' program.
program casino_table_seat.aleo {

    record CasinoTableSeat {
        owner: address,
        gates: u64,
        dealer: address,
        player: address,
        random_seed_hash: field,
    }

    transition sit(dealer: address, random_seed: u64) -> CasinoTableSeat {
        let random_seed_hash: field = Poseidon8::hash(random_seed);
        return CasinoTableSeat {
            owner: self.caller,
            gates: 0u64,
            dealer,
            player: self.caller,
            random_seed_hash,
        };
    }
}