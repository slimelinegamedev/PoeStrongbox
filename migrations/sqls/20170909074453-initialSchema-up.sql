DROP SCHEMA IF EXISTS poe_currency;
CREATE SCHEMA poe_currency;

USE poe_currency;

CREATE TABLE leagues (
  id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name CHAR(255) NOT NULL DEFAULT 'Unkown',
  active TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  _ca TIMESTAMP DEFAULT NOW()
);

CREATE TABLE pulls (
  id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  league_id INTEGER UNSIGNED NOT NULL,
  expires_at TIMESTAMP NOT NULL DEFAULT NOW(),
  _ca TIMESTAMP DEFAULT NOW(),
  CONSTRAINT fk_pulls_leagues FOREIGN KEY (league_id) REFERENCES leagues(id) ON DELETE CASCADE
);

CREATE TABLE currencies (
  id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name CHAR(255) NOT NULL DEFAULT 'Unknown',
  css CHAR(255) NOT NULL DEFAULT 'unknown',
  active TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  _ca TIMESTAMP DEFAULT NOW(), 
  _ua TIMESTAMP DEFAULT NOW() ON UPDATE NOW()
);

CREATE TABLE poe_currency.currency_ratios (
  id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  pull_id INTEGER UNSIGNED NOT NULL,
  currency_from_id INTEGER UNSIGNED NOT NULL,
  currency_to_id INTEGER UNSIGNED NOT NULL,
  ratio DECIMAL(10,4) UNSIGNED NOT NULL DEFAULT 0,
  sellers INTEGER UNSIGNED NOT NULL DEFAULT 0,
  _ca TIMESTAMP DEFAULT NOW(),
  CONSTRAINT fk_currency_ratios_from_currencies FOREIGN KEY (currency_from_id) REFERENCES currencies(id) ON DELETE CASCADE,
  CONSTRAINT fk_currency_ratios_to_currencies FOREIGN KEY (currency_to_id) REFERENCES currencies(id) ON DELETE CASCADE,
  CONSTRAINT fk_currency_ratios_pulls FOREIGN KEY (pull_id) REFERENCES pulls(id) ON DELETE CASCADE
);

USE migrations;