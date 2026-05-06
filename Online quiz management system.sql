CREATE DATABASE Online_quiz_management_system;
USE Online_quiz_management_system;

CREATE TABLE Users(UserID INT Primary Key,Username VARCHAR(50),Email VARCHAR(50),Password VARCHAR(50),RegistrationDate DATE);
DESC Users;
create table Quizzes(QuizID INT Primary Key,QuizName VARCHAR(50),Description TEXT,CreationDate DATE);
create table Questions(QuestionID INT Primary Key,QuizID INT,Foreign Key(QuizID) references Quizzes(QuizID),QuestionText TEXT,
QuestionType VARCHAR(50));
desc Questions;
create table Options(OptionID INT Primary Key,QuestionID INT,Foreign Key(QuestionID) references Questions(QuestionID),OptionText VARCHAR(50),
IsCorrect BOOLEAN);
create table UserAnswers(UserAnswerID INT Primary Key,UserID INT,Foreign Key(UserID) references Users(UserID),QuestionID INT,
Foreign Key(QuestionID) references Questions(QuestionID),SelectedOptionID INT, Foreign Key(SelectedOptionID) references Options(OptionID),
AnswerDate DATE);
create table Scores(ScoreID INT Primary Key,UserID INT, Foreign Key(UserID) references Users(UserID),QuizID INT, Foreign Key(QuizID) 
references Quizzes(QuizID),Score DECIMAL(12,0),AttemptDate DATE);

INSERT INTO Users VALUES(1, 'Amit', 'amit@gmail.com', 'pass1', '2024-01-10'),(2, 'Priya', 'priya@gmail.com', 'pass2', '2024-02-12'),
(3, 'Rahul', 'rahul@gmail.com', 'pass3', '2024-03-05'),(4, 'Sneha', 'sneha@gmail.com', 'pass4', '2024-01-25'),
(5, 'Karan', 'karan@gmail.com', 'pass5', '2024-04-02'),(6, 'Neha', 'neha@gmail.com', 'pass6', '2024-02-18'),
(7, 'Vikas', 'vikas@gmail.com', 'pass7', '2024-03-10'),(8, 'Anjali', 'anjali@gmail.com', 'pass8', '2024-01-30'),
(9, 'Rohit', 'rohit@gmail.com', 'pass9', '2024-02-22'),(10, 'Meena', 'meena@gmail.com', 'pass10', '2024-03-15');

INSERT INTO Quizzes VALUES
(1, 'General Knowledge Quiz', 'Basic GK questions', '2024-01-15'),
(2, 'Science Quiz', 'Physics and Chemistry', '2024-02-10'),
(3, 'Math Quiz', 'Algebra and Geometry', '2024-03-01'),
(4, 'History Quiz', 'Ancient history', '2024-01-20'),
(5, 'General Awareness', 'Current affairs', '2024-04-05'),
(6, 'Computer Basics', 'IT fundamentals', '2024-02-25'),
(7, 'Geography Quiz', 'World geography', '2024-03-12'),
(8, 'English Quiz', 'Grammar and vocab', '2024-01-28'),
(9, 'Sports Quiz', 'Sports knowledge', '2024-02-14'),
(10, 'General Science', 'Mixed science', '2024-04-10');

INSERT INTO Questions VALUES
(1, 1, 'Capital of India?', 'Multiple Choice'),
(2, 1, '2+2=?', 'Multiple Choice'),
(3, 2, 'Water formula?', 'Multiple Choice'),
(4, 2, 'Gravity discovered by Newton?', 'True/False'),
(5, 3, 'Square root of 16?', 'Multiple Choice'),
(6, 3, 'Value of Pi?', 'Multiple Choice'),
(7, 4, 'Who was Ashoka?', 'Multiple Choice'),
(8, 5, 'Current PM of India?', 'Multiple Choice'),
(9, 6, 'What is CPU?', 'Multiple Choice'),
(10, 7, 'Largest continent?', 'Multiple Choice');

INSERT INTO Options VALUES
(1, 1, 'Delhi', TRUE),
(2, 1, 'Mumbai', FALSE),
(3, 2, '4', TRUE),
(4, 2, '5', FALSE),
(5, 3, 'H2O', TRUE),
(6, 3, 'CO2', FALSE),
(7, 4, 'True', TRUE),
(8, 4, 'False', FALSE),
(9, 5, '4', TRUE),
(10, 5, '5', FALSE),
(11, 6, '3.14', TRUE),
(12, 6, '2.17', FALSE),
(13, 7, 'King', TRUE),
(14, 7, 'Soldier', FALSE),
(15, 8, 'Modi', TRUE),
(16, 8, 'Rahul', FALSE),
(17, 9, 'Processor', TRUE),
(18, 9, 'Monitor', FALSE),
(19, 10, 'Asia', TRUE),
(20, 10, 'Europe', FALSE);

INSERT INTO UserAnswers VALUES
(1, 1, 1, 1, '2024-04-01'),
(2, 2, 2, 3, '2024-04-01'),
(3, 3, 3, 5, '2024-04-02'),
(4, 4, 4, 7, '2024-04-02'),
(5, 5, 5, 9, '2024-04-03'),
(6, 6, 6, 11, '2024-04-03'),
(7, 7, 7, 13, '2024-04-04'),
(8, 8, 8, 15, '2024-04-04'),
(9, 9, 9, 17, '2024-04-05'),
(10, 10, 10, 19, '2024-04-05');

INSERT INTO Scores VALUES
(1, 1, 1, 85, '2024-04-01'),
(2, 2, 1, 90, '2024-04-01'),
(3, 3, 2, 75, '2024-04-02'),
(4, 4, 2, 88, '2024-04-02'),
(5, 5, 3, 92, '2024-04-03'),
(6, 6, 3, 60, '2024-04-03'),
(7, 7, 4, 70, '2024-04-04'),
(8, 8, 5, 95, '2024-04-04'),
(9, 9, 6, 82, '2024-04-05'),
(10, 10, 7, 78, '2024-04-05');

select * from Quizzes;
select * from Quizzes where CreationDate>2024-01-01;

select * from Questions;
select * from Questions where QuestionType="Multiple Choice" AND QuizID=3;

select * from Quizzes where QuizName like "General%";

select * from Options;
Alter table Options add OptionStatus varchar(50);
select OptionText,
CASE
when IsCorrect=1 then "Correct"
else
"Incorrect"
end OptionStatus
from Options;

select * from UserAnswers;
select * from Users where UserID IN(select UserID from UserAnswers group by UserID having count(UserAnswerID)>20);

select * from Questions;
select QuizID,sum(QuestionID) as total_questions from Questions group by QuizID;

select * from Scores;
select UserID,count(QuizID) as total_quizes from Scores group by UserID having count(QuizID)>3;

select * from Questions;
select QuizID,count(QuestionID) as total_questions from Questions group by QuizID order by count(QuestionID) desc limit 5;

select * from UserAnswers;
select us.Username,u.SelectedOptionID,q.QuestionText from Users us JOIN UserAnswers u ON us.UserID=u.UserID  Join Questions q 
ON u.QuestionID=q.QuestionID;

select qui.QuizID,qui.QuizName,q.QuestionID,q.QuestionText from Quizzes qui Left Join Questions q on qui.QuizID=q.QuizID;

select q.QuestionID,count(o.OptionID) as total_options from Questions q 
Join Options o ON q.QuestionID=o.QuestionID group by q.QuestionID;

select q.QuizID,q.QuizName from Quizzes q JOIN Scores s ON q.QuizID=s.QuizID 
where s.UserID IN(select s.UserID from Scores s group by s.UserID having avg(s.Score)>80) 
group by q.QuizID,q.QuizName;

select * from Quizzes;
select u.Username, q.QuizName, s.Score from Users u JOIN Scores s ON u.UserID=s.UserID 
LEFT JOIN Quizzes q ON s.QuizID=q.QuizID;