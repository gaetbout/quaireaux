use array::ArrayTrait;
use array::SpanTrait;

use quaireaux::data_structures::array_search::ArraySearchExt;
use quaireaux::data_structures::array_search::ArrayMinMaxExt;

#[test]
#[available_gas(2000000)]
fn contains() {
    let mut arr = get_felt252_array();
    assert(arr.contains(21), 'Should contain 21');
    assert(arr.contains(42), 'Should contain 42');
    assert(arr.contains(84), 'Should contain 84');
    assert(arr.len() == 3_usize, 'arr should not be consummed');
}

#[test]
#[available_gas(2000000)]
fn contains_different_type() {
    let mut arr = get_u128_array();
    assert(arr.contains(21_u128), 'Should contain 21_u128');
    assert(arr.contains(42_u128), 'Should contain 42_u128');
    assert(arr.contains(84_u128), 'Should contain 84_u128');
    assert(arr.len() == 3_usize, 'arr should not be consummed');
}

#[test]
#[available_gas(2000000)]
fn contains_false() {
    let mut arr = get_felt252_array();
    assert(arr.contains(85) == false, 'Should be false');
    assert(arr.len() == 3_usize, 'arr should not be consummed');
}

#[test]
#[available_gas(2000000)]
fn contains_empty_array() {
    let mut arr = ArrayTrait::new();
    assert(arr.contains(85) == false, 'Should be false');
    assert(arr.len() == 0_usize, 'arr should not be consummed');
}

#[test]
#[available_gas(2000000)]
fn index_of() {
    let mut arr = get_felt252_array();
    assert(arr.index_of(21) == 0_usize, 'Index should be 0');
    assert(arr.index_of(42) == 1_usize, 'Index should be 1');
    assert(arr.index_of(84) == 2_usize, 'Index should be 2');
    assert(arr.len() == 3_usize, 'arr should not be consummed');
}

#[test]
#[available_gas(2000000)]
fn index_of_different_type() {
    let mut arr = get_u128_array();
    assert(arr.index_of(21_u128) == 0_usize, 'Index should be 0');
    assert(arr.index_of(42_u128) == 1_usize, 'Index should be 1');
    assert(arr.index_of(84_u128) == 2_usize, 'Index should be 2');
    assert(arr.len() == 3_usize, 'arr should not be consummed');
}

#[test]
#[available_gas(2000000)]
#[should_panic(expected = ('Item not in array', ))]
fn index_of_panic() {
    let mut arr = get_felt252_array();
    arr.index_of(12);
}

#[test]
#[available_gas(2000000)]
#[should_panic(expected = ('Item not in array', ))]
fn index_of_empty_array() {
    let mut arr = ArrayTrait::new();
    arr.index_of(21);
}

#[test]
#[available_gas(2000000)]
fn occurrences_of() {
    let mut arr = get_felt252_array();
    assert(arr.occurrences_of(21) == 1_usize, 'Should contain 21 exactly once');
    assert(arr.occurrences_of(42) == 1_usize, 'Should contain 42 exactly once');
    assert(arr.occurrences_of(84) == 1_usize, 'Should contain 84 exactly once');
    assert(arr.len() == 3_usize, 'arr should not be consummed');
}

#[test]
#[available_gas(2000000)]
fn occurrences_of_different_type() {
    let mut arr = get_u128_array();
    assert(arr.occurrences_of(21_u128) == 1_usize, 'Should contain 21 exactly once');
    assert(arr.occurrences_of(42_u128) == 1_usize, 'Should contain 42 exactly once');
    assert(arr.occurrences_of(84_u128) == 1_usize, 'Should contain 84 exactly once');
    assert(arr.len() == 3_usize, 'arr should not be consummed');
}

#[test]
#[available_gas(2000000)]
fn occurrences_of_not_in_array() {
    let mut arr = get_felt252_array();
    assert(arr.occurrences_of(12) == 0_usize, 'Should contain exactly once');
    assert(arr.len() == 3_usize, 'arr should not be consummed');
}

#[test]
#[available_gas(2000000)]
fn occurrences_of_empty_array() {
    let mut arr = ArrayTrait::new();
    assert(arr.occurrences_of(12) == 0_usize, 'Should contain exactly 0');
    assert(arr.len() == 0_usize, 'arr should not be consummed');
}


#[test]
#[available_gas(2000000)]
fn occurrences_of_double() {
    let mut arr = ArrayTrait::new();
    arr.append(21);
    arr.append(21);
    arr.append(84);
    assert(arr.occurrences_of(21) == 2_usize, 'Should contain exactly 2');
    assert(arr.len() == 3_usize, 'arr should not be consummed');
}

#[test]
#[available_gas(2000000)]
fn occurrences_of_filled() {
    let mut arr = ArrayTrait::new();
    arr.append(21);
    arr.append(21);
    arr.append(21);
    assert(arr.occurrences_of(21) == 3_usize, 'Should contain exactly 3');
    assert(arr.len() == 3_usize, 'arr should not be consummed');
}

#[test]
#[available_gas(2000000)]
fn min() {
    let mut arr = get_u128_array();
    assert(arr.min() == 21_u128, 'Min should be 21');
    assert(arr.len() == 3_usize, 'arr should not be consummed');
}

#[test]
#[available_gas(2000000)]
fn min_step_one() {
    let mut arr = get_u128_array();
    arr.append(20_u128);
    assert(arr.min() == 20_u128, 'Min should be 20');
    assert(arr.len() == 4_usize, 'arr should not be consummed');
}

#[test]
#[available_gas(2000000)]
fn min_with_duplicate() {
    let mut arr = get_u128_array();
    arr.append(21_u128);
    assert(arr.min() == 21_u128, 'Min should be 21');
    assert(arr.len() == 4_usize, 'arr should not be consummed');
}

#[test]
#[available_gas(2000000)]
#[should_panic(expected = ('Empty array', ))]
fn min_empty_array() {
    let mut arr: Array<u128> = ArrayTrait::new();
    arr.min();
}

#[test]
#[available_gas(2000000)]
fn min_one_item() {
    let mut arr = ArrayTrait::new();
    arr.append(21_u128);
    assert(arr.min() == 21_u128, 'Min should be 21');
    assert(arr.len() == 1_usize, 'arr should not be consummed');
}

#[test]
#[available_gas(2000000)]
fn min_last() {
    let mut arr = ArrayTrait::new();
    arr.append(84_u128);
    arr.append(42_u128);
    arr.append(21_u128);
    assert(arr.min() == 21_u128, 'Min should be 21');
    assert(arr.len() == 3_usize, 'arr should not be consummed');
}

#[test]
#[available_gas(2000000)]
fn index_of_min() {
    let mut arr = get_u128_array();
    assert(arr.index_of_min() == 0_usize, 'index_of_min should be 0');
    assert(arr.len() == 3_usize, 'arr should not be consummed');
}

#[test]
#[available_gas(2000000)]
fn index_of_min_step_one() {
    let mut arr = get_u128_array();
    arr.append(20_u128);
    assert(arr.index_of_min() == 3_usize, 'index_of_min should be 3');
    assert(arr.len() == 4_usize, 'arr should not be consummed');
}

#[test]
#[available_gas(2000000)]
fn index_of_min_with_duplicate() {
    let mut arr = get_u128_array();
    arr.append(21_u128);
    assert(arr.index_of_min() == 0_usize, 'index_of_min should be 0');
    assert(arr.len() == 4_usize, 'arr should not be consummed');
}

#[test]
#[available_gas(2000000)]
#[should_panic(expected = ('Empty array', ))]
fn index_of_min_empty_array() {
    let mut arr: Array<u128> = ArrayTrait::new();
    arr.index_of_min();
}

#[test]
#[available_gas(2000000)]
fn index_of_min_one_item() {
    let mut arr = ArrayTrait::new();
    arr.append(21_u128);
    assert(arr.index_of_min() == 0_usize, 'index_of_min should be 0');
    assert(arr.len() == 1_usize, 'arr should not be consummed');
}

#[test]
#[available_gas(2000000)]
fn index_of_min_last() {
    let mut arr = ArrayTrait::new();
    arr.append(84_u128);
    arr.append(42_u128);
    arr.append(21_u128);
    assert(arr.index_of_min() == 2_usize, 'index_of_min should be 2');
    assert(arr.len() == 3_usize, 'arr should not be consummed');
}

#[test]
#[available_gas(2000000)]
fn max() {
    let mut arr = get_u128_array();
    assert(arr.max() == 84_u128, 'Max should be 84');
    assert(arr.len() == 3_usize, 'arr should not be consummed');
}

#[test]
#[available_gas(2000000)]
fn max_step_one() {
    let mut arr = get_u128_array();
    arr.append(85_u128);
    assert(arr.max() == 85_u128, 'Max should be 85');
    assert(arr.len() == 4_usize, 'arr should not be consummed');
}

#[test]
#[available_gas(2000000)]
fn max_with_duplicate() {
    let mut arr = get_u128_array();
    arr.append(84_u128);
    assert(arr.max() == 84_u128, 'Max should be 84');
    assert(arr.len() == 4_usize, 'arr should not be consummed');
}

#[test]
#[available_gas(2000000)]
#[should_panic(expected = ('Empty array', ))]
fn max_empty_array() {
    let mut arr: Array<u128> = ArrayTrait::new();
    arr.max();
}

#[test]
#[available_gas(2000000)]
fn max_one_item() {
    let mut arr = ArrayTrait::new();
    arr.append(21_u128);
    assert(arr.max() == 21_u128, 'Max should be 21');
    assert(arr.len() == 1_usize, 'arr should not be consummed');
}

#[test]
#[available_gas(2000000)]
fn max_first() {
    let mut arr = ArrayTrait::new();
    arr.append(84_u128);
    arr.append(42_u128);
    arr.append(21_u128);
    assert(arr.max() == 84_u128, 'Max should be 84');
    assert(arr.len() == 3_usize, 'arr should not be consummed');
}

#[test]
#[available_gas(2000000)]
fn index_of_max() {
    let mut arr = get_u128_array();
    assert(arr.index_of_max() == 2_usize, 'index_of_max should be 2');
    assert(arr.len() == 3_usize, 'arr should not be consummed');
}

#[test]
#[available_gas(2000000)]
fn index_of_max_step_one() {
    let mut arr = get_u128_array();
    arr.append(85_u128);
    assert(arr.index_of_max() == 3_usize, 'index_of_max should be 3');
    assert(arr.len() == 4_usize, 'arr should not be consummed');
}

#[test]
#[available_gas(2000000)]
fn index_of_max_with_duplicate() {
    let mut arr = get_u128_array();
    arr.append(84_u128);
    assert(arr.index_of_max() == 2_usize, 'index_of_max should be 2');
    assert(arr.len() == 4_usize, 'arr should not be consummed');
}

#[test]
#[available_gas(2000000)]
#[should_panic(expected = ('Empty array', ))]
fn index_of_max_empty_array() {
    let mut arr: Array<u128> = ArrayTrait::new();
    arr.index_of_max();
}

#[test]
#[available_gas(2000000)]
fn index_of_max_one_item() {
    let mut arr = ArrayTrait::new();
    arr.append(21_u128);
    assert(arr.index_of_max() == 0_usize, 'index_of_max should be 0');
    assert(arr.len() == 1_usize, 'arr should not be consummed');
}

#[test]
#[available_gas(2000000)]
fn index_of_max_last() {
    let mut arr = ArrayTrait::new();
    arr.append(84_u128);
    arr.append(42_u128);
    arr.append(21_u128);
    assert(arr.index_of_max() == 0_usize, 'index_of_max should be 0');
    assert(arr.len() == 3_usize, 'arr should not be consummed');
}


// Utility fn
fn get_felt252_array() -> Array<felt252> {
    let mut arr = ArrayTrait::new();
    arr.append(21);
    arr.append(42);
    arr.append(84);
    arr
}

fn get_u128_array() -> Array<u128> {
    let mut arr = ArrayTrait::new();
    arr.append(21_u128);
    arr.append(42_u128);
    arr.append(84_u128);
    arr
}
