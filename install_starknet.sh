# TODO check ubuntu versions 
# TODO check whether logged in as root

ECHO ""
  ______    ______      _____  __    __         ______   _______   __      __  _______   ________   ______  
 /      \  /      \    |     \|  \  |  \       /      \ |       \ |  \    /  \|       \ |        \ /      \ 
|  $$$$$$\|  $$$$$$\    \$$$$$| $$  | $$      |  $$$$$$\| $$$$$$$\ \$$\  /  $$| $$$$$$$\ \$$$$$$$$|  $$$$$$\
| $$   \$$| $$__| $$      | $$| $$  | $$      | $$   \$$| $$__| $$  \$$\/  $$ | $$__/ $$   | $$   | $$  | $$
| $$      | $$    $$ __   | $$| $$  | $$      | $$      | $$    $$   \$$  $$  | $$    $$   | $$   | $$  | $$
| $$   __ | $$$$$$$$|  \  | $$| $$  | $$      | $$   __ | $$$$$$$\    \$$$$   | $$$$$$$    | $$   | $$  | $$
| $$__/  \| $$  | $$| $$__| $$| $$__/ $$      | $$__/  \| $$  | $$    | $$    | $$         | $$   | $$__/ $$
 \$$    $$| $$  | $$ \$$    $$ \$$    $$       \$$    $$| $$  | $$    | $$    | $$         | $$    \$$    $$
  \$$$$$$  \$$   \$$  \$$$$$$   \$$$$$$         \$$$$$$  \$$   \$$     \$$     \$$          \$$     \$$$$$$
                                                                                                          ""





echo "\n\n\n Entre com o endereco Achemy ou Infura \n"

read -p " Coloque aqui --> " url

while [[ "$url" == "" ]]; do

   read -p " 👉 " url

done

exit

echo " BORA COMECAR"

echo "\n Iniciando....... \n"

sudo apt update && sudo apt upgrade -y

sudo apt install curl git python3-pip build-essential libssl-dev libffi-dev python3-dev libgmp-dev pkg-config -y

pip3 install fastecdsa

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

sudo apt install cargo -y

source $HOME/.cargo/env

rustup update stable

cd

git clone --branch main https://github.com/eqlabs/pathfinder.git

sudo apt install python3.8-venv

#TODO check pytho version to be < 3.10 because of Cairo incompatibility.

cd pathfinder/py

python3 -m venv .venv

source .venv/bin/activate

PIP_REQUIRE_VIRTUALENV=true pip install --upgrade pip

PIP_REQUIRE_VIRTUALENV=true pip install -r requirements-dev.txt

pytest

RUST_LOG=debug PATHFINDER_HTTP_RPC_ADDRESS=0.0.0.0:9545 cargo build --release --bin pathfinder

sudo tee /etc/systemd/system/starknetd.service >/dev/null <<EOF
[Unit]
Description=StarkNet
After=network.target
[Service]
Type=simple
User=root
WorkingDirectory=/root/pathfinder/py
ExecStart=/bin/bash -c 'source /root/pathfinder/py/.venv/bin/activate && /root/.cargo/bin/cargo run --release --bin pathfinder -- --ethereum.url https://eth-mainnet.alchemyapi.io/v2/mtugw_03z8s_PKMlKyomVhdOtmNLcbse'
Restart=always
RestartSec=10
Environment=RUST_BACKTRACE=1
Environment=PATHFINDER_HTTP_RPC_ADDRESS=0.0.0.0:9545
Environment=RUST_LOG=debug
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload

sudo systemctl enable starknetd

echo "\n \n How does everything look? \n \n If everything looks good, then welcome to the fam! /n /n ♥️️🔥 \n"

echo "\n Watch your baby👼 grow up! They grow up sooo fast! \n 👀     👀     👀     👀     👀     👀     👀     👀     👀      👀     👀     👀 \n"

read -p "Lookin' juicy! Would you like to see your first Stark Net logs? [y/N]" show_logs

sudo systemctl start starknetd

if [[ "$show_logs" == "y" ]]; then

    journalctl -u starknetd -f -o cat

fi

exit