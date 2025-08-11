CREATE DATABASE TrabalhoBD;
USE TrabalhoBD;

CREATE TABLE Cidade
(
    idCidade INTEGER AUTO_INCREMENT NOT NULL,
    nome VARCHAR(45) NOT NULL,
    uf VARCHAR(2) NOT NULL,
    CONSTRAINT pkCidade PRIMARY KEY (idCidade)
);

CREATE TABLE Endereco
(
    idEndereco INTEGER AUTO_INCREMENT NOT NULL,
    idCidade INTEGER NOT NULL,
    logradouro VARCHAR(45) NOT NULL,
    bairro VARCHAR(45) NOT NULL,
    numero VARCHAR(45) NOT NULL,
    complemento VARCHAR(45) NOT NULL,
    CONSTRAINT pkEndereco PRIMARY KEY (idEndereco),
    CONSTRAINT fkEnderecoCidade FOREIGN KEY (idCidade) REFERENCES Cidade(idCidade)
);

CREATE TABLE Pessoa
(
    idPessoa INTEGER AUTO_INCREMENT NOT NULL,
    idEndereco INTEGER NOT NULL,
    nome VARCHAR(45) NOT NULL,
    telefone VARCHAR(45) NOT NULL,
    sexo VARCHAR(45) NOT NULL,
    cpf VARCHAR(16) NOT NULL,
    CONSTRAINT pkPessoa PRIMARY KEY (idPessoa),
    CONSTRAINT fkPessoaEndereco FOREIGN KEY (idEndereco) REFERENCES Endereco(idEndereco)
        ON DELETE CASCADE
);

CREATE TABLE Patrocinador
(
    idPatrocinador INTEGER AUTO_INCREMENT NOT NULL,
    idEndereco INTEGER NOT NULL,
    nome VARCHAR(45) NOT NULL,
    tipo VARCHAR(45) NOT NULL,
    telefone VARCHAR(45) NOT NULL,
    cnpj VARCHAR(45) NOT NULL,
    CONSTRAINT pkPatrocinador PRIMARY KEY (idPatrocinador),
    CONSTRAINT fkPatrocinadorEndereco FOREIGN KEY (idEndereco) REFERENCES Endereco(idEndereco)
);

CREATE TABLE DoacaoCNPJ
(
    idDoacao INTEGER AUTO_INCREMENT NOT NULL,
    idPatrocinador INTEGER NOT NULL,
    valor FLOAT NOT NULL,
    dataDoacao DATE NOT NULL,
    tipo VARCHAR(45) NOT NULL,
    formaPagamento VARCHAR(45) NOT NULL,
    CONSTRAINT pkDoacaoCNPJ PRIMARY KEY (idDoacao),
    CONSTRAINT fkDoacaoCNPJPatrocinador FOREIGN KEY (idPatrocinador) REFERENCES Patrocinador(idPatrocinador)
);

CREATE TABLE DoacaoCPF
(
    idDoacao INTEGER AUTO_INCREMENT NOT NULL,
    idPessoa INTEGER NOT NULL,
    valor FLOAT NOT NULL,
    dataDoacao DATE NOT NULL,
    tipo VARCHAR(45) NOT NULL,
    formaPagamento VARCHAR(45) NOT NULL,
    CONSTRAINT pkDoacaoCPF PRIMARY KEY (idDoacao),
    CONSTRAINT fkDoacaoCPFPessoa FOREIGN KEY (idPessoa) REFERENCES Pessoa(idPessoa)
        ON DELETE CASCADE
);

CREATE TABLE Adotante
(
    idAdotante INTEGER AUTO_INCREMENT NOT NULL,
    idPessoa INTEGER NOT NULL,
    rendaMensal FLOAT NOT NULL,
    tipoMoradia VARCHAR(45) NOT NULL,
    possuiAnimais TINYINT NOT NULL,
    experienciaAnterior TINYINT NOT NULL,
    CONSTRAINT pkAdotante PRIMARY KEY (idAdotante),
    CONSTRAINT fkAdotantePessoa FOREIGN KEY (idPessoa) REFERENCES Pessoa(idPessoa)
        ON DELETE CASCADE
);

CREATE TABLE Veterinario
(
    idVeterinario INTEGER AUTO_INCREMENT NOT NULL,
    idPessoa INTEGER NOT NULL,
    CRMV VARCHAR(45) NOT NULL,
    CONSTRAINT pkVeterinario PRIMARY KEY (idVeterinario),
    CONSTRAINT fkVeterinarioPessoa FOREIGN KEY (idPessoa) REFERENCES Pessoa(idPessoa)
        ON DELETE CASCADE
);

CREATE TABLE Castracao
(
    idCastracao INTEGER AUTO_INCREMENT NOT NULL,
    datah DATE NOT NULL,
    idVeterinario INTEGER NOT NULL,
    CONSTRAINT pkCastracao PRIMARY KEY (idCastracao),
    CONSTRAINT fkCastracaoVeterinario FOREIGN KEY (idVeterinario) REFERENCES Veterinario(idVeterinario)
);

CREATE TABLE Animal
(
    idAnimal INTEGER AUTO_INCREMENT NOT NULL,
    idCastracao INTEGER,
    nome VARCHAR(45) NOT NULL,
    tipo VARCHAR(45) NOT NULL,
    sexo CHAR(1) NOT NULL,
    porte VARCHAR(45) NOT NULL,
    statusSaude VARCHAR(45) NOT NULL,
    necessidadesEspeciais VARCHAR(45) NOT NULL,
    raca VARCHAR(45) NOT NULL,
    CONSTRAINT pkAnimal PRIMARY KEY (idAnimal),
    CONSTRAINT fkAnimalCastracao FOREIGN KEY (idCastracao) REFERENCES Castracao(idCastracao)
);

CREATE TABLE Apadrinhamento
(
    idApadrinhamento AUTO_INCREMENT INTEGER NOT NULL,
    idPessoa INTEGER NOT NULL,
    idAnimal INTEGER NOT NULL,
    dataInicio DATE NOT NULL,
    valorMensal FLOAT NOT NULL,
    tipo VARCHAR(45) NOT NULL,
    dataFim DATE,
    CONSTRAINT pkApadrinhamento PRIMARY KEY (idApadrinhamento),
    CONSTRAINT fkApadrinhamentoPessoa FOREIGN KEY (idPessoa) REFERENCES Pessoa(idPessoa)
        ON DELETE CASCADE,
    CONSTRAINT fkApadrinhamentoAnimal FOREIGN KEY (idAnimal) REFERENCES Animal(idAnimal)
);

CREATE TABLE Resgate
(
    idResgate INTEGER AUTO_INCREMENT NOT NULL,
    idEndereco INTEGER NOT NULL,
    idAnimal INTEGER NOT NULL,
    idPessoa INTEGER NOT NULL,
    dataResgate DATE NOT NULL,
    descricao VARCHAR(45) NOT NULL,
    CONSTRAINT pkResgate PRIMARY KEY (idResgate),
    CONSTRAINT fkResgateEndereco FOREIGN KEY (idEndereco) REFERENCES Endereco(idEndereco),
    CONSTRAINT fkResgateAnimal FOREIGN KEY (idAnimal) REFERENCES Animal(idAnimal),
    CONSTRAINT fkResgatePessoa FOREIGN KEY (idPessoa) REFERENCES Pessoa(idPessoa)
        ON DELETE CASCADE
);

CREATE TABLE Adocao
(
    idAdocao INTEGER AUTO_INCREMENT NOT NULL,
    idAdotante INTEGER NOT NULL,
    idAnimal INTEGER NOT NULL,
    datah DATE NOT NULL,
    statusAdocao VARCHAR(45) NOT NULL,
    CONSTRAINT pkAdocao PRIMARY KEY (idAdocao),
    CONSTRAINT fkAdocaoAdotante FOREIGN KEY (idAdotante) REFERENCES Adotante(idAdotante),
    CONSTRAINT fkAdocaoAnimal FOREIGN KEY (idAnimal) REFERENCES Animal(idAnimal)
);

CREATE TABLE Tratamento
(
    idTratamento INTEGER AUTO_INCREMENT NOT NULL,
    idAnimal INTEGER NOT NULL,
    idVeterinario INTEGER NOT NULL,
    tipo VARCHAR(45) NOT NULL,
    dataInicio DATE NOT NULL,
    dataFim DATE,
    descricao VARCHAR(45) NOT NULL,
    custo FLOAT NOT NULL,
    CONSTRAINT pkTratamento PRIMARY KEY (idTratamento),
    CONSTRAINT fkTratamentoAnimal FOREIGN KEY (idAnimal) REFERENCES Animal(idAnimal),
    CONSTRAINT fkTratamentoVeterinario FOREIGN KEY (idVeterinario) REFERENCES Veterinario(idVeterinario)
);

CREATE TABLE Usuario
(
    idUsuario INTEGER AUTO_INCREMENT NOT NULL,
    idPessoa INTEGER NOT NULL,
    nomeUsuario VARCHAR(45) NOT NULL,
    senha VARCHAR(45) NOT NULL,
    administrador TINYINT NOT NULL,
    CONSTRAINT pkUsuario PRIMARY KEY (idUsuario),
    CONSTRAINT fkUsuarioPessoa FOREIGN KEY (idPessoa) REFERENCES Pessoa(idPessoa)
        ON DELETE CASCADE
);
