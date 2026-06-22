sudo apt update
sudo apt install -y wget apt-transport-https gnupg

# Add Adoptium GPG key
wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | \
sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/adoptium.gpg

# Add Adoptium repository
echo "deb https://packages.adoptium.net/artifactory/deb $(. /etc/os-release && echo $VERSION_CODENAME) main" | \
sudo tee /etc/apt/sources.list.d/adoptium.list

# Update package list
sudo apt update

# Install Temurin JDK 17
sudo apt install -y temurin-17-jdk

#Verify Installation and Version
java -version
javac -version
