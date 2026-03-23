infra:
    git pull
    terraform init
    terraform apply -auto-approve

ansible:
    git pull
    ansible-playbook -i "$(tool_name)"-int.vdevops.io, -e ansible_username=azuser -e ansible_password=DevOps@123456 tool-setup.yml -e tool_name=$(tool_name)