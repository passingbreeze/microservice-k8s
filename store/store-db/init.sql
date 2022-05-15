CREATE TABLE `product` (
    `product_id` BINARY(16)  NOT NULL,
    `sku` varchar(200)  NOT NULL,
    `name` varchar(200)  NOT NULL ,
    `price` int  NOT NULL ,
    `stock` int  NOT NULL ,
    `factory_id` BINARY(16)  NOT NULL ,
    `ad_id` BINARY(16)  NOT NULL ,
    PRIMARY KEY (
        `product_id`
    ),
    CONSTRAINT `uc_product_sku` UNIQUE (
        `sku`
    ),
    CONSTRAINT `uc_product_name` UNIQUE (
        `name`
    )
);

CREATE TABLE `factory` (
    `factory_id` BINARY(16)  NOT NULL ,
    `identifier` varchar(200)  NOT NULL ,
    `name` varchar(200)  NOT NULL ,
    `manager_email` varchar(200)  NOT NULL ,
    `API` varchar(200)  NOT NULL ,
    PRIMARY KEY (
        `factory_id`
    ),
    CONSTRAINT `uc_factory_name` UNIQUE (
        `name`
    )
);

CREATE TABLE `advertisement` (
    `ad_id` BINARY(16)  NOT NULL ,
    `status` boolean  NOT NULL ,
    `manager_email` varchar(200)  NOT NULL ,
    PRIMARY KEY (
        `ad_id`
    )
);

ALTER TABLE `product` ADD CONSTRAINT `fk_product_factory_id` FOREIGN KEY(`factory_id`)
REFERENCES `factory` (`factory_id`);

ALTER TABLE `product` ADD CONSTRAINT `fk_product_ad_id` FOREIGN KEY(`ad_id`)
REFERENCES `advertisement` (`ad_id`);


INSERT INTO factory(factory_id, identifier, name, manager_email, api) VALUES(UUID_TO_BIN(UUID()),'FF-500293','부산도너츠 공장', 'dob_factory@codeatates.com', '');

INSERT INTO advertisement(ad_id, status, manager_email) VALUES(UUID_TO_BIN(UUID()),true, 'dob_ad@codeatates.com');


SET @factory_uuid = (SELECT
    BIN_TO_UUID(factory_id) as factory_id
FROM factory);

SET @adv_uuid = (SELECT
    BIN_TO_UUID(ad_id) as ad_id
FROM advertisement);

INSERT INTO product(product_id, sku, name, price, stock, factory_id, ad_id)
VALUES(UUID_TO_BIN(UUID()),'CP-502101','부산도너츠', 19900, 3, UUID_TO_BIN(@factory_uuid),
UUID_TO_BIN(@adv_uuid));