# Updates the package list from configured repositories so the system knows about the latest available packages.
sudo apt update

# Creates a dedicated system user named prometheus. --system creates a service account, --no-create-home avoids creating a home directory, and --shell /bin/false prevents interactive logins.
sudo useradd --system --no-create-home --shell /bin/false prometheus

# Download Prometheus v2.47.1 Linux AMD64 binary package from GitHub.
wget https://github.com/prometheus/prometheus/releases/download/v2.47.1/prometheus-2.47.1.linux-amd64.tar.gz

# Extract the downloaded tar.gz archive
tar -xvf prometheus-2.47.1.linux-amd64.tar.gz

# Creates directories for Prometheus data storage (/data) and configuration files (/etc/prometheus). The -p option creates parent directories if needed.
sudo mkdir -p /data /etc/prometheus

# Changes into the extracted Prometheus directory.
cd prometheus-2.47.1.linux-amd64/

# Moves the Prometheus server binary and the Prometheus utility tool (promtool) into /usr/local/bin, making them executable system-wide
sudo mv prometheus promtool /usr/local/bin/

# Moves console templates and libraries used by Prometheus web UI into the configuration directory.
sudo mv consoles/ console_libraries/ /etc/prometheus/

# Moves the default Prometheus configuration file into the configuration directory.
sudo mv prometheus.yml /etc/prometheus/prometheus.yml

# Changes ownership of the configuration and data directories to the prometheus user and group so the service can access them.
sudo chown -R prometheus:prometheus /etc/prometheus/ /data/

# Return to the previous directory
cd ..

# Remove the downloaded archive file to free disk space
rm -rf prometheus-2.47.1.linux-amd64.tar.gz

# Verify Prometheus installation and version
prometheus --version
