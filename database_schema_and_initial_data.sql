-- create a database, connect to it and then run the following code
create table users (
id serial primary key,
username varchar,
password varchar);

  CREATE TABLE roles (
            id   serial primary key,
            role varchar
    );

    CREATE TABLE users_roles (
            user_id INTEGER REFERENCES users,
            role_id INTEGER REFERENCES roles,
            PRIMARY KEY (user_id, role_id)
    );

create table contacts (
id serial primary key,
name varchar,
phone varchar,
address varchar,
email varchar,
notes text,
created timestamp with time zone);

create table deals (
id serial primary key,
name varchar,
responsible_id int references users,
contact_id int references contacts,
status varchar,
price int,
probability int,
created timestamp with time zone,
updated timestamp with time zone);

create table notes (
id serial primary key,
note text,
deal_id int references deals on update cascade on delete cascade,
user_id int references users on update cascade on delete restrict,
created timestamp with time zone);

create table dashboard (
id serial primary key,
content text,
created timestamp with time zone,
"type" varchar, -- deal created, deal updated, deal deleted, note created, note deleted,
user_id int references users,
deal_id int references deals);


-- data

insert into users (username, password) values
('admin', 'admin');

insert into roles (role) values
('admin');

insert into users_roles (user_id, role_id) values
(1, 1);

insert into contacts (name) values
('Sérgio Ruoso');

insert into deals (name, responsible_id, contact_id, price) values
('Deal 1', 1, 1, '700');

insert into notes (note, deal_id, user_id) values
('Body of note', 1, 1),
('Note note', 1, 1);