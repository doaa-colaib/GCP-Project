# GCP Project using python app
## Consists of:
1. GCP infrastrucutre created using terraform (in the infrastrucutre folder)
   - Network:
		- One VPC and two subnets (public management subnet and private restricted subnet)
		- Firewall (allow access through IAP only to VPC through ports 80 and 22)
     - Router NAT file (allows the network to access the internet but not be accessed i.e. without public IP addresses)
   - VM
     - VM instance in management subnet that on start runs startup-script.sh in metadata
     - Service account
	- startup-script.sh (to deploy kubernetes)
	   - installs kubectl
		- installs gcloud
   - Private GKE:
     - Private Cluster ( allows access only from the VM in management subnet)
     - Node
     - Service Account
```
terraform init   # to initialize terraform 
terraform apply  # to apply (create) above infrastructure in gcp
```
2. Simple python app and its docker image (in the app folder)
   - pulled the python app from GitHub Repo --> https://github.com/atefhares/DevOps-Challenge-Demo-Code
	- created a docker file for the app
	 - built a docker image for the app and uploaded it to GCR (Google Container Registery)
	 	``` 
		docker build -t app-image ./app
		docker push gcr.io/projectname/app 
		``` 
	 
3. Kubernetes yaml files to deploy the app
   - First: ssh into the vm and created two yaml files
	- Second: created the deployment file (dep.yaml) to run the app and use the image uploaded to GCR
	  ``` 
	  kubectl create -f dep.yaml
	  ``` 
	 - Third: created the service file (service.yaml) to expose the app to the internet
	   ``` 
	  	kubectl create -f service.yaml
	- Forth: by checking the external ip of the service, accessed the app with the designated port
	  ``` 
	  kubectl get all
	  ```
	![Screen Shot 2022-11-18 at 11 25 26 PM](https://user-images.githubusercontent.com/112077074/203623365-5698e4fa-92a6-4d3c-b26d-4b279b254102.png)
		
		
## Finally the app is up and running :+1:
![Screen Shot 2022-11-18 at 11 08 15 PM](https://user-images.githubusercontent.com/112077074/203383165-97f7f0cf-66ca-44d0-8fbc-7f69ff195114.png)

