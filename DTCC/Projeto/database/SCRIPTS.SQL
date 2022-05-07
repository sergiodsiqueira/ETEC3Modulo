--Clientes
CREATE TABLE "clientes" (
	"id" SERIAL NOT NULL,
	"nome" VARCHAR(100) NOT NULL,
	"email" VARCHAR(50) NOT NULL,
	"data_nascimento" DATE NULL DEFAULT NULL,
	"telefone_principal" VARCHAR(11) NULL DEFAULT NULL,
	"telefone_secundario" VARCHAR(11) NULL DEFAULT NULL,
	"end_logradouro" VARCHAR(100) NULL DEFAULT NULL,
	"end_bairro" VARCHAR(50) NULL DEFAULT NULL,
	"end_cidade" VARCHAR(50) NULL DEFAULT NULL,
	"end_estado" VARCHAR(2) NULL DEFAULT NULL,
	"end_CEP" CHAR(8) NULL DEFAULT NULL,
	"end_pais" VARCHAR(30) NULL DEFAULT NULL,
	"doc_CPF" CHAR(11) NULL DEFAULT NULL,
	"doc_RG" CHAR(11) NULL DEFAULT NULL,
	"redesocial_1" VARCHAR(100) NULL DEFAULT NULL,
	"redesocial_2" VARCHAR(100) NULL DEFAULT NULL,
	PRIMARY KEY ("id")
)
;
COMMENT ON COLUMN "clientes"."id" IS '';
COMMENT ON COLUMN "clientes"."nome" IS '';
COMMENT ON COLUMN "clientes"."email" IS '';
COMMENT ON COLUMN "clientes"."data_nascimento" IS '';
COMMENT ON COLUMN "clientes"."telefone_principal" IS '';
COMMENT ON COLUMN "clientes"."telefone_secundario" IS '';
COMMENT ON COLUMN "clientes"."end_logradouro" IS '';
COMMENT ON COLUMN "clientes"."end_bairro" IS '';
COMMENT ON COLUMN "clientes"."end_cidade" IS '';
COMMENT ON COLUMN "clientes"."end_estado" IS '';
COMMENT ON COLUMN "clientes"."end_CEP" IS '';
COMMENT ON COLUMN "clientes"."end_pais" IS '';
COMMENT ON COLUMN "clientes"."doc_CPF" IS '';
COMMENT ON COLUMN "clientes"."doc_RG" IS '';
COMMENT ON COLUMN "clientes"."redesocial_1" IS '';
COMMENT ON COLUMN "clientes"."redesocial_2" IS '';

--Usuarios
CREATE TABLE "usuarios" (
	"id" SERIAL NOT NULL,
	"login" VARCHAR(100) UNIQUE NOT NULL,
	"senha" VARCHAR(20) NOT NULL,
	"tipo" CHAR(1) NOT NULL DEFAULT 'U',
	"id_cliente" INTEGER NULL DEFAULT NULL,
	PRIMARY KEY ("id"),
	UNIQUE INDEX "usuarios_login_key" ("login")
)
;
COMMENT ON COLUMN "usuarios"."id" IS '';
COMMENT ON COLUMN "usuarios"."login" IS '';
COMMENT ON COLUMN "usuarios"."senha" IS '';
COMMENT ON COLUMN "usuarios"."tipo" IS 'U - User | A- Admin';
COMMENT ON COLUMN "usuarios"."id_cliente" IS '';


