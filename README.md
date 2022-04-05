
Link apostila:
https://docs.google.com/document/d/1Pi9h1QXyBOhzm_9LYIWyWWcBZNFNJYc7_Aj6bA65Pyk/edit

Link apresentação:
https://docs.google.com/presentation/d/1h81actx7ReWqXykzGhYJRuH_byCxALVL6MbLUvxxmmU/edit#slide=id.gf113ee1e2f_0_145

Instalar o AWS CLI
------------------------------------------------------------------------------------------------------------------
https://docs.aws.amazon.com/pt_br/cli/latest/userguide/install-cliv2.html

gerar um usuário no IAM
aqui: https://console.aws.amazon.com/iamv2/home?#/groups/create
Criar um security group e fazer download das chaves exemplo: professor.danilo_accessKeys.csv
baixar o csv e colocar as informações da conta no configure do aws cli
comando:
aws configure


## multiplos terminais
Iterm
tilix
https://gnunn1.github.io/tilix-web/





# # ver os processos pela porta
# sudo lsof -iTCP -sTCP:LISTEN -P | grep :5001

# # ver os processos do node
# ps aux | grep node

# # matar ao processo com número PID
# kill -9 PID

# sudo su -
# mysql -u root

# use treinamento_database;

# alter table usuarios add column email varchar(150);
# alter table usuarios add column descricao text;

# update usuarios set email='danilo@gmail.com' where id=1;

# danilo@gmail.com
# danilo 

 ssh -i chave.pem ubuntu@dns.com -o ServerAliveInterval=60
 
 
 
 
 
 
# load balancer user data
```aws
#!/bin/bash
apt update && apt upgrade -y
apt install net-tools nginx -y

cat <<EOF >> /etc/hosts
127.0.0.1 appservers
172.20.16.11 appserv1 ## substitua pelos ip privado do appserver1
172.20.63.249 appserv2 ## substitua pelos ip privado do appserver2
EOF

cat <<EOF > /etc/nginx/sites-available/default   
server {
    # Location that proxies requests to the upstream group
        location / {
            proxy_pass http://appservers;
        location /nginx_status {
                 stub_status;
                 allow 127.0.0.1;       #only allow requests from localhost
                 deny all;              #deny all other hosts
         }
         }
    }
EOF

cat <<EOF > /etc/nginx/nginx.conf 
user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
        worker_connections 768;
}

http {


        sendfile on;
        tcp_nopush on;
        tcp_nodelay on;
        keepalive_timeout 65;
        types_hash_max_size 2048;


        include /etc/nginx/mime.types;
        default_type application/octet-stream;


        ssl_prefer_server_ciphers on;


        access_log /var/log/nginx/access.log;
        error_log /var/log/nginx/error.log;


        gzip on;



        include /etc/nginx/conf.d/*.conf;
        include /etc/nginx/sites-enabled/*;
   upstream appservers {
        server appserv1:8080;
        server appserv2:8080;
}
}
EOF

service nginx restart
```
