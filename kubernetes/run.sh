#!/usr/bin/env bash

echo "DID YOU CHANGED values.yaml? [y/N]"
read -r input
if [[ "${input}" != "y" ]]; then
	exit 1
fi

images=()
images+=("react-express-mongodb-backend.tar")
images+=("react-express-mongodb-frontend.tar")

sudo snap install microk8s
sudo adduser ubuntu microk8s
sudo su - microk8s

microk8s enable dns helm3 ingress

for image in ${images[@]}; do
	microk8s ctr image import - < ${image}
done

# DON'T FORGET TO CHANGE rem_chart/values.yaml!!
microk8s helm3 install rem rem_chart
