/*CREATE DATABASE lab3;*/

USE lab3;

CREATE TABLE [Institute] (
  inst_id integer IDENTITY(1, 1) NOT NULL,
  inst_name varchar(110) NOT NULL,
  CONSTRAINT [PK_Inst] PRIMARY KEY (inst_id ASC)
);
 
CREATE TABLE [Reader] (
  reader_id integer IDENTITY(1, 1) NOT NULL,
  full_name varchar(60) NOT NULL,
  passport_num decimal(10, 0) NOT NULL,
  address varchar(80) NOT NULL,
  phone decimal(10, 0),
  retirement datetime,
  inst_id integer,
  CONSTRAINT [PK_Reader] PRIMARY KEY (reader_id ASC)
);

CREATE TABLE [Theme] (
  theme_id integer IDENTITY(1, 1) NOT NULL,
  theme_name varchar(30) NOT NULL,
  CONSTRAINT [PK_Theme] PRIMARY KEY (theme_id ASC)
);

CREATE TABLE [Keyword] (
  keyword_id integer IDENTITY(1, 1) NOT NULL,
  keyword_name varchar(20) NOT NULL,
  CONSTRAINT [PK_Keyword] PRIMARY KEY (keyword_id ASC)
);

CREATE TABLE [ThemeSpecialization] (
  theme_id integer NOT NULL,
  keyword_id integer NOT NULL,
  CONSTRAINT [PK_ThemeSpec] PRIMARY KEY (
	theme_id ASC,
	keyword_id ASC
  )
);

CREATE TABLE [Place] (
  place_id integer IDENTITY(1, 1) NOT NULL,
  hall_id decimal(2, 0) NOT NULL,
  rack_id decimal(2, 0),
  CONSTRAINT [PK_Place] PRIMARY KEY (place_id ASC)
);

CREATE TABLE [Book] (
  book_id integer IDENTITY(1, 1) NOT NULL,
  book_name varchar(20) NOT NULL,
  author varchar(20) NOT NULL,
  publishing varchar(20) NOT NULL,
  year decimal(4, 0) NOT NULL,
  place_id integer,
  CONSTRAINT [PK_Book] PRIMARY KEY (book_id ASC)
);

CREATE TABLE [BookSpecialization] (
  book_id integer NOT NULL,
  theme_id integer NOT NULL,
  CONSTRAINT [PK_BookSpec] PRIMARY KEY (
	book_id ASC,
	theme_id ASC
  )
);

CREATE TABLE [Delivery] (
  book_id integer NOT NULL,
  reader_id integer NOT NULL,
  date datetime NOT NULL CONSTRAINT [Delivery_Date] DEFAULT (getdate()),
  return_date datetime NOT NULL,
  real_return_date datetime,
  CONSTRAINT [PK_DeliverySpec] PRIMARY KEY (
	book_id ASC,
	reader_id ASC
  )
);

CREATE UNIQUE INDEX [IX_Inst] ON [Institute]
(
	[inst_name] ASC
);

CREATE UNIQUE INDEX [IX_Reader] ON [Reader]
(
	[passport_num] ASC
);

CREATE UNIQUE INDEX [IX_Keyword] ON [Keyword]
(
	[keyword_name] ASC
);

ALTER TABLE [Reader]
  ADD CONSTRAINT [FK_Reader_Inst] FOREIGN KEY (inst_id)
    REFERENCES [Institute] (inst_id) ON UPDATE CASCADE;

ALTER TABLE [ThemeSpecialization]
  ADD CONSTRAINT [FK_ThemeSpec_Theme] FOREIGN KEY (theme_id)
	REFERENCES [Theme] (theme_id) ON UPDATE CASCADE;

ALTER TABLE [ThemeSpecialization]
  ADD CONSTRAINT [FK_ThemeSpec_Keyword] FOREIGN KEY (keyword_id)
	REFERENCES [Keyword] (keyword_id) ON UPDATE CASCADE;

ALTER TABLE [Book]
  ADD CONSTRAINT [FK_Book_Place] FOREIGN KEY (place_id)
	REFERENCES [Place] (place_id) ON UPDATE CASCADE;

ALTER TABLE [BookSpecialization]
  ADD CONSTRAINT [FK_BookSpec_Book] FOREIGN KEY (book_id)
	REFERENCES [Book] (book_id);

ALTER TABLE [BookSpecialization]
  ADD CONSTRAINT [FK_BookSpec_Theme] FOREIGN KEY (theme_id)
	REFERENCES [Theme] (theme_id);

ALTER TABLE [Delivery] 
  ADD CONSTRAINT [FK_Delivery_Book] FOREIGN KEY (book_id)
	REFERENCES [Book] (book_id);

ALTER TABLE [Delivery] 
  ADD CONSTRAINT [FK_Delivery_Reader] FOREIGN KEY (reader_id)
	REFERENCES [Reader] (reader_id) ON UPDATE CASCADE;
