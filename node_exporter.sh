# Create a dedicated system user 
sudo useradd --system --no-create-home --shell /bin/false node_exporter 
# Download Node Exporter 
wget https://github.com/prometheus/node_exporter/releases/download/v1.8.2/node_exporter-1.8.2.linux-amd64.tar.gz 
# Extract the archive 
tar -xvf node_exporter-1.8.2.linux-amd64.tar.gz 
# Navigate to extracted directory 
cd node_exporter-1.8.2.linux-amd64 
# Move binary to system path 
sudo mv node_exporter /usr/local/bin/ 
# Set ownership 
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter 
# Return to previous directory 
cd .. 
# Remove downloaded files 
rm -rf node_exporter-1.8.2.linux-amd64*
# Verify Installation
node_exporter --version
