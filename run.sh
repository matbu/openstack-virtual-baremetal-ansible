#!/bin/bash -e
export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_SSH_ARGS=' -F ssh_config'

if [ ! -d ansible_venv ]; then
    virtualenv ansible_venv
fi
source ansible_venv/bin/activate
pip install -U ansible==1.9.2
pip install markupsafe

set +e
anscmd="stdbuf -oL -eL ansible-playbook -vvvv"
echo "Deploy devstack"
#$anscmd -i hosts devstack/main.yml
result=$?
if [[ $result == 0 ]]; then
    echo "Deploy OVB"
    $anscmd -i hosts ovb/main.yml
fi
