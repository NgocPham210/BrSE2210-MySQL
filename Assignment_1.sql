CREATE database IF NOT exists Testing_System;

USE Testing_System;

/*Table department*/
CREATE table department(
DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
DepartName VARCHAR(50) NOT NULL UNIQUE
);
Create table `POSITION` (
PositionID INT PRIMARY KEY AUTO_INCREMENT,
PositionName VArCHAR(50) NOT NULL UNIQUE
);
Create table `ACCOUNT` (
AccountID INT PRIMARY KEY AUTO_INCREMENT,
Email varchar(50) not null unique,
Username varchar(50) not null,
Fullname varchar(50),
DepartmentID int not null,
PositionID int,
CreateDate date,
constraint foreign key fk_account_department(DepartmentiD) references department(DepartmentID)
);

Create table `group`(
GroupID int primary key auto_increment,
GroupName varchar(50) not null,
CreatorID int,
CreateDate date
);

Create table GroupAccount(
GroupID int not null,
AccountID int not null,
JoinDate date,
constraint foreign key fk_GroupAccount_group (GroupID) references `group`(GroupID),
constraint foreign key fk_GroupAccount_account (AccountID) references `ACCOUNT`(AccountID)
);

Create table typequestion(
TypeID int primary key auto_increment,
TypeName enum('Essay','Multiple-Choice')
);

Create table categoryquestion(
CategoryID int primary key auto_increment,
CategoryName Varchar(20)
);

Create table question(
QuestionID int primary key auto_increment,
Content varchar(50),
CategoryID int not null,
TypeID int not null,
CreatorID int not null,
CreateDate date,
constraint foreign key fk_question_categoryquestion(CategoryID) references categoryquestion(CategoryID),
constraint foreign key fk_question_typequestion(TypeID) references typequestion(TypeID),
constraint foreign key fk_question_group(CreatorID) references `group`(CreatorID),
constraint foreign key fk_question_group1(CreateDate) references `group`(CreateDate)
);

Create table answer(
AnswerID int primary key auto_increment,
Content varchar (50),
QuestionID int not null,
isCorrect enum(`OK`,`NG`)
);

Create table exams(
ExamID int primary key auto_increment,
`CODE` int not null,
Title varchar (50),
CategoryID int not null,
Duration time,
CreatorID int not null,
CreateDate date not null
constraint foreign key fk_exams_categoryquestion(CategoryID) references categoryquestion(CategoryID),
constraint foreign key fk_exams_group(CreatorID) references `group`(CreatorID),
constraint foreign key fk_exams_group1(CreateDate) references `group`(CreateDate)
);