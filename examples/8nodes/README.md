# 8 nodes

Following the same steps from 7nodes, we configure the 8th node from scratch.

See:

https://github.com/jpmorganchase/quorum/issues/48

https://github.com/jpmorganchase/quorum/issues/153

https://github.com/jpmorganchase/quorum/blob/master/docs/running.md#setup-bootnode

https://ethereum.stackexchange.com/questions/30644/quorum-generating-public-key-for-a-given-address

## The 8th node

### Generate nodekey
$ bootnode -genkey nodekey8

$ mv nodekey8 raft/

$ bootnode -nodekey raft/nodekey8

INFO [03-12|00:22:03] UDP listener up                          self=enode://7551a69f7d83003c34b7c21e2e3fb14cc9ec069279479551c1f007a1f5e9a9ece7ce1585370dec26108012a4aec87da53ff87a5101ecdf86f2a8405f2cd7d86c@[::]:30301

### Add enode
Append the enode and increment its port numbers to permissioned-nodes.json :
"enode://239c1f044a2b03b6c4713109af036b775c5418fe4ca63b04b1ce00124af00ddab7cc088fc46020cdc783b6207efe624551be4c06a994993d8d70f684688fb7cf@127.0.0.1:21006?discport=0&raftport=50407",

"enode://7551a69f7d83003c34b7c21e2e3fb14cc9ec069279479551c1f007a1f5e9a9ece7ce1585370dec26108012a4aec87da53ff87a5101ecdf86f2a8405f2cd7d86c@127.0.0.1:21007?discport=0&raftport=50408"
]

### Generate constellation private and public keys
$ cd keys

$ constellation-node --generatekeys=tm8

Lock key pair tm8 with password [none]: 
user1@ubuntu:~/dev/quorum-examples/examples/8nodes/keys$ ls -l tm8*
-rw------- 1 user1 user1 83 Mar 12 00:28 tm8.key
-rw-rw-r-- 1 user1 user1 44 Mar 12 00:28 tm8.pub

### Update script file raft-init.sh
Append node 8 to raft-init.sh :

echo "[*] Configuring node 8"

mkdir -p qdata/dd8/{keystore,geth}

cp permissioned-nodes.json qdata/dd8/static-nodes.json

cp raft/nodekey7 qdata/dd8/geth/nodekey

geth --datadir qdata/dd8 init genesis.json

Update the for loops from to {1..8}
for i in {1..8}
for i in {1..8}

### Update script file raft-start.sh
Append node 8 to raft-start.sh :

echo "[*] Starting Ethereum node 8"

PRIVATE_CONFIG=qdata/c8/tm.ipc nohup geth --datadir qdata/dd8 $ARGS --raftport 50408 --rpcport 22007 --port 21007 2>>qdata/logs/8.log &

### Update script1.js privateFor
Replace privateFor in script1.js to node 8's public key :

privateFor: ["LzIK0Etb2TPYpz+DX63VX3CswIGrRCVNG//jTgWx1kw="]

### Run and verify the 8th node
Run raft-init, raft-start, attach1 to create private contract with node 8.

Verify attach1, attach2, attach7 and attach8. Only node 1 and node 8 should get 42 from private.get()


