# IPFS tools

This repository contains pointers to various useful resources when using EUREC4A data over IPFS.
It is mainly intended to be used by other tools, not for direct consumption by users.

## add known peers to your local ipfs config

If you want to add known peers from this repository into your local IPFS node's config, you can run:

```
curl https://raw.githubusercontent.com/eurec4a/ipfs_tools/main/add_peers.sh | bash
```

The script requires `curl`, `jq`, and `yj`.
