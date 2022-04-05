-- tetminal
-- restaura dump
mysql -u root -p SpringWebYoutubeTest < dump-mysql.sql
-- fazer dump
mysqldump --user root --password  SpringWebYoutubeTest > all-databases.sql

--  scripts
create database SpringWebYoutubeTest;
use SpringWebYoutubeTest;

CREATE TABLE `administradores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(180) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `observacao` longtext,
  `senha` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

insert into administradores(email, nome, observacao, senha)values('danilo@teste.com', 'danilo', 'treinamento k8s', '123456');

select * from administradores;