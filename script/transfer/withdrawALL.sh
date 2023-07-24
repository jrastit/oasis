SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

NONCE=`$SCRIPT_ENTITY_INFO_DIR/nonce.sh`
echo nonce $NONCE
sleep 5
TX=withdraw$(date +%s).json
OUTPUT_TX=$LOCAL_TX/$TX
AVAILABLE=`$SCRIPT_ENTITY_INFO_DIR/get_stake_available.sh`
echo availlable $AVAILABLE
#keep 2000 ROSE 
AMOUNT=`expr $AVAILABLE - 2000000000000`

if [ -z "$AMOUNT" ]
then
	echo "amount is empty"
	exit 0
fi

echo destination address \( oasis... \)
read TO_ADDRESS

$SCRIPT_DIR/oasis_local.sh stake account gen_transfer \
	--genesis.file $GENESIS_JSON \
	--signer.backend file \
	--signer.dir $ENTITY_DIR \
	--stake.amount $AMOUNT \
	--stake.transfer.destination $TO_ADDRESS \
	--transaction.file $OUTPUT_TX \
	--transaction.fee.gas 1500 \
	--transaction.fee.amount 0 \
	--transaction.nonce $NONCE 

if [ $? -ne 0 ]; then
	echo Error: transaction error
	exit 1
fi 

$SCRIPT_DIR/submit_transaction.sh $TX
