#!/bin/bash

MINER=dero_darwin_universal
MINER_BIN=dero-miner-darwin

echo -n "Enter Your Miner Wallet Address: "
read WALLET
 
ANSWER=N

while [[ $ANSWER != "Y" && $ANSWER != "y" && $ANSWER != "" ]]
do
        echo -n "Is this ($WALLET) correct? (y)"
        read ANSWER

        if [[ $ANSWER != "Y" && $ANSWER != "y" && $ANSWER != "" ]]
        then
               echo -n "Enter Your Miner Wallet Address: "
                read WALLET
        fi
done

echo "Using Wallet Address: $WALLET"
MINER_PORT=10300
NODE=thewestiswild.com:$MINER_PORT

ANSWER=N
while [[ $ANSWER != "Y" && $ANSWER != "y" && $ANSWER != "" ]]
do
        echo -n "Use Following Mining Node? ($NODE)? (y)"
        read ANSWER

        if [[ $ANSWER != "Y" && $ANSWER != "y" && $ANSWER != "" ]]
        then
            echo -n "Enter Your Mining Node Address: "
            read NODE
        fi
done


[[ -f $MINER.tar.gz ]] && rm -f $MINER.tar.gz
[[ -d $MINER ]] && rm -rf $MINER

echo "Downloading Latest ($MINER) version ...."

wget -c https://github.com/deroproject/derohe/releases/latest/download/$MINER.tar.gz

[[ ! -d $MINER ]] && tar -zxpvf $MINER.tar.gz

echo "Starting up Dero Miner using wallet: $WALLET...."

# community-pools.mysrv.cloud
MINER_SCRIPT=$PWD/$MINER/dero-miner.sh

echo $PWD/$MINER/$MINER_BIN --wallet-address=$WALLET --daemon-rpc-address=$NODE --debug > $MINER_SCRIPT
chmod +x $MINER_SCRIPT

$MINER_SCRIPT

echo -e "To start miner again, run\n$ $MINER_SCRIPT"