DROP TABLE IF EXISTS teams;
CREATE TABLE teams (
  id INTEGER PRIMARY KEY,
  school VARCHAR(255) NOT NULL,
  mascot VARCHAR(255) NOT NULL,
  conference_id INTEGER,

  FOREIGN KEY(conference_id) REFERENCES conference(id)
);

DROP TABLE IF EXISTS conferences;
CREATE TABLE conferences (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  division_id INTEGER,

  FOREIGN KEY(division_id) REFERENCES division(id)
);

DROP TABLE IF EXISTS divisions;
CREATE TABLE divisions (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

INSERT INTO
  divisions (id, name)
VALUES
  (1, "FBS"), (2, "FCS");

INSERT INTO
  conferences (id, name, division_id)
VALUES
  (1, "Ivy League", 2), (2, "Big Ten", 1), (3, "SEC", 1);

INSERT INTO
  teams (id, school, mascot, conference_id)
VALUES
  (1, "Princeton", "Tigers", 1),
  (2, "Harvard", "Crimson", 1),
  (3, "Penn", "Quakers", 1),
  (4, "Columbia", "Lions", 1),
  (5, "Brown", "Bears", 1),
  (6, "Dartmouth", "Big Green", 1),
  (7, "Cornell", "Big Red", 1),
  (8, "Yale", "Bulldogs", 1),

  (9, "Michigan State", "Spartans", 2),
  (10, "Michigan", "Wolverines", 2),
  (11, "Penn State", "Nittany Lions", 2),
  (12, "Ohio State", "Buckeyes", 2),
  (13, "Rutgers", "Scarlet Knights", 2),
  (14, "Indiana", "Hoosiers", 2),
  (15, "Maryland", "Terrapins", 2),
  (16, "Illinois", "Fighting Illini", 2),
  (17, "Iowa", "Hawkeyes", 2),
  (18, "Minnesota", "Golden Gophers", 2),
  (19, "Nebraska", "Cornhuskers", 2),
  (20, "Northwestern", "Wildcats", 2),
  (21, "Purdue", "Boilermakers", 2),
  (22, "Wisconsin", "Badgers", 2),

  (23, "Florida", "Gators", 3),
  (24, "Georgia", "Bulldogs", 3),
  (25, "Kentucky", "Wildcats", 3),
  (26, "Missouri", "Tigers", 3),
  (27, "South Carolina", "Gamecocks", 3),
  (28, "Tennessee", "Volunteers", 3),
  (29, "Vanderbilt", "Commodores", 3),
  (30, "Alabama", "Crimson Tide", 3),
  (31, "Arkansas", "Razorbacks", 3),
  (32, "Auburn", "Tigers", 3),
  (33, "LSU", "Tigers", 3),
  (34, "Mississppi", "Rebels", 3),
  (35, "Mississippi State", "Bulldogs", 3),
  (36, "Texas A&M", "Aggies", 3);
