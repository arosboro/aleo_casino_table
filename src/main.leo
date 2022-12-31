import casino_table_seat.leo;
import casino_table_seat_player.leo;
import casino_oracle.leo;

// The 'aleo_casino_table' program.
program aleo_casino_table.aleo {

    record Table {
        owner: address,
        gates: u64,
        seats: u8,
        dealer: address,
    }

    mapping table_count: address => u64;

    transition main(random_seed: u64, p01: address, p02: address, p03: address, p04: address, p05: address, p06: address, p07: address) -> (Table, Table, Table, Table, Table, Table, Table, Table) {
        let burn_address: address = aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc;
        let seats: u8 = 1u8;
        if p01 != burn_address {
            seats += 1u8;
        }
        if p02 != burn_address {
            seats += 1u8;
        }
        if p03 != burn_address {
            seats += 1u8;
        }
        if p04 != burn_address {
            seats += 1u8;
        }
        if p05 != burn_address {
            seats += 1u8;
        }
        if p06 != burn_address {
            seats += 1u8;
        }
        if p07 != burn_address {
            seats += 1u8;
        }

        return (Table {
            owner: self.caller,
            gates: 0u64,
            seats,
            dealer: self.caller,
        }, Table {
            owner: p01,
            gates: 0u64,
            seats,
            dealer: self.caller,
        }, Table {
            owner: p02,
            gates: 0u64,
            seats,
            dealer: self.caller,
        }, Table {
            owner: p03,
            gates: 0u64,
            seats,
            dealer: self.caller,
        }, Table {
            owner: p04,
            gates: 0u64,
            seats,
            dealer: self.caller,
        }, Table {
            owner: p05,
            gates: 0u64,
            seats,
            dealer: self.caller,
        }, Table {
            owner: p06,
            gates: 0u64,
            seats,
            dealer: self.caller,
        }, Table {
            owner: p07,
            gates: 0u64,
            seats,
            dealer: self.caller,
        }) then finalize(self.caller, p01, p02, p03, p04, p05, p06, p07);
    }

    finalize main(p00: address, p01: address, p02: address, p03: address, p04: address, p05: address, p06: address, p07: address) {
        assert(p00 == self.caller);
        let burn_address: address = aleo1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq3ljyzc;
        if p00 != burn_address {
            increment(table_count, p00, 1u64);
        }
        if p01 != burn_address {
            increment(table_count, p01, 1u64);
        }
        if p02 != burn_address {
            increment(table_count, p02, 1u64);
        }
        if p03 != burn_address {
            increment(table_count, p03, 1u64);
        }
        if p04 != burn_address {
            increment(table_count, p04, 1u64);
        }
        if p05 != burn_address {
            increment(table_count, p05, 1u64);
        }
        if p06 != burn_address {
            increment(table_count, p06, 1u64);
        }
        if p07 != burn_address {
            increment(table_count, p07, 1u64);
        }
    }

    transition sit_down(table: Table, random_seed: u64) -> (casino_table_seat.leo/CasinoTableSeat) {
        let dealer: address = table.dealer;
        return casino_table_seat.leo/sit(dealer, random_seed);
    }

    transition ready_up(seat: casino_table_seat.leo/CasinoTableSeat.record, nonce: group, random_seed: u64) -> (casino_oracle.leo/CasinoTableSeatVoucher.record, casino_oracle.leo/CasinoTableSeatVoucher.record, casino_table_seat_player.leo/CasinoTableSeatPlayer) {
        assert(self.caller == seat.owner && seat.owner == seat.player);
        let random_seed_hash: field = Poseidon8::hash(random_seed);
        assert(seat.random_seed_hash == random_seed_hash);
        let (player_record, oracle_record): (CasinoTableSeatVoucher, CasinoTableSeatVoucher) = casino_oracle.leo/claim(random_seed, nonce, seat.dealer, );
        return (player_record, oracle_record, casino_table_seat_player.leo/ready(random_seed_hash, seat.dealer));
    }
}
