use core::integer::{u512, u512_safe_div_rem_by_u256, u256_wide_mul};

/// Function that performs modular addition.
/// # Arguments
/// * `a` - Left hand side of addition.
/// * `b` - Right hand side of addition.
/// * `modulo` - modulo.
/// # Returns
/// * `u256` - result of modular addition
#[inline(always)]
pub fn add_mod(a: u256, b: u256, modulo: u256) -> u256 {
    let mod_non_zero: NonZero<u256> = modulo.try_into().unwrap();
    let low: u256 = a.low.into() + b.low.into();
    let high: u256 = a.high.into() + b.high.into();
    let carry: u256 = low.high.into() + high.low.into();
    let add_u512: u512 = u512 {
        limb0: low.low, limb1: carry.low, limb2: carry.high + high.high, limb3: 0
    };
    let (_, res) = u512_safe_div_rem_by_u256(add_u512, mod_non_zero);
    res
}

/// Function that return the modular multiplicative inverse. Disclaimer: this function should only be used with a prime modulo.
/// # Arguments
/// * `b` - Number of which to find the multiplicative inverse of. 
/// * `modulo` - modulo.
/// # Returns
/// * `u256` - modular multiplicative inverse
#[inline(always)]
pub fn mult_inverse(b: u256, modulo: u256) -> u256 {
    math::u256_inv_mod(b, modulo.try_into().expect('inverse non zero'))
        .expect('inverse non zero')
        .into()
}

/// Function that return the modular additive inverse.
/// # Arguments
/// * `b` - Number of which to find the additive inverse of.
/// * `modulo` - modulo.
/// # Returns
/// * `u256` - modular additive inverse
#[inline(always)]
pub fn add_inverse_mod(b: u256, modulo: u256) -> u256 {
    modulo - b
}

/// Function that performs modular subtraction.
/// # Arguments
/// * `a` - Left hand side of subtraction.
/// * `b` - Right hand side of subtraction.
/// * `modulo` - modulo.
/// # Returns
/// * `u256` - result of modular subtraction
#[inline(always)]
pub fn sub_mod(mut a: u256, mut b: u256, modulo: u256) -> u256 {
    // reduce values
    a = a % modulo;
    b = b % modulo;
    let (diff, overflow) = core::integer::u256_overflow_sub(a, b);
    if overflow {
        // Overflow back with add modulo
        let (diff, _) = core::integer::u256_overflowing_add(diff, modulo);
        diff
    } else {
        diff
    }
}

/// Function that performs modular multiplication.
/// # Arguments
/// * `a` - Left hand side of multiplication.
/// * `b` - Right hand side of multiplication.
/// * `modulo` - modulo.
/// # Returns
/// * `u256` - result of modular multiplication
#[inline(always)]
pub fn mult_mod(a: u256, b: u256, modulo: u256) -> u256 {
    let mult: u512 = u256_wide_mul(a, b);
    let mod_non_zero: NonZero<u256> = modulo.try_into().unwrap();
    let (_, rem_u256) = u512_safe_div_rem_by_u256(mult, mod_non_zero);
    rem_u256
}

/// Function that performs modular division.
/// # Arguments
/// * `a` - Left hand side of division.
/// * `b` - Right hand side of division.
/// * `modulo` - modulo.
/// # Returns
/// * `u256` - result of modular division
#[inline(always)]
pub fn div_mod(a: u256, b: u256, modulo: u256) -> u256 {
    let modulo_nz = modulo.try_into().expect('0 modulo');
    let inv = math::u256_inv_mod(b, modulo_nz).unwrap().into();
    math::u256_mul_mod_n(a, inv, modulo_nz)
}

/// Function that performs modular exponentiation.
/// # Arguments
/// * `base` - Base of exponentiation.
/// * `pow` - Power of exponentiation.
/// * `modulo` - modulo.
/// # Returns
/// * `u256` - result of modular exponentiation
pub fn pow_mod(mut base: u256, mut pow: u256, modulo: u256) -> u256 {
    let mut result: u256 = 1;
    let mod_non_zero: NonZero<u256> = modulo.try_into().unwrap();
    let mut mult: u512 = u512 { limb0: 0_u128, limb1: 0_u128, limb2: 0_u128, limb3: 0_u128 };

    while (pow != 0) {
        if ((pow & 1) > 0) {
            mult = u256_wide_mul(result, base);
            let (_, res_u256,) = u512_safe_div_rem_by_u256(mult, mod_non_zero);
            result = res_u256;
        }

        pow = pow / 2;

        mult = u256_wide_mul(base, base);
        let (_, base_u256) = u512_safe_div_rem_by_u256(mult, mod_non_zero);
        base = base_u256;
    };

    result
}
