# rodar playbook no ansible
ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key ~/.ssh/terraform-aws

# acesso ssh maquina
ssh -i ~/.ssh/terraform-aws ubuntu@ec2-54-234-131-240.compute-1.amazonaws.com 
