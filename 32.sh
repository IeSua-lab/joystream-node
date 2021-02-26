#!/bin/bash

sudo apt-get update
sudo apt-get -y install nano apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt-get update
sudo apt-cache policy docker-ce
sudo apt -y install docker-ce
cd ~/
wget --no-check-certificate https://github.com/Joystream/joystream/releases/download/v7.5.0/joystream-node-3.3.0-fdb75f5ec-x86_64-linux-gnu.tar.gz
tar -vxf joystream-node-3.3.0-fdb75f5ec-x86_64-linux-gnu.tar.gz
wget --no-check-certificate https://github.com/Joystream/joystream/releases/download/v7.5.0/joy-testnet-4.json
#./joystream-node --chain joy-testnet-4.json --pruning archive --validator
cd /etc/systemd/system

read -p "Enter your node name and press [ENTER]:" username

echo [Unit] | sudo tee --append /etc/systemd/system/joystream-node.service
echo Description=Joystream Node | sudo tee --append /etc/systemd/system/joystream-node.service

echo [Service] | sudo tee --append /etc/systemd/system/joystream-node.service
echo Type=simple | sudo tee --append /etc/systemd/system/joystream-node.service
echo User=$USER | sudo tee --append /etc/systemd/system/joystream-node.service
echo WorkingDirectory=/home/$USER/ | sudo tee --append /etc/systemd/system/joystream-node.service

echo ExecStart=/home/$USER/joystream-node \\| sudo tee --append /etc/systemd/system/joystream-node.service

echo --chain joy-testnet-4.json \\| sudo tee --append /etc/systemd/system/joystream-node.service
echo --pruning archive \\| sudo tee --append /etc/systemd/system/joystream-node.service
echo --validator \\| sudo tee --append /etc/systemd/system/joystream-node.service
echo --name $username| sudo tee --append /etc/systemd/system/joystream-node.service
echo Restart=on-failure | sudo tee --append /etc/systemd/system/joystream-node.service
echo RestartSec=3 | sudo tee --append /etc/systemd/system/joystream-node.service
echo LimitNOFILE=8192 | sudo tee --append /etc/systemd/system/joystream-node.service

echo [Install] | sudo tee --append /etc/systemd/system/joystream-node.service
echo WantedBy=multi-user.target | sudo tee --append /etc/systemd/system/joystream-node.service

sudo systemctl daemon-reload
sudo systemctl start joystream-node
sudo systemctl enable joystream-node

GREEN='\033[0;32m'      #  ${GREEN}
echo -e "${GREEN}===============\nYour node is fully installed and running.\nNow go to the site (https://telemetry.polkadot.io/#list/Joystream) and find your node by the name you gave it.\n\nWait for complete synchronization and proceed to the next step - Validator Setup\n(read - https://github.com/Joystream/helpdesk/tree/master/roles/validators#validator-setup).\n==============="