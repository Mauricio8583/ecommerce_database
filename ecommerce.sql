Create database if not exists bd_ecommerce;
use bd_ecommerce;
Create table if not exists cliente(
id_cliente int auto_increment primary key,
Pnome varchar(10),
Nome_meio varchar(4),
Sobrenome varchar(20),
CPF varchar(11) unique not null,
Endereço varchar(45),
Data_nascimento date
);

Create table if not exists produto(
id_produto int auto_increment primary key,
Nome varchar(25),
Categoria enum('Eletronico', 'Vestimenta', 'Brinquedos', 'Alimentos'),
Classificado_criancas bool
);

Create table if not exists pagamento(
id_pagamento int,
id_cliente_pagamento int,
Limite float,
Tipo_pagamento enum('Boleto', 'Cartão', 'Dois Cartões'),
primary key (id_pagamento, id_cliente_pagamento)
);

Create table if not exists pedido(
id_pedido int auto_increment primary key,
Status_pedido enum('Cancelado', 'Confirmado', 'Em processamento') not null,
Descricao varchar(255),
Frete_valor float default 0,
Pagamento_dinheiro bool default false,
id_pedido_cliente int,
constraint fk_pedido_cliente foreign key (id_pedido_cliente) references cliente (id_cliente)
);

Create table if not exists estoque(
id_estoque int auto_increment primary key,
Endereço varchar(45),
Quantidade int
);

Create table if not exists fornecedor(
id_fornecedor int auto_increment primary key,
Razao_social varchar(255) not null,
CNPJ char(15) not null unique,
Contato varchar(10)
);

Create table if not exists vendedor(
id_vendedor int auto_increment primary key,
Nome_social varchar(255),
CNPJ char(15) unique,
CPF char(9) unique,
Localizacao varchar(255)
);

Create table if not exists produto_vendedor(
id_produto_vendedor int,
id_produto int,
Quantidade int default 1,
primary key (id_produto_vendedor, id_produto),
constraint fk_produto_vendedor foreign key (id_produto_vendedor) references vendedor(id_vendedor),
constraint fk_produto foreign key (id_produto) references produto(id_produto)
);

Create table if not exists produto_pedido(
id_produto_pedido int,
id_pedido int,
Quantidade int default 1,
pStatus enum('Disponível', 'Sem estoque') default 'Disponível',
primary key (id_produto_pedido, id_pedido),
constraint fk_produto_pedido foreign key (id_produto_pedido) references produto(id_produto),
constraint fk_pedido foreign key (id_pedido) references pedido(id_pedido)
);

Create table if not exists produto_estoque(
id_produto_estoque int,
id_estoque int,
Endereço varchar(255) not null,
primary key (id_produto_estoque, id_estoque),
constraint fk_produto_estoque foreign key (id_produto_estoque) references produto(id_produto),
constraint fk_estoque foreign key (id_estoque) references estoque(id_estoque)
);

