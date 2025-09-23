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
	

	CREATE TABLE estabelecimento (
    id_estabelecimento SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    hora_abertura TIME NOT NULL,
    hora_fechamento TIME NOT NULL,
    tipo VARCHAR(20) NOT NULL CHECK (tipo IN ('cantina', 'estacionamento')),
	);

	select * from estabelecimento


	INSERT INTO estabelecimento (nome, hora_abertura, hora_fechamento, tipo, preco_base) VALUES 
('Cantina Central', '07:45', '22:00', 'cantina', 2.75),
('Cantina Norte', '07:45', '22:00', 'cantina', 3.50),
('Estacionamento Principal', '07:45', '22:00', 'estacionamento', 7.50),
('Estacionamento Visitantes', '07:45', '22:00', 'estacionamento', 12.00);



	CREATE TABLE cantina (
    id_estabelecimento INT PRIMARY KEY REFERENCES estabelecimento(id_estabelecimento),
    comida VARCHAR(50) NOT NULL,
    cnpj VARCHAR(14) UNIQUE NOT NULL
	preco_base DECIMAL(5,2) NOT NULL
);

	select * from cantina;

	insert into cantina(nome,comida,tipo,cnpj) VALUES
	('comidinhas da joelma','bolo de fubá','1')
	
	CREATE TABLE estacionamento (
    id_estabelecimento INT PRIMARY KEY REFERENCES estabelecimento(id_estabelecimento),
    quantidade_vagas INT NOT NULL,
    hora_entrada TIME,
    hora_saida TIME
	);

	
	select * from estacionamento;

	insert into estacionamento(quantidade_vagas,hora_entrada,hora_saida,tipo,id_estacionamento)


	CREATE TABLE estabelecimento_desconto (
    id_estabelecimento INT REFERENCES estabelecimento(id_estabelecimento),
    id_desconto INT REFERENCES desconto(id_desconto),
    data_aplicacao DATE DEFAULT CURRENT_DATE,
    PRIMARY KEY (id_estabelecimento, id_desconto)
);








    drop table cartao_aluno;
	drop table sala_estudo;
	drop table emprestimo;
	drop table catraca;
	drop table desconto;
	DROP TABLE IF EXISTS cantina CASCADE;
DROP TABLE IF EXISTS estacionamento CASCADE;
DROP TABLE IF EXISTS estabelecimento CASCADE;


    UPDATE estabelecimento
    SET preço = 15.99
    WHERE id_desconto = 20;



	

