/* dim films */
create table `dim_films`(`dim_film_key` smallint(5) auto_increment,
  `actor_key` smallint(5) unsigned NOT NULL,
  `film_key` smallint(5) unsigned NOT NULL,
  `language_key` tinyint(3) unsigned NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `title` varchar(128) NOT NULL,
  `description` text,
  `release_year` year(4) DEFAULT NULL,
  `rental_duration` tinyint(3) unsigned NOT NULL DEFAULT '3',
  `rental_rate` decimal(4,2) NOT NULL DEFAULT '4.99',
  `length` smallint(5) unsigned DEFAULT NULL,
  `replacement_cost` decimal(5,2) NOT NULL DEFAULT '19.99',
  `rating` enum('G','PG','PG-13','R','NC-17') DEFAULT 'G',
  `special_features` set('Trailers','Commentaries','Deleted Scenes','Behind the Scenes') DEFAULT NULL,
  PRIMARY KEY (`dim_film_key`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4;

INSERT INTO `project_2_sql`.`dim_films`
(`actor_key`,
  `film_key`,
  `language_key`,
  `first_name`,
  `last_name`,
  `title`,
  `description`,
  `release_year`,
  `rental_duration`,
  `rental_rate`,
  `length`,
  `replacement_cost`,
  `rating`,
  `special_features`)
SELECT
    film_actor.actor_id,
	film_actor.film_id,
    film.language_id,
    actor.first_name,
	actor.last_name,
    film.title,
    film.description,
    film.release_year,
    film.rental_duration,
    film.rental_rate,
    film.`length`,
    film.replacement_cost,
    film.rating,
    film.special_features
FROM film_actor
LEFT JOIN actor
ON film_actor.actor_id = actor.actor_id
LEFT JOIN film
on film_actor.film_id = film.film_id;

/* dim locations */
CREATE TABLE `dim_locations` (`dim_locations_key` smallint(5) auto_increment,
  `address_key` smallint(5) unsigned NOT NULL,
  `city_key` smallint(5) unsigned NOT NULL,
  `address` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `district` varchar(20) NOT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  PRIMARY KEY (`dim_locations_key`)
) ENGINE=InnoDB AUTO_INCREMENT=606 DEFAULT CHARSET=utf8mb4;

INSERT INTO `project_2_sql`.`dim_locations`
(`address_key`,
`city_key`,
`address`,
`city`,
`district`,
`postal_code`,
`phone`)
select
	address.address_id,
	address.city_id,
	address.address,
    city.city,
	address.district,
	address.postal_code,
	address.phone
from address
left join city
ON address.city_id = city.city_id;

/* dim customers */
CREATE TABLE `dim_customers` (`dim_customers_key` smallint(5) auto_increment,
  `customer_id` smallint(5) unsigned NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `create_date` datetime NOT NULL,
  `address` varchar(50) NOT NULL,
  `district` varchar(20) NOT NULL,
  `city` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  PRIMARY KEY (`dim_customers_key`)
) ENGINE=InnoDB AUTO_INCREMENT=600 DEFAULT CHARSET=utf8mb4;

INSERT INTO `project_2_sql`.`dim_customers`
(`customer_id`,
`first_name`,
`last_name`,
`email`,
`active`,
`create_date`,
`address`,
`district`,
`city`,
`country`,
`postal_code`,
`phone`)
SELECT
	customer.customer_id,
	customer.first_name,
	customer.last_name,
	customer.email,
	customer.active,
	customer.create_date,
	address.address,
	address.district,
	city.city,
	country.country,
	address.postal_code,
	address.phone
FROM customer
LEFT JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON city.city_id = address.city_id
LEFT JOIN country
on country.country_id = city.country_id;

/* rental facts table */
CREATE TABLE `fact_table` (
`facts_key` smallint(5) auto_increment,
`rental_key` int(11) unsigned,
  `inventory_key` mediumint(8) unsigned NOT NULL,
  `title` varchar(128) NOT NULL,
  `release_year` year(4) DEFAULT NULL,
  `length` smallint(5) unsigned DEFAULT NULL,
  `rental_date` datetime,
  `rental_duration` tinyint(3) unsigned NOT NULL DEFAULT '3',
  `rental_rate` decimal(4,2) NOT NULL DEFAULT '4.99',
  `replacement_cost` decimal(5,2) NOT NULL DEFAULT '19.99',
  PRIMARY KEY (`facts_key`)
) ENGINE=InnoDB AUTO_INCREMENT=606 DEFAULT CHARSET=utf8mb4;

INSERT INTO `project_2_sql`.`fact_table`
(`rental_key`,
`inventory_key`,
`title`,
`release_year`,
`length`,
`rental_date`,
`rental_duration`,
`rental_rate`,
`replacement_cost`)
select 
	rental.rental_id, 
	inventory.inventory_id, 
	film.title, 
    film.release_year, 
    film.`length`,
    rental.rental_date,
    film.rental_duration,
    film.rental_rate,
    film.replacement_cost
from inventory
left join film
on film.film_id = inventory.film_id
left join rental
on rental.inventory_id = inventory.inventory_id;

