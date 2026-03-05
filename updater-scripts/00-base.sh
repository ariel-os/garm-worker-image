
echo "Updating system..."
export DEBIAN_FRONTEND=noninteractive
apt-get -y update && apt-get -y dist-upgrade
apt-get -y install --no-install-recommends \
	curl python3-requests tar jq zstd bzip2 unzip wget \
	clang ninja-build make gcc \
	git git-lfs
