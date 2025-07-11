# 🚀 QCK Validator Docker Node

## 🛠 Creating an image
```bash
docker build -t quicksilver-node .
```

## 🛠 Container launch
```bash
docker run -d --name=quicksilver --restart always   -v <your_path>/.quicksilverd:/root/.quicksilverd -p 23656:26656 -p 23657:26657  quicksilver-node
```

## 🛠 Download genesis.json (execute in config folder)
```bash
curl -s https://raw.githubusercontent.com/quicksilver-zone/networks/refs/heads/main/mainnet/quicksilver-2/genesis.json > genesis.json
```
    
## 🤖 Creating a validator
```bash
docker exec -ti quicksilver quicksilverd tx staking create-validator \ 
--amount=50000000uqck \
--commission-max-change-rate="0.02" \
--commission-max-rate="0.20" \
--commission-rate="0.05" \
--min-self-delegation="1" \
--details=<your_details> \
--pubkey=$(quicksilverd tendermint show-validator) \
--security-contact=<your_contacts> \
--moniker=<your_node_nickname> \
--chain-id=quicksilver-2 \
--from=<your_key_name>  \
--gas="auto" \
--fees=31uqck
```

## 🛠 Get operator address - quickvaloper
```bash
quicksilver quicksilverd keys show <your_key_or_key_name> --bech val -a
```

## 💰 Get a commission
```bash
docker exec -ti quicksilver quicksilverd tx distribution withdraw-rewards <your_operator_address> \ 
--from=<your_key_name> \
--chain-id=quicksilver-2 \
--commission \ 
--gas=auto \
--fees=5000uqck 
```

## 💰 Show commission
```bash
docker exec -ti quicksilver quicksilverd query distribution commission <your_operator_address>
```

## 💰 Show rewards
```bash
docker exec -ti quicksilver quicksilverd query distribution rewards <delegator_address>  <your_operator_address> --chain-id quicksilver-2 --output json
```