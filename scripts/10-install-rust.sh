#!/bin/bash -e

# keep latest and previous toolchains
RUST_NIGHTLY_TOOLCHAINS=nightly-2026-04-28,nightly-2026-10-14
RUST_STABLE_TOOLCHAINS=1.98.0

RUST_DEFAULT_TOOLCHAIN=1.98.0

RUST_TARGETS=riscv32imc-unknown-none-elf,riscv32imac-unknown-none-elf,thumbv6m-none-eabi,thumbv7m-none-eabi,thumbv7em-none-eabi,thumbv7em-none-eabihf,thumbv8m.main-none-eabi,thumbv8m.main-none-eabihf
RUST_COMPONENTS=rust-src,rustfmt,llvm-tools
RUST_PROFILE=minimal

RUST_TOOLCHAINS="${RUST_NIGHTLY_TOOLCHAINS},${RUST_STABLE_TOOLCHAINS}"
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
IFS=',' read -ra toolchains <<< "${RUST_TOOLCHAINS}"
for toolchain in "${toolchains[@]}"; do
  rustup toolchain install "${toolchain}" --target ${RUST_TARGETS} --component ${RUST_COMPONENTS} --profile ${RUST_PROFILE} --no-self-update
done

rustup default ${RUST_DEFAULT_TOOLCHAIN}

export CARGO_BUILD_BUILD_DIR=/cache/cargo
