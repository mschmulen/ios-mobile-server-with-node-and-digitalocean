# Update and begin installing some utility tools
apt-get -y update
apt-get install -y python-software-properties
apt-get install -y vim git subversion curl
apt-get install -y memcached build-essential
  
# Install StrongLoop Node
cd /opt

# strongloop-node_1.1.4-1_amd64.deb
sudo wget -O strongloop-node_amd64.deb http://45ec19d3127bddec1c1d-e57051fde4dbc9469167f8c2a84830dc.r36.cf1.rackcdn.com/strongloop-suite_1.0.0-1_amd64.deb

sudo dpkg -i strongloop-node_amd64.deb

#install some npm components
sudo npm install -g forever

#create an apps folder under var to hold your apps
cd /var
mkdir apps
