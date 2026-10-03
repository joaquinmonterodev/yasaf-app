-- Reemplaza la tabla de prueba de V1
DROP TABLE app_info;

CREATE TABLE usuario (
                         id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                         email      VARCHAR(255) NOT NULL UNIQUE,
                         nombre     VARCHAR(100) NOT NULL,
                         created_at TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

CREATE TABLE cuenta (
                        id            BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                        usuario_id    BIGINT        NOT NULL REFERENCES usuario(id),
                        nombre        VARCHAR(100)  NOT NULL,
                        tipo          VARCHAR(20)   NOT NULL CHECK (tipo IN ('EFECTIVO', 'BANCO', 'TARJETA')),
                        moneda        CHAR(3)       NOT NULL DEFAULT 'ARS',
                        saldo_inicial NUMERIC(19,2) NOT NULL DEFAULT 0,
                        created_at    TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
                        UNIQUE (usuario_id, nombre)
);

CREATE TABLE categoria (
                           id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                           usuario_id BIGINT       NOT NULL REFERENCES usuario(id),
                           nombre     VARCHAR(100) NOT NULL,
                           tipo       VARCHAR(10)  NOT NULL CHECK (tipo IN ('INGRESO', 'GASTO')),
                           created_at TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
                           UNIQUE (usuario_id, nombre, tipo)
);

CREATE TABLE transaccion (
                             id           BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                             cuenta_id    BIGINT        NOT NULL REFERENCES cuenta(id),
                             categoria_id BIGINT        NOT NULL REFERENCES categoria(id),
                             tipo         VARCHAR(10)   NOT NULL CHECK (tipo IN ('INGRESO', 'GASTO')),
                             monto        NUMERIC(19,2) NOT NULL CHECK (monto > 0),
                             fecha        DATE          NOT NULL,
                             descripcion  VARCHAR(255),
                             created_at   TIMESTAMPTZ   NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_transaccion_cuenta_fecha ON transaccion (cuenta_id, fecha);
CREATE INDEX idx_transaccion_categoria    ON transaccion (categoria_id);