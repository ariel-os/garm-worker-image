#!/bin/bash -e

RUST_NIGHTLY_TOOLCHAIN=nightly-2025-10-28
RUST_STABLE_TOOLCHAIN=1.85.1
RUST_TARGETS=riscv32imc-unknown-none-elf,riscv32imac-unknown-none-elf,thumbv6m-none-eabi,thumbv7m-none-eabi,thumbv7em-none-eabi,thumbv7em-none-eabihf,thumbv8m.main-none-eabi,thumbv8m.main-none-eabihf
RUST_COMPONENTS=rust-src,rustfmt
RUST_PROFILE=minimal

# based on https://github.com/actions/runner-images/blob/main/images/ubuntu/scripts/build/install-rust.sh

source helpers/etc-environment.sh

export RUSTUP_HOME=/home/runner/.rustup
export CARGO_HOME=/home/runner/.cargo

curl -fsSL https://sh.rustup.rs | sh -s -- -y --default-toolchain=${RUST_TOOLS_TOOLCHAIN} --profile=minimal

# Initialize environment variables
source $CARGO_HOME/env

# Ensure they get reinitialized for the github runner user
# TODO: figure out how to use '$HOME'
prepend_etc_environment_path '/home/runner/.cargo/bin'

# Install common tools
rustup component add rustfmt clippy

# Install current ariel os stable rust
rustup toolchain install ${RUST_STABLE_TOOLCHAIN} --target ${RUST_TARGETS} --component ${RUST_COMPONENTS} --profile ${RUST_PROFILE} --no-self-update
rustup toolchain install ${RUST_NIGHTLY_TOOLCHAIN} --target ${RUST_TARGETS} --component ${RUST_COMPONENTS} --profile ${RUST_PROFILE} --no-self-update

rustup default ${RUST_STABLE_TOOLCHAIN}

export CARGO_BUILD_BUILD_DIR=/cache/cargo
