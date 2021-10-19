-- tetminal
-- restaura dump
mysql -u root -p SpringWebYoutubeTest < dump-mysql.sql
-- fazer dump
mysqldump --user root --password  SpringWebYoutubeTest > all-databases.sql

--  scripts
create database SpringWebYoutubeTest;

insert into administradores(email, nome, observacao, senha)values('danilo@teste.com', 'danilo', 'treinamento k8s', '123456');

select * from administradores;