// Core library imports.
use option::OptionTrait;
use array::ArrayTrait;
use traits::Into;

use utils::array_slice;

#[test]
#[available_gas(2000000)]
fn array_slice_test() {
    let mut arr = ArrayTrait::<u256>::new();
    arr.append(1.into());
    arr.append(2.into());
    arr.append(3.into());

    let slice = array_slice(@arr, 0_usize, 2_usize);
    assert(slice.len() == 2_usize, 'invalid result');
    assert(*slice.at(0_usize) == 1.into(), 'invalid result');
    assert(*slice.at(1_usize) == 2.into(), 'invalid result');
}
