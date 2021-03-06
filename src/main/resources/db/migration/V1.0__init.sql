USE `stock_exchange`;

CREATE TABLE IF NOT EXISTS `company`(
    `id` int NOT NULL AUTO_INCREMENT,
    `name` varchar(45) DEFAULT NULL,
    PRIMARY KEY(`id`)
);

CREATE INDEX COMPANY_INDEX ON company(id);

CREATE TABLE IF NOT EXISTS `user`(
    `id` int NOT NULL AUTO_INCREMENT,
    `name` varchar(45) NOT NULL,
    `surname` varchar(45) NOT NULL,
    `username` varchar(45) NOT NULL UNIQUE,
    `password` varchar(120) NOT NULL,
    `role` varchar(45) NOT NULL,
    `money` float(45) NOT NULL,
    `email` varchar(45) NOT NULL,
    PRIMARY KEY(`id`)
);

CREATE INDEX USER_INDEX ON user(id, username, email);

CREATE TABLE IF NOT EXISTS `stock`(
    `id` int NOT NULL AUTO_INCREMENT,
    `company_id` int NOT NULL,
    `user_id` int DEFAULT NULL,
    `amount` int NOT NULL,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`company_id`) REFERENCES `company`(`id`),
    FOREIGN KEY(`user_id`) REFERENCES `user`(`id`)
);

CREATE INDEX STOCK_INDEX ON stock(id, company_id, user_id);

CREATE TABLE IF NOT EXISTS `buy_offer`(
    `id` int NOT NULL AUTO_INCREMENT,
    `company_id` int NOT NULL,
    `user_id` int NOT NULL,
    `max_price` float(45) NOT NULL,
    `start_amount` int NOT NULL,
    `amount` int NOT NULL,
    `date_limit` date NOT NULL,
    `actual` boolean DEFAULT true,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`company_id`) REFERENCES `company`(`id`),
    FOREIGN KEY(`user_id`) REFERENCES `user`(`id`)
);

CREATE INDEX BUY_INDEX ON buy_offer(id, company_id, max_price, actual);

CREATE TABLE IF NOT EXISTS `sell_offer`(
    `id` int NOT NULL AUTO_INCREMENT,
    `user_id` int NOT NULL,
    `stock_id` int NOT NULL,
    `min_price` float(45) NOT NULL,
    `start_amount` int NOT NULL,
    `amount` int NOT NULL,
    `date_limit` date NOT NULL,
    `actual` boolean DEFAULT true,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`user_id`) REFERENCES `user`(`id`),
    FOREIGN KEY(`stock_id`) REFERENCES `stock`(`id`)
);

CREATE INDEX SELL_INDEX ON sell_offer(id);

CREATE TABLE IF NOT EXISTS `transaction`(
    `id` int NOT NULL AUTO_INCREMENT,
    `buy_offer_id` int NOT NULL,
    `sell_offer_id` int NOT NULL,
    `amount` int NOT NULL,
    `price` float(45) NOT NULL,
    `transaction_date` date NOT NULL,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`buy_offer_id`) REFERENCES `buy_offer`(`id`),
    FOREIGN KEY(`sell_offer_id`) REFERENCES `sell_offer`(`id`)
);

CREATE INDEX TRANSACTION_INDEX ON transaction(id);

CREATE TABLE IF NOT EXISTS `stock_rate`(
    `id` int NOT NULL AUTO_INCREMENT,
    `company_id` int NOT NULL,
    `rate` float(45) NOT NULL,
    `date_inc` date NOT NULL,
    `actual` boolean DEFAULT TRUE,
    PRIMARY KEY(`id`)
);

CREATE INDEX STOCK_RATE_INDEX ON stock_rate(id, company_id, actual);

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE stock_rate;
TRUNCATE user;
TRUNCATE transaction;
TRUNCATE stock;
TRUNCATE sell_offer;
TRUNCATE buy_offer;
TRUNCATE company;
SET FOREIGN_KEY_CHECKS = 1;