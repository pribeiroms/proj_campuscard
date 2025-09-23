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


	create table sala_estudo (
	id_sala SERIAL PRIMARY KEY,
	hora_entrada time NOT NULL,
	hora_saida time NOT NULL,
	data_reserva DATE NOT NULL,
	matricula VARCHAR (10) REFERENCES cartao_aluno(matricula));


	create table emprestimo (
	id_livro SERIAL PRIMARY KEY,
	data_emprestimo DATE NOT NULL,
	data_devoluçao DATE NOT NULL,
	matricula VARCHAR (10) REFERENCES cartao_aluno(matricula));

	create table catraca(
	id_catraca SERIAL PRIMARY KEY,
	hora_entrada TIME NOT NULL,
	hora_saida TIME,
	data_presença DATE NOT NULL,
	matricula VARCHAR (10) REFERENCES cartao_aluno(matricula));


	create table desconto (
	id_desconto SERIAL PRIMARY KEY,
	percentual_desconto DECIMAL (4, 2) NOT NULL,
	matricula VARCHAR (10) REFERENCES cartao_aluno(matricula));


	CREATE TABLE estabelecimento (
    id_estabelecimento SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    hora_abertura TIME NOT NULL,
    hora_fechamento TIME NOT NULL,
    tipo VARCHAR(20) NOT NULL CHECK (tipo IN ('cantina', 'estacionamento')));


	CREATE TABLE cantina (
    id_estabelecimento INT PRIMARY KEY REFERENCES estabelecimento(id_estabelecimento),
    comida VARCHAR(50) NOT NULL,
    cnpj VARCHAR(14) UNIQUE NOT NULL,
	preco_base DECIMAL(5,2) NOT NULL
);


	CREATE TABLE estacionamento (
    id_estabelecimento INT PRIMARY KEY REFERENCES estabelecimento(id_estabelecimento),
    quantidade_vagas INT NOT NULL,
    preco_base DECIMAL(5,2) NOT NULL);


	CREATE TABLE estacionamento_uso (
    id_uso SERIAL PRIMARY KEY,
    id_estabelecimento INT REFERENCES estacionamento(id_estabelecimento),
    matricula VARCHAR(10) REFERENCES cartao_aluno(matricula),
    hora_entrada TIMESTAMP NOT NULL,
    hora_saida TIMESTAMP,
    valor_pago DECIMAL(5,2));


	CREATE TABLE estabelecimento_desconto (
    id_estabelecimento INT REFERENCES estabelecimento(id_estabelecimento),
    id_desconto INT REFERENCES desconto(id_desconto),
    data_aplicacao DATE DEFAULT CURRENT_DATE,
    PRIMARY KEY (id_estabelecimento, id_desconto));


	CREATE TABLE compra_cantina (
    id_compra SERIAL PRIMARY KEY,
    id_estabelecimento INT REFERENCES cantina(id_estabelecimento),
    matricula VARCHAR(10) REFERENCES cartao_aluno(matricula),
    item_comprado VARCHAR(50) NOT NULL,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    valor_pago DECIMAL(5,2),
    id_desconto_aplicado INT REFERENCES desconto(id_desconto));







/*

	select * from cartao_aluno;

	insert into cartao_aluno(nome,matricula,cpf,data_emissao,data_validade) VALUES
	('Aluisio Veloso Silva Carvalho','2412130165','12345678912','01/01/20','02/02/20'),
	('Miguel Ferreira Pedroso','2412130072','23456789123','02/02/21','03/03/21'),
	('Paula Ribeiro Moreira de Souza','2412130037','34567891234','03/03/22','04/04/22'),
	('Joao Enrique Oliveira Souza','2412130084','45678912345','04/04/23','05/05/23'),
	('Pedro Arthur Silva Marques','2422130049','56789123456','05/05/24','06/06/24')


select * from sala_estudo;

	insert into sala_estudo(hora_entrada,hora_saida,data_reserva,matricula) VALUES
	('01:00','02:00','20/03/2025','2412130165'),
	('20:00','21:00','21/03/2025','2412130072'),
	('04:00','05:00','21/03/2025','2412130037'),
	('15:00','16:00','29/03/2025','2412130084'),
	('19:00','22:00','01/04/2025','2422130049')
	

select * from emprestimo;

	insert into emprestimo(data_emprestimo,data_devoluçao,matricula) VALUES
	('01/01/20','02/02/20','2412130165'),
	('02/02/21','03/03/21','2412130072'),
	('03/03/22','04/04/22','2412130037'),
	('04/04/23','05/05/23','2412130084'),
	('05/05/24','06/06/24','2422130049')


	select * from catraca;

	insert into catraca(hora_entrada,hora_saida,data_presença,matricula) VALUES
	('8:15','11:30','20/04/25','2412130165'),
	('8:15','11:30','21/04/25','2412130072'),
	('8:15','11:30','22/04/25','2412130037'),
	('8:15','11:30','23/04/25','2412130084'),
	('8:15','11:30','24/04/25','2422130049')
	

	select * from desconto;

	insert into desconto(percentual_desconto,matricula) VALUES
	('20','2412130165'),
	('15','2412130072'),
	('30','2422130049'),
	('50','2412130165'),
	('10','2412130037'),
	('11','2412130165')
	



select * from estabelecimento


	INSERT INTO estabelecimento (nome, hora_abertura, hora_fechamento, tipo) VALUES 
('Cantina Comidinhas da Joelma', '07:45', '22:00', 'cantina'),
('Cantina Lanche do bom', '07:45', '22:00', 'cantina'),
('Estacionamento Principal', '07:45', '22:00', 'estacionamento')




	select * from cantina;

	INSERT INTO cantina (id_estabelecimento, comida, cnpj,preco_base) VALUES 
    (1, 'Bolo de Fubá', '12345678000195','15.99'),
    (2, 'Sanduíche Natural', '98765432000187','25.99');



	select * from estacionamento;

	INSERT INTO estacionamento (id_estabelecimento, quantidade_vagas, preco_base) VALUES 
    (3, 100, 5.00);


INSERT INTO estacionamento_uso (id_estabelecimento, matricula, hora_entrada, hora_saida, valor_pago) VALUES
(3, '2412130165', '2025-03-20 08:00:00', '2025-03-20 12:00:00', '5.00'),
(3, '2412130072', '2025-03-20 09:15:00', '2025-03-20 14:30:00', '5.00'), 
(3, '2412130037', '2025-03-21 07:45:00', '2025-03-21 16:20:00', '5.00'), 
(3, '2412130084', '2025-03-21 10:00:00', '2025-03-21 18:00:00', '5.00'), 
(3, '2422130049', '2025-03-22 08:30:00', '2025-03-22 15:45:00', '5.00');  

	select * from estacionamento_uso;


    INSERT INTO estabelecimento_desconto (id_estabelecimento, id_desconto) VALUES 
    (1, 1), (1, 2), (2, 5), (3, 3), (3, 4);

	select * from estabelecimento_desconto;


INSERT INTO compra_cantina (id_estabelecimento, matricula, item_comprado, data_hora, valor_pago, id_desconto_aplicado) VALUES
    (1, '2412130165', 'Bolo de Fubá', '2025-03-20 08:30:00', 12.79, 1),
    (1, '2412130072', 'Bolo de Fubá', '2025-03-20 10:15:00', 13.59, 2), 
    (1, '2412130037', 'Bolo de Fubá', '2025-03-20 12:45:00', 14.39, 5),
    (2, '2412130084', 'Sanduíche Natural', '2025-03-21 11:20:00', 23.39, 5),
    (2, '2422130049', 'Sanduíche Natural', '2025-03-21 13:30:00', 12.99, 3);

    select * from compra_cantina;

    drop table IF EXISTS cartao_aluno CASCADE;
	drop table IF EXISTS sala_estudo CASCADE;
	drop table IF EXISTS emprestimo CASCADE;
	drop table IF EXISTS catraca CASCADE;
	drop table IF EXISTS desconto CASCADE;
	DROP TABLE IF EXISTS cantina CASCADE;
	DROP TABLE IF EXISTS compra_cantina CASCADE;
DROP TABLE IF EXISTS estacionamento CASCADE;
DROP TABLE IF EXISTS estacionamento_uso CASCADE;
DROP TABLE IF EXISTS estabelecimento CASCADE;
DROP TABLE IF EXISTS estabelecimento_desconto CASCADE;


    UPDATE estacionamento_uso SET valor_pago = 1 WHERE id_uso = 1;
	DELETE FROM desconto WHERE id_desconto = 6;


--procurando onde os descontos foram utilizados e quem os gerou
	SELECT 
    e.nome AS estabelecimento,
    e.tipo,
    d.percentual_desconto,
    ca.nome AS aluno_beneficiario
FROM estabelecimento e
JOIN estabelecimento_desconto ed ON e.id_estabelecimento = ed.id_estabelecimento
JOIN desconto d ON ed.id_desconto = d.id_desconto
JOIN cartao_aluno ca ON d.matricula = ca.matricula;

--mostra quais descontos cada aluno gerou
SELECT 
    ca.nome AS aluno,
    ca.matricula,
    d.percentual_desconto || '%' AS desconto,
    d.id_desconto
FROM cartao_aluno ca
INNER JOIN desconto d ON ca.matricula = d.matricula
ORDER BY ca.nome, d.percentual_desconto DESC;

--procura qual catraca cada aluno passou e qual horario
SELECT 
    ca.nome AS aluno,
    ca.matricula,
    cat.id_catraca,
    cat.data_presença AS data,
    cat.hora_entrada,
    cat.hora_saida,
    CONCAT(cat.data_presença, ' ', cat.hora_entrada, ' às ', cat.hora_saida) AS periodo_completo
FROM cartao_aluno ca
INNER JOIN catraca cat ON ca.matricula = cat.matricula
ORDER BY cat.data_presença, cat.hora_entrada;




	

*/