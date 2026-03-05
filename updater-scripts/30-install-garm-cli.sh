export GARM_CLI_VERSION=v0.1.6

wget -q -O - https://github.com/cloudbase/garm/releases/download/${GARM_CLI_VERSION}/garm-cli-linux-amd64.tgz |  tar xzf - -C /usr/local/bin/
