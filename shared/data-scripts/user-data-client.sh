#!/bin/bash

set -e

exec > >(sudo tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sudo bash /ops/shared/scripts/client.sh '${retry_join}' "${nomad_binary}"

NOMAD_HCL_PATH="/etc/nomad.d/nomad.hcl"

sed -i "s/CONSUL_TOKEN/${nomad_consul_token_secret}/g" $NOMAD_HCL_PATH
sudo systemctl restart nomad

echo "Finished client setup"