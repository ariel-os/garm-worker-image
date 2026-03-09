export ESPUP_VERSION=0.16.0
export RUST_XTENSA_TOOLCHAIN_VERSION=1.94.0.0
export RUST_XTENSA_TARGETS=esp32s3,esp32s2,esp32

cargo +${RUST_TOOLS_TOOLCHAIN} binstall espup@${ESPUP_VERSION} --no-confirm --locked
espup install -v ${RUST_XTENSA_TOOLCHAIN_VERSION} --targets ${RUST_XTENSA_TARGETS}

# export-esp.sh is expected to be found in the current user's home directory
cp /root/export-esp.sh /home/runner/export-esp.sh
