CREATE TABLE `hashtag` (
  `hashtag_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100),
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`hashtag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `post_tags` (
  `hashtag_id` int ,
  `post_id` int ,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  KEY `hashtag_id` (`hashtag_id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `post_tag_ibfk_1` FOREIGN KEY (`hashtag_id`) REFERENCES `hashtag` (`hashtag_id`),
  CONSTRAINT `post_tag_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `post` (
  `post_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `caption` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `attachment` varchar(100) DEFAULT NULL,
  `tag_id` int DEFAULT NULL,
  PRIMARY KEY (`post_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL UNIQUE,
  `bio` text,
  PRIMARY KEY (`user_id`)
);