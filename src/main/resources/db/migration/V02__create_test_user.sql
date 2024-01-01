insert into security.users (id, email, password) values ('d4a296ca-c095-4585-9bad-6d88e0074f19', 'nikolas@nikolas', '$2a$12$wfew1NxgJx6dGzJ6qG38leNdK2xX1tHJB4.L4sJX6woHG/9J5/AqS');

insert into security.roles (role_id, authority) values (1, 'ADMIN');
insert into security.roles (role_id, authority) values (2, 'USER');

insert into security.user_role_junction (role_id, user_id) values (1, 'd4a296ca-c095-4585-9bad-6d88e0074f19');
insert into security.user_role_junction (role_id, user_id) values (2, 'd4a296ca-c095-4585-9bad-6d88e0074f19');