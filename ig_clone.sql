DROP DATABASE IF EXISTS instagram_clone_db;

CREATE DATABASE instagram_clone_db;

USE instagram_clone_db;

CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  username VARCHAR(255) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  PRIMARY KEY (id),
  UNIQUE INDEX username_UNIQUE (username ASC) VISIBLE
);

CREATE TABLE photos (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  image_url VARCHAR(255) NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  PRIMARY KEY (id),
  INDEX user_id_photos_idx (user_id ASC) VISIBLE,
  CONSTRAINT user_id_photos
    FOREIGN KEY (user_id)
    REFERENCES users (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE comments (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  comment_text VARCHAR(255) NOT NULL,
  photo_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  PRIMARY KEY (id),
  INDEX photo_id_comments_idx (photo_id ASC) VISIBLE,
  INDEX user_id_comments_idx (user_id ASC) VISIBLE,
  CONSTRAINT photo_id_comments
    FOREIGN KEY (photo_id)
    REFERENCES photos (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT user_id_comments
    FOREIGN KEY (user_id)
    REFERENCES users (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE likes (
  user_id INT UNSIGNED NOT NULL,
  photo_id INT UNSIGNED NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  PRIMARY KEY (user_id, photo_id),
  INDEX user_id_likes_idx (user_id ASC) VISIBLE,
  INDEX photo_id_likes_idx (photo_id ASC) VISIBLE,
  CONSTRAINT user_id_likes
    FOREIGN KEY (user_id)
    REFERENCES users (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT photo_id_likes
    FOREIGN KEY (photo_id)
    REFERENCES photos (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE follows (
  follower_id INT UNSIGNED NOT NULL,
  followee_id INT UNSIGNED NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  PRIMARY KEY (follower_id, followee_id),
  INDEX follower_id_follows_idx (follower_id ASC) VISIBLE,
  INDEX followee_id_follows_idx (followee_id ASC) VISIBLE,
  CONSTRAINT follower_id_follows
    FOREIGN KEY (follower_id)
    REFERENCES users (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT followee_id_follows
    FOREIGN KEY (followee_id)
    REFERENCES users (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE tags (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  tag_name VARCHAR(255) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  PRIMARY KEY (id),
  UNIQUE INDEX tag_name_UNIQUE (tag_name ASC) VISIBLE
);

CREATE TABLE photo_tags (
  photo_id INT UNSIGNED NOT NULL,
  tag_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (photo_id, tag_id),
  INDEX photo_id_photo_tags_idx (photo_id ASC) VISIBLE,
  INDEX tag_id_photo_tags_idx (tag_id ASC) VISIBLE,
  CONSTRAINT photo_id_photo_tags
    FOREIGN KEY (photo_id)
    REFERENCES photos (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT tag_id_photo_tags
    FOREIGN KEY (tag_id)
    REFERENCES tags (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);