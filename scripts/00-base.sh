
# Used in 10-install-rust.sh and 11-ariel-prerequisites.sh
export RUST_TOOLS_TOOLCHAIN=1.90.0


echo "Updating system..."
export DEBIAN_FRONTEND=noninteractive
apt-get -y update && apt-get -y dist-upgrade
apt-get -y install --no-install-recommends \
		curl python3-requests tar jq zstd bzip2 unzip \
		clang ninja-build make gcc \
		pkg-config libssl-dev \
		zfsutils btrfs-progs cgroupfs-mount \
		git git-lfs
