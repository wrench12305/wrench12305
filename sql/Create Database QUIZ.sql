CREATE DATABASE IF NOT EXISTS QUIZ;

USE QUIZ;

CREATE TABLE IF NOT EXISTS USERS(
    USERS_ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    EMAIL VARCHAR(75) NOT NULL,
    PASSWORD VARCHAR(25) NOT NULL,
    IS_ACTIVE BIT NOT NULL,
    PRIMARY KEY(USERS_ID)
);

CREATE TABLE IF NOT EXISTS ADMINISTRATOR(
    ADMIN_ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    EMAIL VARCHAR(75) NOT NULL,
    PASSWORD VARCHAR(25) NOT NULL,
    HEADER VARCHAR(75),
    FOOTER VARCHAR(75),
    FILENAME VARCHAR(75),
    PRIMARY KEY(ADMIN_ID)
);

CREATE TABLE IF NOT EXISTS TEST(
    TEST_ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    ADMIN_ID INT UNSIGNED NOT NULL,
    IMAGE_NAME VARCHAR(50),
    TITLE VARCHAR(25) NOT NULL,
    HEADER_TEXT VARCHAR(25) NOT NULL,
    FOOTER_TEXT VARCHAR(25) NOT NULL,
    TEST_DUE DATE,
    FOREIGN KEY(ADMIN_ID) REFERENCES ADMINISTRATOR(ADMIN_ID) ON DELETE CASCADE,
    PRIMARY KEY(TEST_ID)
);

CREATE TABLE IF NOT EXISTS QUESTION(
    QUESTION_ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    TEXT VARCHAR(250) NOT NULL,
    CATEGORY VARCHAR(75),
    IMAGE_NAME VARCHAR(50),
    IS_TRUE_FALSE BIT NOT NULL,
    TF_IS_TRUE BIT,
    NUM_ANSWERS INT UNSIGNED,
    PRIMARY KEY(QUESTION_ID)
);

CREATE TABLE IF NOT EXISTS ANSWER(
    ANSWER_ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    ANSWER VARCHAR(25),
    PRIMARY KEY(ANSWER_ID)
);

CREATE TABLE IF NOT EXISTS QUESTION_ANSWER(
    QUESTION_ANSWER_ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    ANSWER_ID INT UNSIGNED NOT NULL,
    QUESTION_ID INT UNSIGNED NOT NULL,
    IS_CORRECT_ANSWER BIT NOT NULL,
    FOREIGN KEY(ANSWER_ID) REFERENCES ANSWER(ANSWER_ID) ON DELETE CASCADE,
    FOREIGN KEY(QUESTION_ID) REFERENCES QUESTION(QUESTION_ID) ON DELETE CASCADE,
    PRIMARY KEY(QUESTION_ANSWER_ID)
);

CREATE TABLE IF NOT EXISTS TEST_QUESTIONS(
    TEST_QUESTIONS_ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    TEST_ID INT UNSIGNED NOT NULL,
    QUESTION_ID INT UNSIGNED NOT NULL,
    FOREIGN KEY(TEST_ID) REFERENCES TEST(TEST_ID) ON DELETE CASCADE,
    FOREIGN KEY(QUESTION_ID) REFERENCES QUESTION(QUESTION_ID) ON DELETE CASCADE,
    PRIMARY KEY(TEST_QUESTIONS_ID)
);

CREATE TABLE IF NOT EXISTS ALLOWED_USERS(
    ALLOWED_USERS_ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    USERS_ID INT UNSIGNED NOT NULL,
    TEST_ID INT UNSIGNED NOT NULL,
    TEST_ASSIGNED DATE NOT NULL,
    FOREIGN KEY(USERS_ID) REFERENCES USERS(USERS_ID) ON DELETE CASCADE,
    FOREIGN KEY(TEST_ID) REFERENCES TEST(TEST_ID) ON DELETE CASCADE,
    PRIMARY KEY(ALLOWED_USERS_ID)   
);

CREATE TABLE IF NOT EXISTS TESTS_TAKEN(
	TEST_TAKEN_ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    USERS_ID INT UNSIGNED NOT NULL,
    TEST_ID INT UNSIGNED NOT NULL,
    TEST_DATE DATE NOT NULL,
	SCORE DECIMAL(5,2),
    UP_TO_DATE BIT,
    FOREIGN KEY(USERS_ID) REFERENCES USERS(USERS_ID) ON DELETE CASCADE,
    FOREIGN KEY(TEST_ID) REFERENCES TEST(TEST_ID) ON DELETE CASCADE,
    PRIMARY KEY(TEST_TAKEN_ID)
);

CREATE TABLE IF NOT EXISTS RESULTS(
    RESULTS_ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
	TEST_TAKEN_ID INT UNSIGNED NOT NULL,
    QUESTION_ID INT UNSIGNED NOT NULL,
    ANSWER_ID INT UNSIGNED,
    TF_CHOSEN BIT,
	FOREIGN KEY(TEST_TAKEN_ID) REFERENCES TESTS_TAKEN(TEST_TAKEN_ID) ON DELETE CASCADE,
    FOREIGN KEY(QUESTION_ID) REFERENCES QUESTION(QUESTION_ID) ON DELETE CASCADE,
    FOREIGN KEY(ANSWER_ID) REFERENCES ANSWER(ANSWER_ID) ON DELETE CASCADE,
    PRIMARY KEY(RESULTS_ID)
);

CREATE TABLE IF NOT EXISTS TEST_IN_PROGRESS(
	TEST_IN_PROGRESS_ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    TEST_ID INT UNSIGNED NOT NULL,
    USERS_ID INT UNSIGNED NOT NULL,
    QUESTION_ID INT UNSIGNED NOT NULL,
    ANSWER_ID INT UNSIGNED,
    TF_CHOSEN BIT,
    FOREIGN KEY(TEST_ID) REFERENCES TEST(TEST_ID) ON DELETE CASCADE, 
	FOREIGN KEY(USERS_ID) REFERENCES USERS(USERS_ID) ON DELETE CASCADE,
    FOREIGN KEY(QUESTION_ID) REFERENCES QUESTION(QUESTION_ID) ON DELETE CASCADE,
    FOREIGN KEY(ANSWER_ID) REFERENCES ANSWER(ANSWER_ID) ON DELETE CASCADE,
    PRIMARY KEY(TEST_IN_PROGRESS_ID)
    );