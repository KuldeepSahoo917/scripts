# Update package index
sudo apt update
# Install required dependencies
sudo apt install -y software-properties-common wget apt-transport-https gnupg
# Create a directory for repository keys
sudo mkdir -p /etc/apt/keyrings
# Download and store Grafana's GPG key
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
# Add Grafana repository
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee /etc/apt/sources.list.d/grafana.list
# Refresh package information again
sudo apt update
# Install Grafana
sudo apt install -y grafana
# Reload systemd configuration
sudo systemctl daemon-reload
# Enable Grafana at boot
sudo systemctl enable grafana-server
# Start Grafana service
sudo systemctl start grafana-server
# Check service status
sudo systemctl status grafana-server
# Checks Grafana version
grafana-server -v
