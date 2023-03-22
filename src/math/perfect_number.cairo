//! # Perfect Number.

// Core library imports.
use option::OptionTrait;
use array::ArrayTrait;

// Internal imports.
use quaireaux::utils;

/// Algorithm to determine if a number is a perfect number
/// # Arguments
/// * `num` - The number to be checked.
/// # Returns
/// * `bool` - True if num is a perfect number, false otherwise.
fn is_perfect_number(num: felt252) -> bool {
    _is_perfect_number(num, 1, 0)
}

/// Recursive helper function for is_perfect_number.
/// # Arguments
/// * `num` - The number to be evaluated as a perfect number.
/// * `index` - The index value being evaluated in the recursive loop.
/// * `sum` - The running sum of the divisors of num.
/// # Returns
/// * `bool` - A boolean value indicating whether num is a perfect number.
fn _is_perfect_number(num: felt252, index: felt252, sum: felt252) -> bool {
    utils::check_gas();

    if num == 0 {
        return false;
    }

    if num == 1 {
        return false;
    }

    if index == num - 1 {
        return num == sum;
    }

    let (_, r) = utils::unsafe_euclidean_div(num, index);
    if r == 0 {
        _is_perfect_number(num, index + 1, sum + index)
    } else {
        _is_perfect_number(num, index + 1, sum)
    }
}

/// Algorithm to determine all the perfect numbers up to a maximum value
/// # Arguments
/// * `max` - The maximum value to check for perfect numbers.
/// # Returns
/// * `Array` - An array of perfect numbers up to the max value.
fn perfect_numbers(ref max: felt252) -> Array::<felt252> {
    let mut res = ArrayTrait::new();
    let mut index = 1;
    _perfect_numbers(ref max, ref index, ref res);
    res
}

/// Recursive helper function for perfect_numbers.
/// # Arguments
/// * `max - The maximum value to check for perfect numbers.
/// * `index` - The index value being evaluated in the recursive loop.
/// * `arr` - An array to store the perfect numbers that have been found.
/// # Returns
/// * `None` - This function does not return a value, it updates the arr argument in place.
fn _perfect_numbers(ref max: felt252, ref index: felt252, ref arr: Array::<felt252>) {
    utils::check_gas();

    if index == max {
        return ();
    }
    if is_perfect_number(index) {
        arr.append(index);
    }
    update_step(ref index);
    _perfect_numbers(ref max, ref index, ref arr);
}

/// Update the step of the function _perfect_numbers.
fn update_step(ref index: felt252) {
    index = index + 1;
}
