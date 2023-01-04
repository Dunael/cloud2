#!/bin/bash

AMI_ID=$(jq -r '.builds[-1].artifact_id' manifest.json)

Cp ~/variables.tf ~/terraform.tfvars

sed -i "s/AMI_ID/$AMI_ID/g" ~/terraform.tfvars
