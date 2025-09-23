-- SCHEMA: flexcard

-- DROP SCHEMA IF EXISTS flexcard ;

CREATE SCHEMA IF NOT EXISTS flexcard
    AUTHORIZATION postgres;

	create table cartao_aluno (
	nome VARCHAR (100) NOT NULL,
	matricula VARCHAR (10) PRIMARY KEY,
	cpf VARCHAR (11)NOT NULL UNIQUE,
	data_emissao DATE NOT NULL,
	data_validade DATE NOT NULL,
	id_cartao SERIAL NOT NULL);

	select * from cartao_aluno;

	insert into cartao_aluno(nome,matricula,cpf,data_emissao,data_validade) VALUES
	('Aluisio Veloso Silva Carvalho','2412130165','12345678912','01/01/20','02/02/20'),
	('Miguel Ferreira Pedroso','2412130072','23456789123','02/02/21','03/03/21'),
	('Paula Ribeiro Moreira de Souza','2412130037','34567891234','03/03/22','04/04/22'),
	('Joao Enrique Oliveira Souza','2412130084','45678912345','04/04/23','05/05/23'),
	('Pedro Arthur Silva Marques','2422130049','56789123456','05/05/24','06/06/24')

	create table sala_estudo (
	id_sala SERIAL PRIMARY KEY,
	hora_entrada time NOT NULL,
	hora_saida time NOT NULL,
	data_reserva DATE NOT NULL,
	matricula VARCHAR (10) REFERENCES cartao_aluno(matricula));

	select * from sala_estudo;

	insert into sala_estudo(hora_entrada,hora_saida,data_reserva,matricula) VALUES
	('01:00','02:00','20/03/2025','2412130165'),
	('20:00','21:00','21/03/2025','2412130072'),
	('04:00','05:00','21/03/2025','2412130037'),
	('15:00','16:00','29/03/2025','2412130084'),
	('19:00','22:00','01/04/2025','2422130049')
	

	create table emprestimo (
	id_livro SERIAL PRIMARY KEY,
	data_emprestimo DATE NOT NULL,
	data_devoluçao DATE NOT NULL,
	matricula VARCHAR (10) REFERENCES cartao_aluno(matricula));

	select * from emprestimo;

	insert into emprestimo(data_emprestimo,data_devoluçao,matricula) VALUES
	('01/01/20','02/02/20','2412130165'),
	('02/02/21','03/03/21','2412130072'),
	('03/03/22','04/04/22','2412130037'),
	('04/04/23','05/05/23','2412130084'),
	('05/05/24','06/06/24','2422130049')

	create table catraca(
	id_catraca SERIAL PRIMARY KEY,
	hora_entrada TIME NOT NULL,
	hora_saida TIME,
	data_presença DATE NOT NULL,
	matricula VARCHAR (10) REFERENCES cartao_aluno(matricula));

	select * from catraca;

	insert into catraca(hora_entrada,hora_saida,data_presença,matricula) VALUES
	('8:15','11:30','20/04/25','2412130165'),
	('8:15','11:30','21/04/25','2412130072'),
	('8:15','11:30','22/04/25','2412130037'),
	('8:15','11:30','23/04/25','2412130084'),
	('8:15','11:30','24/04/25','2422130049')
	

	create table desconto (
	id_desconto SERIAL PRIMARY KEY,
	percentual_desconto DECIMAL (4, 2) NOT NULL,
	matricula VARCHAR (10) REFERENCES cartao_aluno(matricula));

	select * from desconto;

	insert into desconto(percentual_desconto,matricula) VALUES
	('20','2412130165'),
	('15','2412130072'),
	('30','2422130049'),
	('50','2412130165'),
	('10','2412130037')
	

	create table estabelecimento (
	hora_abertura TIME NOT NULL,
	hora_fechamento TIME NOT NULL,
	tipo INT PRIMARY KEY,
	preço DECIMAL (5, 2) NOT NULL,
	id_desconto SERIAL REFERENCES desconto(id_desconto));

	select * from estabelecimento;

	insert into estabelecimento(hora_abertura,hora_fechamento,tipo,preço,id_desconto) VALUES 
	('7:45','22:00','1','7.50','15'),
	('7:45','22:00','1','12.00','20'),
	('7:45','22:00','2','2.75','10'),
	('7:45','22:00','3','36.20','50')

	create table cantina (
	nome VARCHAR (50) NOT NULL,
	comida VARCHAR(50) NOT NULL,
	tipo INT REFERENCES estabelecimento(tipo),
	cnpj VARCHAR(14) PRIMARY KEY);

	select * from cantina;

	insert into cantina(nome,comida,tipo,cnpj) VALUES
	('comidinhas da joelma','bolo de fubá','1')
	
	create table estacionamento (
	quantidade_vagas INT NOT NULL,
	hora_entrada TIME NOT NULL,
	hora_saida TIME,
	tipo INT REFERENCES estabelecimento(tipo),
	id_estacionamento INT PRIMARY KEY);

	select * from estacionamento;

	insert into estacionamento(quantidade_vagas,hora_entrada,hora_saida,tipo,id_estacionamento)








    drop table aluno;
	drop table sala_estudo;
	drop table emprestimo;
	drop table catraca;
	drop table desconto;
	drop table estabelecimento;
	drop table cantina;
	drop table estacionamento;
	drop table cartao;


    UPDATE estabelecimento
    SET preço = 15.99
    WHERE id_desconto = 20;







	

	



