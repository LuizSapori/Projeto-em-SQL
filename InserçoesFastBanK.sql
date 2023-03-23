
-- Criação do Banco
CREATE DATABASE FastBank
GO

-- Conexão com o Banco
USE Fastbank
GO

-- Tabela Cliente isolada (sem relacionamento)
CREATE TABLE Cliente(
	codigo INT IDENTITY,
	codigoEndereco INT NOT NULL,
	nome_razaoSocial VARCHAR(100) NOT NULL,
	nomeSocial_fantasia VARCHAR(100),
	foto_logo VARCHAR(100) NOT NULL,
	dataNascimento_abertura DATE NOT NULL,
	usuario CHAR(10) NOT NULL,
	senha INT  NOT NULL,
	CONSTRAINT PK_Cliente PRIMARY KEY(codigo),
	CONSTRAINT UK_Cliente_usuario UNIQUE(usuario)
)
GO


-- Inserção de dados para todos os atributos
INSERT INTO Cliente
	(codigoEndereco, nome_razaoSocial, nomeSocial_fantasia, foto_logo, dataNascimento_abertura, usuario, senha) -- atributos
VALUES
	(0, 'Alice Barbalho Vilalobos', 'Alice Vilalobos', '\foto\2.jpg', '17/05/1992', 'alice', 987) -- valores
GO

-- Consulta geral
SELECT * FROM Cliente


-- Inserção somente dos dados obrigatórios
INSERT INTO Cliente
	(codigoEndereco, nome_razaoSocial, foto_logo, dataNascimento_abertura, usuario, senha) -- atributos
VALUES
	(0, 'Sheila Tuna Espírito Santo', '\foto\4.jpg', '05/03/1980', 'sheila', 123) -- valores
GO

-- Consulta geral
SELECT * FROM Cliente


-- Inserção somente dos dados obrigatórios
INSERT INTO Cliente
	(nome_razaoSocial, foto_logo, dataNascimento_abertura, usuario, senha) -- atributos
VALUES
	('Abigail Barateiro Cangueiro', '\foto\6.jpg', '30/07/1987', 'abigail', 147) -- valores
GO
/* Não é possível inserir o valor NULL na coluna 'codigoEndereco', tabela 'FastBank.dbo.Cliente'; 
   a coluna não permite nulos. Falha em INSERT. */

-- Consulta geral
SELECT * FROM Cliente



-- Quantidade de atributos e valores diferentes
INSERT INTO Cliente
	(codigoEndereco, nome_razaoSocial, foto_logo, dataNascimento_abertura, usuario, senha) -- atributos
VALUES
	('Abigail Barateiro Cangueiro', '\foto\6.jpg', '30/07/1987', 'abigail', 147) -- valores
GO
/* Existem mais colunas na instrução INSERT do que valores especificados na cláusula VALUES. 
   O número de valores da cláusula VALUES deve corresponder ao número de colunas especificado na instrução INSERT. */

-- Consulta geral
SELECT * FROM Cliente



-- Inserção correta
INSERT INTO Cliente
	(codigoEndereco, nome_razaoSocial, foto_logo, dataNascimento_abertura, usuario, senha) -- atributos
VALUES
	(10, 'Abigail Barateiro Cangueiro', '\foto\6.jpg', '30/07/1987', 'abigail', 147) -- valores
GO

-- Consulta geral
SELECT * FROM Cliente

/* Obs.: Quando um INSERT "falha", a chave primária também é incrementada pelo IDENTITY
         (pulando um número por falha). */



-- Inserção com valor do atributo UNIQUE duplicado
INSERT INTO Cliente
	(codigoEndereco, nome_razaoSocial, nomeSocial_fantasia, foto_logo, dataNascimento_abertura, usuario, senha) -- atributos
VALUES
	(10, 'Regina e Julia Entregas Expressas ME', 'Entregas Express', '\fotos\8.jpg', '11/03/2018', 'alice', 987) -- valores
GO
/* Violação da restrição UNIQUE KEY 'UK_Cliente_usuario'. 
   Não é possível inserir a chave duplicada no objeto 'dbo.Cliente'. 
   O valor de chave duplicada é (alice     ). */

-- Consulta geral
SELECT * FROM Cliente
	 

-- Inserção de dados em lote com descrição dos campos
INSERT INTO Cliente
	(codigoEndereco, nome_razaoSocial, foto_logo, dataNascimento_abertura, usuario, senha) -- atributos
VALUES
	(10, 'Regina e Julia Entregas Expressas ME', '\fotos\8.jpg', '11/03/2018', 'express', 987),  -- valores
	(20, 'João Barbalho Vilalobos', '\fotos\10.jpg', '15/06/1990', 'joao', 357),
	(30, 'Juan e Valentina Alimentos ME', '\fotos\12.jpg','12/11/2015', 'avenida', 258)
GO

-- Consulta geral
SELECT * FROM Cliente
GO


INSERT INTO Cliente
VALUES (40, 'Derek Bicudo Lagos', '', '\fotos\10.jpg', '12/03/2002', 'derek', 258),
	   (50, 'Marcelo Frois Caminha', 'Ana Maria', '\fotos\12.jpg', '23/11/2001', 'ana', 654),   
       (60, 'Gabriel e Marcelo Corretores Associados Ltda', 'Imobiliária Cidade', '\fotos\18.jpg', '26/09/2017', 'cidade', 474)

-- Consulta geral
SELECT * FROM Cliente
GO


-------------------------------------------------------------------------------------------------
-- Restrições de relacionamento

-- DROP TABLE Cliente


CREATE TABLE Endereco(
	codigo INT IDENTITY,
	logradouro VARCHAR(100) NOT NULL,
	bairro VARCHAR(75) NOT NULL,
	cidade VARCHAR(75) NOT NULL,
	uf CHAR(2) NOT NULL,
	cep CHAR(10) NOT NULL,
	CONSTRAINT PK_Endereco PRIMARY KEY(codigo)
)
GO

CREATE TABLE Cliente(
	codigo INT IDENTITY,
	codigoEndereco INT NOT NULL,
	nome_razaoSocial VARCHAR(100) NOT NULL,
	nomeSocial_fantasia VARCHAR(100),
	foto_logo VARCHAR(100) NOT NULL,
	dataNascimento_abertura DATE NOT NULL,
	usuario CHAR(10) NOT NULL,
	senha INT  NOT NULL,
	CONSTRAINT PK_Cliente PRIMARY KEY(codigo),
	CONSTRAINT UK_Cliente_usuario UNIQUE(usuario),
	CONSTRAINT FK_Cliente_Endereco FOREIGN KEY(codigoEndereco) REFERENCES Endereco(codigo)
)
GO


/*  *** Dados do Cliente *** 
	Nome: Alice Barbalho Vilalobos
	Nome social: Alice Vilalobos
	Endereço: Avenida Cristiano Olsen, 10
	Bairro: Jardim Sumaré
	Cidade: Araçatuba
	Estado: SP
	CEP: 16015244
	Foto: \foto\2.jpg
	Data de nascimento: 17/05/1992
	Usuario: alice
	Senha: 987
*/

-- Pra inserção de um cliente seu endereço já deve existir
-- Endereco(1,1) <-> (1,n)Cliente

INSERT INTO Endereco
	(logradouro, bairro, cidade, uf, cep)
VALUES
	('Avenida Cristiano Olsen, 10', 'Jardim Sumaré', 'Araçatuba','SP','16015244')
GO
	
INSERT INTO Cliente
	(codigoEndereco, nome_razaoSocial, nomeSocial_fantasia, foto_logo, dataNascimento_abertura, usuario, senha) -- atributos
VALUES
	(1, 'Alice Barbalho Vilalobos', 'Alice Vilalobos', '\foto\2.jpg', '17/05/1992', 'alice', 987) -- valores
GO

/* A instrução INSERT conflitou com a restrição do FOREIGN KEY "FK_Cliente_Endereco". 
   O conflito ocorreu no banco de dados "FastBank", tabela "dbo.Endereco", column 'codigo'. */

SELECT * FROM Endereco
SELECT * FROM Cliente



-------------------------------------------------------------------------------------------------
-- Restrições de CHECK


CREATE TABLE Conta(
	codigo INT IDENTITY,	
	agencia VARCHAR(15) NOT NULL,
	numero VARCHAR(25) NOT NULL,
	tipo VARCHAR(30) NOT NULL,
	limite SMALLMONEY NOT NULL,
	ativa BIT NOT NULL,
	CONSTRAINT PK_Conta PRIMARY KEY(codigo),
	CONSTRAINT CHK_Conta_tipo CHECK (tipo = 'corrente' OR tipo = 'investimento')
)
GO


INSERT INTO Conta
	(agencia, numero, tipo,	limite,	ativa)
VALUES
	('01470', '1234568', 'corrente', 3000.00, 1),
	('03695', '4567893', 'investimento', 0.00, 0)
GO

SELECT * FROM Conta


INSERT INTO Conta
	(agencia, numero, tipo,	limite,	ativa)
VALUES
	('01470', '1234568', 'aplicacao', 3000.00, 1)
GO
 /* A instrução INSERT conflitou com a restrição do CHECK "CHK_Conta_tipo". 
    O conflito ocorreu no banco de dados "FastBank", tabela "dbo.Conta", column 'tipo'. */



-------------------------------------------------------------------------------------------------
-- Exclusão em cascata

CREATE TABLE Contato(
	codigo INT IDENTITY,
	codigoCliente INT NOT NULL,
	numero VARCHAR(15) NOT NULL,
	ramal VARCHAR(25),
	email VARCHAR(50),
	observacao VARCHAR(50),
	CONSTRAINT PK_Contato PRIMARY KEY(codigo),
	CONSTRAINT FK_Contato_Cliente FOREIGN KEY(codigoCliente) 
	                              REFERENCES Cliente(codigo)
								  ON UPDATE CASCADE
								  ON DELETE CASCADE
)
GO

SELECT * FROM Endereco
SELECT * FROM Cliente


-- Para inserir um Contato o Cliente já deve existir
-- Contato(1,n) <-> (1,1)Cliente

INSERT INTO Contato
	(codigoCliente, numero, ramal, email, observacao)
VALUES
	(2, '(19)  3754-8198', 'Ramal 12', 'alice@gmail.com', 'Comercial')


INSERT INTO Contato
	(codigoCliente, numero, email, observacao)
VALUES
	(2, '(19) 98756-2568', 'alice@gmail.com', 'Pessoal')


SELECT * FROM Endereco
SELECT * FROM Cliente
SELECT * FROM Contato


-- Tentativa de exclusão de registro relacionado
DELETE FROM Endereco
WHERE codigo = 1 

/* A instrução DELETE conflitou com a restrição do REFERENCE "FK_Cliente_Endereco". 
   O conflito ocorreu no banco de dados "FastBank", tabela "dbo.Cliente", column 'codigoEndereco'.*/

SELECT * FROM Endereco
SELECT * FROM Cliente
SELECT * FROM Contato


--  Exclusão ocorre na tabela Cliente e também (por cascata) na tabela Contato (registros relacionados)
DELETE FROM Cliente
WHERE codigo = 2 

SELECT * FROM Endereco
SELECT * FROM Cliente
SELECT * FROM Contato
