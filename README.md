# GCP Project using python app
## Consists of:
1. GCP infrastrucutre created using terraform
   - Network:
		- VPC and Subnets file 
		- Firewall file 
     - Router NAT file 
   - VM
     - VM instance that on start runs startup-script.sh in metadata
     - Service account
	- startup-script.sh
	   - installs kubectl
		- installs gcloud
   - GKE:
     - Cluster
     - Node
     - Service Account
		 
2. Simple python app and its docker image
   - pulled the python app from Repo https://github.com/atefhares/DevOps-Challenge-Demo-Code
	- created a docker file for the app
	 - created a docker image for the app and uploaded it to GCR (Google Container Registery)
	 
3. Kubernetes yaml files to deploy the app
   - First: ssh into the vm and created two yaml files
	- Second: created the deployment file (dep.yaml) to run the app and use the image uploaded to GCR
	 - Third: created the service file (service.yaml) to expose the app to the internet
	 - Forth: by checking the external ip of the service, accessed the app with the designated port

## Finally the app is up and running :+1:
![Screen Shot 2022-11-18 at 11 08 15 PM](https://user-images.githubusercontent.com/112077074/203383165-97f7f0cf-66ca-44d0-8fbc-7f69ff195114.png)

