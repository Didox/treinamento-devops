output "k8s_front" {
  value = [
    for key, item in aws_instance.levb_k8s_front :
    "Name: ${item.tags.Name} | PrivateIP: ${item.private_ip} | PublicIP: ${item.public_ip} ==> ssh -i '~/.ssh/keyPvtAccess.pub' ubuntu@${item.private_ip}"
  ]
}

output "k8s_hproxy" {
  value = [
    for key, item in aws_instance.levb_k8s_hproxy :
    "Name: ${item.tags.Name} | PrivateIP: ${item.private_ip} | PublicIP: ${item.public_ip} ==> ssh -i '~/.ssh/keyPvtAccess.pub' ubuntu@${item.private_ip}"
  ]
}

output "k8s_masters" {
  value = [
    for key, item in aws_instance.levb_k8s_master :
    "Name: ${item.tags.Name} | PrivateIP: ${item.private_ip} | PublicIP: ${item.public_ip} ==> ssh -i '~/.ssh/keyPvtAccess.pub' ubuntu@${item.private_ip}"
  ]
}

output "k8s_workers" {
  value = [
    for key, item in aws_instance.levb_k8s_worker :
    "Name: ${item.tags.Name} | PrivateIP: ${item.private_ip} | PublicIP: ${item.public_ip} ==> ssh -i '~/.ssh/keyPvtAccess.pub' ubuntu@${item.private_ip}"
  ]
}
