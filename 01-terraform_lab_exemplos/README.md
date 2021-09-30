*** Comandos básicos
```bash
terraform init # inicia repo terraform
terraform plan # mostra o que irá fazer no provider, maquinas que irá criar etc 
terraform apply # aplica o plano no provider
terraform destroy # apaga as máquinas criadas no plano
terraform destroy --target modeule.ec2_meu_teste # apaga as máquinas criadas no plano de um modulo específico
terraform refresh # mostra retorno dos outputs
terraform login # para versionar na conta do terraform
