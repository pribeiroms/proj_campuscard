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

	insert into cartao_aluno(nome,matricula,cpf,data_emissao,data_validade) values
	('Aluisio Veloso Silva Carvalho','2412130165','12345678912','01/01/20','02/02/20'),
	('Miguel Ferreira Pedroso','2412130072','23456789123','02/02/21','03/03/21'),
	('Paula Ribeiro Moreira de Souza','2412130037','34567891234','03/03/22','04/04/22'),
	('Joao Enrique Oliveira Souza','2412130084','45678912345','04/04/23','05/05/23'),
	('Pedro Arthur Silva Marques','2422130049','56789123456','05/05/24','06/06/24')


	create table sala_estudo (
	id_sala SERIAL PRIMARY KEY,
	hora_entrada time,
	hora_saida time,
	matricula VARCHAR (10) REFERENCES cartao_aluno(matricula));

	create table emprestimo (
	id_livro SERIAL PRIMARY KEY,
	data_emprestimo DATE,
	data_devoluçao DATE,
	matricula VARCHAR (10) REFERENCES cartao_aluno(matricula));

	create table catraca(
	id_catraca SERIAL PRIMARY KEY,
	hora_entrada TIME,
	hora_saida TIME,
	matricula VARCHAR (10) REFERENCES cartao_aluno(matricula));

	create table desconto (
	id_desconto SERIAL PRIMARY KEY,
	percentual_desconto DECIMAL (4, 2) NOT NULL,
	matricula VARCHAR (10) REFERENCES cartao_aluno(matricula));

	create table estabelecimento (
	hora_abertura TIME NOT NULL,
	hora_fechamento TIME NOT NULL,
	preço INT NOT NULL,
	tipo INT PRIMARY KEY,
	id_desconto SERIAL REFERENCES desconto(id_desconto));

	create table cantina (
	comida VARCHAR(50),
	tipo INT REFERENCES estabelecimento(tipo),
	id_cantina SERIAL PRIMARY KEY);
	
	create table estacionamento (
	quantidade_vagas INT NOT NULL,
	hora_entrada TIME,
	hora_saida TIME,
	tipo INT REFERENCES estabelecimento(tipo),
	id_estacionamento SERIAL PRIMARY KEY);









    drop table aluno;
	drop table sala_estudo;
	drop table emprestimo;
	drop table catraca;
	drop table desconto;
	drop table estabelecimento
	drop table cantina;
	drop table estacionamento;
	drop table cartao;





	
	