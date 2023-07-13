echo -e '\e[40m\e[92m'                          
echo -e '                                                                                                                   '
echo -e '       /$$$$$$   /$$$$$$     /$$$$$ /$$   /$$        /$$$$$$  /$$$$$$$  /$$     /$$ /$$$$$$$  /$$$$$$$$  /$$$$$$   '
echo -e '      /$$__  $$ /$$__  $$   |__  $$| $$  | $$       /$$__  $$| $$__  $$|  $$   /$$/| $$__  $$|__  $$__/ /$$__  $$  '
echo -e '     | $$  \__/| $$  \ $$      | $$| $$  | $$      | $$  \__/| $$  \ $$ \  $$ /$$/ | $$  \ $$   | $$   | $$  \ $$  '
echo -e '     | $$      | $$$$$$$$      | $$| $$  | $$      | $$      | $$$$$$$/  \  $$$$/  | $$$$$$$/   | $$   | $$  | $$  '
echo -e '     | $$      | $$__  $$ /$$  | $$| $$  | $$      | $$      | $$__  $$   \  $$/   | $$____/    | $$   | $$  | $$  '
echo -e '     | $$    $$| $$  | $$| $$  | $$| $$  | $$      | $$    $$| $$  \ $$    | $$    | $$         | $$   | $$  | $$  '
echo -e '     |  $$$$$$/| $$  | $$|  $$$$$$/|  $$$$$$/      |  $$$$$$/| $$  | $$    | $$    | $$         | $$   |  $$$$$$/  '
echo -e '      \______/ |__/  |__/ \______/  \______/        \______/ |__/  |__/    |__/    |__/         |__/    \______/   '
echo -e '                                                                                                                   '
echo -e '\e[0m'     
echo "======================================================================================================================="
echo "===========================================VAMOS COMECAR================================================================"

sudo apt install curl -y < "/dev/null"
sudo apt update && sudo apt-get install software-properties-common -y
sudo apt upgrade -y

sudo apt install pkg-config curl git build-essential libssl-dev

sudo apt install screen
python3 -V
sudo apt install -y python3-pip

sudo apt install -y build-essential libssl-dev libffi-dev python3-dev

sudo apt-get install libgmp-dev

pip3 install fastecdsa

sudo apt-get install -y pkg-config

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

source $HOME/.cargo/env

rustup update stable --force

git clone --branch v0.4.0 https://github.com/eqlabs/pathfinder.git

sudo apt install python3.8-venv

cd pathfinder/py

python3 -m venv .venv

source .venv/bin/activate

PIP_REQUIRE_VIRTUALENV=true pip install --upgrade pip

PIP_REQUIRE_VIRTUALENV=true pip install -r requirements-dev.txt

cargo build --release --bin pathfinder

echo "============================ENTRE COM O ENDERECO DA CARTEIRA ALCHEMY E APERTE ENTER=================================================="
read endereco


echo "==============================================RRRRRODANDO ROCKE======================================================================"
cargo run --release --bin pathfinder -- --ethereum.url "$endereco" &
