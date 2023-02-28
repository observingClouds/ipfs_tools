#!/bin/bash
if (( $# != 1 )); then
    >&2 echo "usage: $0 <ipfs-version>"
    exit -1
fi

IPFS_VERSION=$1

wget https://dist.ipfs.io/go-ipfs/v${IPFS_VERSION}/go-ipfs_v${IPFS_VERSION}_linux-amd64.tar.gz
tar -xvzf go-ipfs_v${IPFS_VERSION}_linux-amd64.tar.gz
pushd go-ipfs
sudo bash install.sh
sudo sysctl -w net.core.rmem_max=2500000
popd
ipfs --version
ipfs init --profile server
curl https://raw.githubusercontent.com/observingClouds/ipfs_tools/new_peers/add_peers.sh | bash
touch ipfs.log  # ensure the file exists such that `tail` doesn't fail.
ipfs daemon 2>ipfs.log | grep -i -o -m1 'Daemon is ready' & tail -f --pid=$! ipfs.log
ipfs cat /ipfs/QmQPeNsJPyVWPFDVHb77w8G42Fvo15z4bG2X8D2GhfbSXc/readme
