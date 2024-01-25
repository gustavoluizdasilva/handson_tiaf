CREATE TABLE IF NOT EXISTS Cliente (
  id_cliente SERIAL PRIMARY KEY,
  nome VARCHAR(100),
  cpf VARCHAR(11) UNIQUE,
  data_nascimento DATE
);

CREATE TABLE IF NOT EXISTS Carro (
  id_carro SERIAL PRIMARY KEY,
  modelo VARCHAR(50),
  data_lancamento DATE
);


CREATE TABLE IF NOT EXISTS Venda (
  id_venda SERIAL PRIMARY KEY,
  id_cliente INT,
  id_carro INT,
  data_venda DATE,
  valor_venda NUMERIC(13,2),
  FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
  FOREIGN KEY (id_carro) REFERENCES Carro(id_carro)
);
