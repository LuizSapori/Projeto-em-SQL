
--Criação do banco

CREATE DATABASE FastBank
GO

--Excluir banco de dados
/*DROP DATABASE FastBank
GO*/

USE FastBank
Go


-- Criação do Banco
CREATE DATABASE FastBank
GO

-- Conexão com o Banco
USE FastBank
GO

-- Criação das tabelas com suas respectivas restrições (constraints)

-- Tabelas que não possuem chave estrangeira

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


CREATE TABLE Conta(
	codigo INT IDENTITY,
	agencia VARCHAR(15) NOT NULL,
	numero VARCHAR(25) NOT NULL,
	tipo VARCHAR(30) NOT NULL,
	limite SMALLMONEY NOT NULL,
	ativa BIT NOT NULL,
	CONSTRAINT PK_Conta PRIMARY KEY(codigo),
	CONSTRAINT CHK_Conta_tipo CHECK (tipo = 'corrente' 
	                              OR tipo = 'investimento')
)
GO

-- Nas tabelas com chave estrangeira criar primeiro a tabela 
-- com a respectiva chave primária relacionada



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
	CONSTRAINT FK_Cliente_Endereco FOREIGN KEY (codigoEndereco) 
                                   REFERENCES Endereco (codigo)
)
GO


CREATE TABLE Contato(
	codigo INT IDENTITY,
	codigoCliente INT NOT NULL,
	numero VARCHAR(15) NOT NULL,
	ramal VARCHAR(25),
	email VARCHAR(50),
	observacao VARCHAR(50),
	CONSTRAINT PK_Contato PRIMARY KEY(codigo),
	CONSTRAINT FK_Contato_Cliente FOREIGN KEY (codigoCliente) 
                                  REFERENCES Cliente (codigo)
)
GO


CREATE TABLE ClientePF(
	codigo INT,
	cpf VARCHAR(15) NOT NULL,
	rg VARCHAR(15) NOT NULL,
	CONSTRAINT PK_ClientePF PRIMARY KEY(codigo),
	CONSTRAINT UK_ClientePF_cpf UNIQUE(cpf),
	CONSTRAINT UK_ClientePF_rg UNIQUE(rg),
	CONSTRAINT FK_Codigo_PF FOREIGN KEY (codigo) 
                            REFERENCES Cliente (codigo)
	-- Foreing key é o atributo codigo
)
GO


CREATE TABLE ClientePJ(
	codigo INT,
	cnpj VARCHAR(15) NOT NULL,
	inscricaoMunicipal VARCHAR(30) NOT NULL,
	inscricaoEstadual VARCHAR(30),
	CONSTRAINT PK_ClientePJ PRIMARY KEY(codigo),
	CONSTRAINT UK_ClientePJ_cnpj UNIQUE(cnpj),
	CONSTRAINT UK_ClientePJ_im UNIQUE(inscricaoMunicipal),
	CONSTRAINT FK_Codigo_PJ FOREIGN KEY (codigo) 
                            REFERENCES Cliente (codigo)
	-- Foreing key é o atributo codigo
)
GO



CREATE TABLE Cartao(
	codigo INT IDENTITY,
	codigoConta INT NOT NULL,
	numero VARCHAR(30) NOT NULL,
	cvv VARCHAR(5) NOT NULL,
	validade DATE NOT NULL,
	bandeira VARCHAR(20) NOT NULL,
	situacao VARCHAR(20) NOT NULL,
	CONSTRAINT PK_Cartao PRIMARY KEY(codigo),
	CONSTRAINT UK_Cartao_numero UNIQUE(numero),
	CONSTRAINT FK_Cartao_Conta FOREIGN KEY(codigoConta) 
	                           REFERENCES Conta(codigo)
)
GO


CREATE TABLE Movimentacao(
	codigo INT IDENTITY,
	codigoCartao INT NOT NULL,
	dataHora DATETIME NOT NULL,
	operacao VARCHAR(20) NOT NULL,
	valor SMALLMONEY NOT NULL,
	CONSTRAINT PK_Movimentacao PRIMARY KEY(codigo),
	CONSTRAINT CHK_Movimentacao_operacao CHECK (operacao = 'debito' 
	                                         OR operacao = 'credito' 
								             OR operacao = 'transferencia'),
   CONSTRAINT FK_Movimentacao_Cartao FOREIGN KEY (codigoCartao) 
                                     REFERENCES Cartao (codigo) 
)
GO


CREATE TABLE Emprestimo(
	codigo INT IDENTITY,
	codigoConta INT NOT NULL,
	dataSolicitacao DATE NOT NULL,
	valorSolicitado SMALLMONEY NOT NULL,
	juros FLOAT NOT NULL,
	aprovado BIT NOT NULL,
	numeroParcela INT,
	dataAprovacao DATE,
	observacao VARCHAR(20),
	CONSTRAINT PK_Emprestimo PRIMARY KEY(codigo),
	CONSTRAINT FK_Emprestimo_Conta FOREIGN KEY (codigoConta) 
                                   REFERENCES Conta (codigo)
)
GO


CREATE TABLE EmprestimoParcela(
	codigo INT IDENTITY,
	codigoEmprestimo INT NOT NULL,
	numero INT NOT NULL,
	dataVencimento DATE NOT NULL,
	valorParcela SMALLMONEY NOT NULL,
	dataPagamento DATE,
	valorPago SMALLMONEY,
	CONSTRAINT PK_EmprestimoParcela PRIMARY KEY(codigo),
	CONSTRAINT FK_EmprestimoParcela_Emprestimo FOREIGN KEY (codigoEmprestimo) 
                                               REFERENCES Emprestimo (codigo)
)
GO


CREATE TABLE Investimento(
	codigo INT IDENTITY,
	codigoConta INT NOT NULL,
	tipo VARCHAR(30) NOT NULL,
	aporte SMALLMONEY NOT NULL,
	taxaAdministracao FLOAT NOT NULL,
	prazo VARCHAR(20) NOT NULL,
	grauRisco CHAR(5) NOT NULL,
	rentabilidade SMALLMONEY,
	finalizado BIT NOT NULL,
	CONSTRAINT PK_Investimento PRIMARY KEY(codigo),
	CONSTRAINT FK_Investimento_Conto FOREIGN KEY (codigoConta) 
                                     REFERENCES Conta (codigo)
)
GO

CREATE TABLE ClienteConta(
  codigoCliente INT,
  codigoConta INT,
  CONSTRAINT PK_codigo PRIMARY KEY (codigoCliente,codigoConta),
  CONSTRAINT FK_Cliente FOREIGN KEY (codigoCliente)               
  REFERENCES Cliente (codigo),
  CONSTRAINT FK_Conta FOREIGN KEY (codigoConta)
                      REFERENCES Conta (codigo)
  )
  Go


--Excluir tabela

--DROP TABLE Investimento
--DROP TABLE Cliente
--DROP TABLE Contato
--DROP TABLE Endereco
--DROP TABLE ClientePF
--DROP TABLE ClientePJ
--DROP TABLE Conta
--DROP TABLE Cartao
--DROP TABLE Movimentacao
--DROP TABLE Investimento
--DROP TABLE Emprestimo
--DROP TABLE EmprestimoParcela
--GO
