
/*Users*/
CREATE TABLE users (
    id INT identity(1,1)  PRIMARY KEY,
    username VARCHAR(255) NOT NULL, created_at date )


/*Photos*/
CREATE TABLE photos (
    id INT identity(1,1) PRIMARY KEY,
    image_url VARCHAR(355) NOT NULL,
    user_id INT NOT NULL
);


/*Comments*/
CREATE TABLE comments (
    id INT identity(1,1) PRIMARY KEY,
    comment_text VARCHAR(255) NOT NULL,
    user_id INT NOT NULL,
    photo_id INT NOT NULL
);


/*Likes*/
CREATE TABLE likes (
    user_id INT NOT NULL,
    photo_id INT NOT NULL
);


/*follows*/
CREATE TABLE follows (
    follower_id INT NOT NULL,
    followee_id INT NOT NULL,
    PRIMARY KEY (follower_id , followee_id)
);


/*Tags*/
CREATE TABLE tags (
    id INTEGER identity(1,1) PRIMARY KEY,
    tag_name VARCHAR(255) UNIQUE NOT NULL
);


/*junction table: Photos - Tags*/
CREATE TABLE photo_tags (
    photo_id INT NOT NULL,
    tag_id INT NOT NULL,
    PRIMARY KEY (photo_id , tag_id)
);



INSERT INTO users (username, created_at) VALUES ('Kenton_Kirlin', '2017-02-16 18:22:10.846'),
('Andre_Purdy85', '2017-04-02 17:11:21.417'), ('Harley_Lind18', '2017-02-21 11:12:32.574'),
('Arely_Bogan63', '2016-08-13 01:28:43.085'), 
('Aniya_Hackett', '2016-12-07 01:04:39.298'), ('Travon.Waters', '2017-04-30 13:26:14.496')
, ('Kasandra_Homenick', '2016-12-12 06:50:07.996'), ('Tabitha_Schamberger11', '2016-08-20 02:19:45.512'),
('Gus93', '2016-06-24 19:36:30.978'), ('Presley_McClure', '2016-08-07 16:25:48.561'), 
('Justina.Gaylord27', '2017-05-04 16:32:15.577'), ('Dereck65', '2017-01-19 01:34:14.296'),
('Alexandro35', '2017-03-29 17:09:02.344'), ('Jaclyn81', '2017-02-06 23:29:16.394'),
('Billy52', '2016-10-05 14:10:20.453'), ('Annalise.McKenzie16', '2016-08-02 21:32:45.646'), 
('Norbert_Carroll35', '2017-02-06 22:05:43.425'), ('Odessa2', '2016-10-21 18:16:56.390'), 
('Hailee26', '2017-04-29 18:53:39.650'), ('Delpha.Kihn', '2016-08-31 02:42:30.288'), 
('Rocio33', '2017-01-23 11:51:15.467'), ('Kenneth64', '2016-12-27 09:48:17.380'), 
('Eveline95', '2017-01-23 23:14:18.569'), ('Maxwell.Halvorson', '2017-04-18 02:32:43.597'), 
('Tierra.Trantow', '2016-10-03 12:49:20.774'), ('Josianne.Friesen', '2016-06-07 12:47:00.703'), 
('Darwin29', '2017-03-18 03:10:07.047'), ('Dario77', '2016-08-18 07:15:02.823'),
('Jaime53', '2016-09-11 18:51:56.965'), ('Kaley9', '2016-09-23 21:24:20.222')
, ('Aiyana_Hoeger', '2016-09-29 20:28:12.457'), ('Irwin.Larson', '2016-08-26 19:36:22.199'),
('Yvette.Gottlieb91', '2016-11-14 12:32:01.405'), ('Pearl7', '2016-07-08 21:42:00.982'), 
('Lennie_Hartmann40', '2017-03-30 03:25:21.937'), ('Ollie_Ledner37', '2016-08-04 15:42:20.322'), 
('Yazmin_Mills95', '2016-07-27 00:56:44.310'), ('Jordyn.Jacobson2', '2016-05-14 07:56:25.835'),
('Kelsi26', '2016-06-08 17:48:08.478'), ('Rafael.Hickle2', '2016-05-19 09:51:25.779')


INSERT INTO photos(image_url, user_id) VALUES 
('http://elijah.biz', 1), ('https://shanon.org', 1), ('http://vicky.biz', 1), ('http://oleta.net', 1), 
('https://jennings.biz', 1), ('https://quinn.biz', 2), ('https://selina.name', 2), ('http://malvina.org', 2), 
('https://branson.biz', 2), ('https://elenor.name', 3), ('https://marcelino.com', 3), ('http://felicity.name', 3), 
('https://fred.com', 3), ('https://gerhard.biz', 4), ('https://sherwood.net', 4), ('https://maudie.org', 4),
('http://annamae.name', 6), ('https://mac.org', 6), ('http://miracle.info', 6), ('http://emmet.com', 6),
('https://lisa.com', 6), ('https://brooklyn.name', 8), ('http://madison.net', 8), ('http://annie.name', 8),
('http://darron.info', 8), ('http://saige.com', 9), ('https://reece.net', 9), ('http://vance.org', 9),
('http://ignacio.net', 9), ('http://kenny.com', 10), ('http://remington.name', 10), ('http://kurtis.info', 10),
('https://alisha.com', 11), ('https://henderson.com', 11), ('http://bonnie.info', 11), ('http://kennith.net', 11), 
('http://camille.name', 11), ('http://alena.net', 12), ('http://ralph.name', 12), ('https://tyshawn.com', 12)



INSERT INTO follows(follower_id, followee_id) VALUES (2, 1), (2, 3), (2, 4), (2, 5), (2, 6), (2, 7), (2, 8), (2, 9),
(2, 10), (2, 11), (2, 12), (2, 13), (2, 14), (2, 15), (2, 16), (2, 17), (2, 18), (2, 19), (2, 20), (2, 21), (2, 22),
(2, 23), (2, 24), (2, 25), (2, 26), (2, 27), (2, 28), (2, 29), (2, 30), (2, 31), (2, 32), (2, 33), (2, 34), (2, 35),
(2, 36), (2, 37), (2, 38), (2, 39), (2, 40), (2, 41)



INSERT INTO comments(comment_text, user_id, photo_id) VALUES ('unde at dolorem', 2, 1),
('quae ea ducimus', 3, 1), ('alias a voluptatum', 5, 1), ('facere suscipit sunt', 14, 1), 
('totam eligendi quaerat', 17, 1), ('vitae quia aliquam', 21, 1), ('exercitationem occaecati neque', 24, 1),
('sint ad fugiat', 31, 1), ('nesciunt aut nesciunt', 36, 1), ('laudantium ut nostrum', 41, 1), 
('omnis aut asperiores', 52, 1), ('et eum molestias', 54, 1), ('alias pariatur neque', 55, 1), 
('amet iure adipisci', 57, 1), ('cum enim repellat', 62, 1), ('provident dolorem non', 63, 1),
('eos consequuntur impedit', 66, 1), ('voluptas nemo blanditiis', 71, 1), ('id fugit dolores', 72, 1), 
('occaecati tenetur exercitationem', 75, 1), ('quasi deserunt voluptates', 76, 1), 
('reprehenderit sunt cumque', 78, 1),
('non impedit ut', 87, 1), ('voluptatum sit id', 91, 1), ('tenetur voluptas aspernatur', 98, 1),
('in veritatis quia', 3, 2), ('quis facilis ea', 5, 2), ('quia est sit', 14, 2), 
('voluptatem doloremque accusamus', 15, 2), ('consectetur inventore quis', 18, 2), ('sunt dolorem reprehenderit', 19, 2)
, ('omnis omnis nulla', 21, 2), ('ullam in facilis', 24, 2), ('possimus consequuntur occaecati', 28, 2), 
('voluptas dicta aut', 30, 2), ('explicabo qui ipsum', 31, 2), ('qui pariatur dolor', 35, 2),
('ratione debitis laborum', 36, 2), ('voluptate id dignissimos', 41, 2), ('tempore quod possimus', 42, 2), 
('corporis ut necessitatibus', 43, 2), ('culpa aut aut', 47, 2)


INSERT INTO likes(user_id,photo_id) 
VALUES (2, 1), (5, 1), (9, 1), (10, 1), (11, 1), (14, 1), (19, 1), (21, 1), (24, 1), (35, 1), (36, 1),
(41, 1), (46, 1), (47, 1), (54, 1), (55, 1), (57, 1), (66, 1), (69, 1), (71, 1), (75, 1), (76, 1), (78, 1), 
(82, 1), (91, 1), (3, 2), (5, 2), (6, 2), (8, 2), (14, 2), (17, 2), (19, 2), (21, 2), (24, 2), (26, 2), (27, 2), 
(30, 2), (31, 2), (33, 2), (36, 2)


INSERT INTO tags(tag_name) 
VALUES ('sunset'), ('photography'), ('sunrise'), ('landscape'), ('food'), ('foodie'), ('delicious'), 
('beauty'), ('stunning'), ('dreamy'), ('lol'), ('happy'), ('fun'), ('style'), ('hair'), ('fashion'), 
('party'), ('concert'), ('drunk'), ('beach'), ('smile');


INSERT INTO photo_tags(photo_id, tag_id) 
VALUES (1, 18), (1, 17), (1, 21), (1, 13), (1, 19), (2, 4), (2, 3), (2, 20), (2, 2), (3, 8), 
(4, 12), (4, 11), (4, 21), (4, 13), (5, 15), (5, 14), (5, 17), (5, 16), (6, 19), (6, 13), (6, 17), 
(6, 21), (7, 11), (7, 12), (7, 21), (7, 13), (8, 17), (8, 21), (8, 13), (8, 19), (9, 18), (10, 2), 
(11, 12), (11, 21), (11, 11), (12, 4), (13, 13), (13, 19), (14, 1), (14, 20)
