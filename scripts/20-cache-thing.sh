# Install cache-thing, needs to run before the activation of git-cache

cargo +${RUST_TOOLS_TOOLCHAIN} install cache-thing --git https://github.com/nponsard/cache-thing.git --tag 0.3.0
