echo "Installing Ariel OS build deps"

export DEBIAN_FRONTEND=noninteractive
apt-get -y install --no-install-recommends \
	ninja-build gcc-arm-none-eabi gcc-riscv64-unknown-elf

# binstall
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

# sccache
cargo binstall sccache --force

echo 'SCCACHE_DIR=/cache/sccache' >> $GITHUB_ENV
echo 'SCCACHE_CACHE_SIZE=128G' >> $GITHUB_ENV

# laze
cargo binstall laze

# git-cache
cargo binstall git-cache
cargo install --git https://github.com/kaspar030/git-cache-daemon

mv $(which git-cache) /usr/local/bin
mv $(which git-cache-daemon) /usr/local/bin

cp /scripts/git-cache.service /etc/systemd/system
systemctl enable git-cache.service
systemctl start git-cache.service
git config --system url.git://localhost/.insteadof https://

# TODO: restrict to git-cache-daemon
git config --system --add safe.directory '*'

echo 'GIT_CACHE_DIR=/cache/gitcache' >> $GITHUB_ENV
