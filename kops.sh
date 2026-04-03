Launch Ubuntu Instance, t2.micro
Attach a IAM ROLE TO = EC2, Permisions = admin

#Provide the Path
vi .bashrc
export PATH=$PATH:/usr/local/bin/
:wq!
source .bashrc

#SSH Key Setup
ssh-keygen
ssh-keygen -t rsa -b 4096 -m PEM -f my-keypair
cp /root/.ssh/id_rsa.pub my-keypair.pub
chmod 777 my-keypair.pub

#Setup KOPS
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
wget https://github.com/kubernetes/kops/releases/download/v1.32.0/kops-linux-amd64
chmod +x kops-linux-amd64 kubectl
mv kubectl /usr/local/bin/kubectl
mv kops-linux-amd64 /usr/local/bin/kops

#Setup S3 Bucket for Auto Scaling Groups
aws s3api create-bucket --bucket cool-kops-testbucket.k8s.local --region ap-south-1 --create-bucket-configuration LocationConstraint=ap-south-1
aws s3api put-bucket-versioning --bucket cool-kops-testbucket.k8s.local --region ap-south-1 --versioning-configuration Status=Enabled

#Setup Clusters
export KOPS_STATE_STORE=s3://cool-kops-testbucket.k8s.local
kops create cluster --name=cool.k8s.local --zones ap-south-1a --control-plane-count=1 --control-plane-size=t3.small --node-count=2 --node-size=t3.small --node-volume-size=20 --control-plane-volume-size=20 --ssh-public-key=my-keypair.pub --image=ami-02d26659fd82cf299 --networking=calico --topology=public
kops update cluster --name cool.k8s.local --yes --admin
kops validate cluster --wait 10m

#Delete Clusters
kops delete cluster --name cool.k8s.local --yes

