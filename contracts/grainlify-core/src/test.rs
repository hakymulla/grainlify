#![cfg(test)]

use super::*;
use soroban_sdk::{Env, testutils::{Address as _}, Address};

#[test]
fn test_init_and_version() {
    let env = Env::default();
    let contract_id = env.register_contract(None, GrainlifyContract);
    let client = GrainlifyContractClient::new(&env, &contract_id);

    let admin = Address::generate(&env);
    client.init(&admin);

    assert_eq!(client.get_version(), 1);
}
