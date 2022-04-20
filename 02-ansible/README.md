 ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key ~/Desktop/devops/Treinamento

 ssh -i ~/Desktop/devops/Treinamento ubuntu@ec2-3-93-240-108.compute-1.amazonaws.com


ansible-playbook provisionar.yml --syntax-check # verifica sintaxe ansible yml