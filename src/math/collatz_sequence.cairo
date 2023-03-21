//! # Collatz Sequence

// Core library imports.
use option::OptionTrait;
use array::ArrayTrait;
// Internal imports.
use quaireaux::utils;

/// Generates the Collatz sequence for a given number.
/// # Arguments
/// * `number` - The number to generate the Collatz sequence for.
/// # Returns
/// * `Array` - The Collatz sequence as an array of `felt252` numbers.
fn sequence(number: felt252) -> Array::<felt252> {
    let mut arr = ArrayTrait::new();
    if number == 0 {
        return arr;
    }
    _sequence(number, arr)
}

/// Recursive helper function for sequence.
/// # Arguments
/// * `number` - The number to generate the Collatz sequence for.
/// * `arr` - An array to store the Collatz sequence that have been found.
/// # Returns
/// * `None` - This function does not return a value, it updates the arr argument in place.
fn _sequence(number: felt252, mut arr: Array::<felt252>) -> Array::<felt252> {
    utils::check_gas();

    arr.append(number);
    if number == 1 {
        return arr;
    } else {
        let (q, r) = utils::unsafe_euclidean_div(number, 2);
        if r == 0 {
            _sequence(q, arr)
        } else {
            _sequence(3 * number + 1, arr)
        }
    }
}
