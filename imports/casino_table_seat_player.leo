// The 'casino_table_seat_player' program.
program casino_table_seat_player.aleo {

    record CasinoTableSeatPlayer {
        owner: address,
        gates: u64,
        player: address,
        random_seed_hash: field,
    }

    transition ready(random_seed_hash: field, dealer: address) -> CasinoTableSeatPlayer {
        return CasinoTableSeatPlayer {
            owner: dealer,
            gates: 0u64,
            player: self.caller,
            random_seed_hash,
        };
    }
}