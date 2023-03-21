//! # Armstrong Number Algorithm.

// Core library imports.
use array::ArrayTrait;
use option::OptionTrait;
// Internal imports.
use quaireaux::utils;

/// Armstrong Number Algorithm.
/// # Arguments
/// * `num` - The number to be evaluated.
/// # Returns
/// * `bool` - A boolean value indicating is Armstrong Number.
fn is_armstrong_number(num: felt252) -> bool {
    _is_armstrong_number(num, num, utils::count_digits_of_base(num, 10))
}

/// Recursive helper function for 'is_armstrong_number'.
/// # Arguments
/// * `num` - The current value being evaluated in the recursive loop.
/// * `original_num` - The original number .
/// * `digits` - The number of digits.
/// # Returns
/// * `bool` - A boolean value indicating is Armstrong Number.
fn _is_armstrong_number(num: felt252, original_num: felt252, digits: felt252) -> bool {
    utils::check_gas();

    if num == 0 {
        return original_num == 0;
    } else {
        let (new_num, lastDigit) = utils::unsafe_euclidean_div(num, 10);
        let sum = utils::pow(lastDigit, digits);
        return _is_armstrong_number(new_num, original_num - sum, digits);
    }
}
