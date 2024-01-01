------------------------------------------------------------------------------------------------------------------------
CREATE SCHEMA IF NOT EXISTS security;
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS security.users
(
    id                 uuid         NOT NULL,
    email              varchar(255) NOT NULL,
    password           varchar(255) NOT NULL,
    user_creation_date timestamp(6) NOT NULL
);
------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS security.roles
(
    role_id   bigserial    NOT NULL,
    authority varchar(255) NULL
);
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS security.user_role_junction
(
    role_id int8 NOT NULL,
    user_id uuid NOT NULL
);
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
CREATE TABLE oauth2_authorization
(
    id                            varchar(100) NOT NULL,
    registered_client_id          varchar(100) NOT NULL,
    principal_name                varchar(200) NOT NULL,
    authorization_grant_type      varchar(100) NOT NULL,
    authorized_scopes             varchar(1000)     DEFAULT NULL,
    attributes                    character varying DEFAULT NULL,
    state                         varchar(500)      DEFAULT NULL,
    authorization_code_value      character varying DEFAULT NULL,
    authorization_code_issued_at  timestamp         DEFAULT NULL,
    authorization_code_expires_at timestamp         DEFAULT NULL,
    authorization_code_metadata   character varying DEFAULT NULL,
    access_token_value            character varying DEFAULT NULL,
    access_token_issued_at        timestamp         DEFAULT NULL,
    access_token_expires_at       timestamp         DEFAULT NULL,
    access_token_metadata         character varying DEFAULT NULL,
    access_token_type             varchar(100)      DEFAULT NULL,
    access_token_scopes           varchar(1000)     DEFAULT NULL,
    oidc_id_token_value           character varying DEFAULT NULL,
    oidc_id_token_issued_at       timestamp         DEFAULT NULL,
    oidc_id_token_expires_at      timestamp         DEFAULT NULL,
    oidc_id_token_metadata        character varying DEFAULT NULL,
    refresh_token_value           character varying DEFAULT NULL,
    refresh_token_issued_at       timestamp         DEFAULT NULL,
    refresh_token_expires_at      timestamp         DEFAULT NULL,
    refresh_token_metadata        character varying DEFAULT NULL,
    user_code_value               character varying DEFAULT NULL,
    user_code_issued_at           timestamp         DEFAULT NULL,
    user_code_expires_at          timestamp         DEFAULT NULL,
    user_code_metadata            character varying DEFAULT NULL,
    device_code_value             character varying DEFAULT NULL,
    device_code_issued_at         timestamp         DEFAULT NULL,
    device_code_expires_at        timestamp         DEFAULT NULL,
    device_code_metadata          character varying DEFAULT NULL,
    PRIMARY KEY (id)
);
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
CREATE TABLE oauth2_registered_client
(
    id                            varchar(100)                            NOT NULL,
    client_id                     varchar(100)                            NOT NULL,
    client_id_issued_at           timestamp     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    client_secret                 varchar(200)                            DEFAULT NULL,
    client_secret_expires_at      timestamp                               DEFAULT NULL,
    client_name                   varchar(200)                            NOT NULL,
    client_authentication_methods varchar(1000)                           NOT NULL,
    authorization_grant_types     varchar(1000)                           NOT NULL,
    redirect_uris                 varchar(1000)                           DEFAULT NULL,
    scopes                        varchar(1000)                           NOT NULL,
    client_settings               varchar(2000)                           NOT NULL,
    token_settings                varchar(2000)                           NOT NULL,
    PRIMARY KEY (id)
);
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
CREATE TABLE oauth2_authorization_consent
(
    registered_client_id varchar(100)  NOT NULL,
    principal_name       varchar(200)  NOT NULL,
    authorities          varchar(1000) NOT NULL,
    PRIMARY KEY (registered_client_id, principal_name)
);
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS oauth_code
(
    code           VARCHAR(256) PRIMARY KEY,
    authentication BYTEA
);
------------------------------------------------------------------------------------------------------------------------

-- Users Table
------------------------------------------------------------------------------------------------------------------------
ALTER TABLE security.users
    DROP CONSTRAINT IF EXISTS pk_user_id,
    ADD CONSTRAINT pk_user_id PRIMARY KEY (id);

ALTER TABLE security.users
    DROP CONSTRAINT IF EXISTS uq_user_email,
    ADD CONSTRAINT uq_user_email UNIQUE (email);

------------------------------------------------------------------------------------------------------------------------
-- Roles Table
------------------------------------------------------------------------------------------------------------------------

ALTER TABLE security.roles
    DROP CONSTRAINT IF EXISTS pk_roles_id,
    ADD CONSTRAINT pk_roles_id PRIMARY KEY (role_id);

------------------------------------------------------------------------------------------------------------------------
-- User Role Junction Table
------------------------------------------------------------------------------------------------------------------------

ALTER TABLE security.user_role_junction
    DROP CONSTRAINT IF EXISTS pk_user_role_junction_id,
    ADD CONSTRAINT pk_user_role_junction_id PRIMARY KEY (role_id, user_id);

ALTER TABLE security.user_role_junction
    DROP CONSTRAINT IF EXISTS fk_user_role_junction_user_id,
    ADD CONSTRAINT fk_user_role_junction_user_id FOREIGN KEY (user_id) REFERENCES security.users (id),
    DROP CONSTRAINT IF EXISTS fk_user_role_junction_role_id,
    ADD CONSTRAINT fk_user_role_junction_role_id FOREIGN KEY (role_id) REFERENCES security.roles (role_id);
------------------------------------------------------------------------------------------------------------------------