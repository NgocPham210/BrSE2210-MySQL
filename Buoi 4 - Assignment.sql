/*--Question1---*/
SELECT *
FROM `account`a
INNER JOIN department d on d.DepartmentID = a.DepartmentID
;

/*--Question2---*/
SELECT *
FROM `account`
WHERE CreatedDate > '2010-10-20'
;

/*--Question3---*/
SELECT *
FROM `account`a
INNER JOIN `position` p ON p.PositionID = a.PositionID
where PositionName like 'Dev%'
;

/*--Question4---*/
SELECT d.DepartmentID, d.DepartmentName, count(a.AccountID) as totalMember
FROM `account` a
inner join department d on d.DepartmentID = a.DepartmentID
group by d.DepartmentID 
having totalMember > 3
;

/*--Question5---*/
SELECT e.QuestionID, q.Content, count(e.QuestionID) as totalMember
from `examquestion` e
inner join question q on q.QuestionID = e.QuestionID
group by e.QuestionID
having totalMember = (Select max(total) from (SELECT count(e.QuestionID) as total
FROM `examquestion` e
group by e.QuestionID) as temp_table)
;

/*--Question6---*/
SELECT c.CategoryID, c.CategoryName, count(q.CategoryID) 
from categoryquestion c
join question q on c.CategoryID = q.CategoryID
group by q.CategoryID
;

/*--Question7---*/
SELECT q.QuestionID, q.Content, count(eq.QuestionID) 
from examquestion eq
right join question q on q.QuestionID = eq.QuestionID
group by q.QuestionID
;

/*--Question8---*/
SELECT q.QuestionID, q.Content, count(a.QuestionID) as totalMember
from `answer` a
inner join question q on q.QuestionID = a.QuestionID
group by a.QuestionID
having totalMember = (SELECT max(countQues) from (select count(b.QuestionID) as countQues
FROM `answer` b
group by b.QuestionID) as countAnsw)
;

SELECT Q.QuestionID, Q.Content, count(A.QuestionID) FROM answer A
INNER JOIN question Q ON Q.QuestionID = A.QuestionID
GROUP BY A.QuestionID
HAVING count(A.QuestionID) = (SELECT max(countQues) FROM
(SELECT count(B.QuestionID) AS countQues FROM answer B
GROUP BY B.QuestionID) AS countAnsw);

/*--Question9---*/
SELECT g.GroupID, g.GroupName, count(ga.AccountID)
from groupaccount ga
inner join `group` g on g.GroupID = ga.GroupID
group by g.GroupID
order by g.GroupID;


-- Question10: tìm chức vụ có ít người nhất
SELECT *
FROM `account` a
Inner join position p on p.PositionID = a.PositionID
;

SELECT p.PositionName, count(a.PositionID) as totalMember
FROM `account` a
Inner join `position` p on p.PositionID = a.PositionID
group by p.PositionID
having totalMember = (Select min(total) from (SELECT count(a.PositionID) as total
FROM `account` a
Inner join `position` p on p.PositionID = a.PositionID
group by p.PositionID) as temp_table)
;

Select min(total) from (SELECT count(a.PositionID) as total
FROM `account` a
Inner join `position` p on p.PositionID = a.PositionID
group by p.PositionID) as temp_table;

-- Question11: thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM


SELECT d.DepartmentID, d.DepartmentName, p.PositionName, count(p.PositionID)
From `account` a
inner join department d on a.DepartmentID = d.DepartmentID
inner join `position` p on a.PositionID = p.PositionID
group by d.DepartmentID, p.PositionID;

-- Question12: lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì
SELECT q.QuestionID, q.Content, a.FullName, tq.TypeName as Author, ans.Content
From question q
inner join categoryquestion cq on q.CategoryID = cq.CategoryID
inner join typequestion tq on q.TypeID = tq.TypeID
inner join `account` a on a.AccountID = q.CreatorID
inner join `answer` ans on q.QuestionID = ans.QuestionID
order by q.QuestionID asc
;

-- Question13: lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT q.TypeID, tq.TypeName, count(q.TypeID) as totalquestion
from question q
inner join typequestion tq on q.TypeID = tq.TypeID
group by q.TypeID
;

-- Question14: lấy ra group không có account nào
SELECT g.GroupID, g.GroupName
from `group` g
left join groupaccount ga on ga.GroupID = g.GroupID
where ga.AccountID is null
;

-- Question16: Lấy ra question không có answer nào

SELECT *
FROM question q
where QuestionID not in (select QuestionID from answer);


-- Question17:
SELECT a.FullName
from `account` a
join groupaccount ga on ga.AccountID = a.AccountID
where ga.groupID = 1
union 
SELECT a.FullName
from `account` a
join groupaccount ga on ga.AccountID = a.AccountID
where ga.groupID = 2;

-- Question18:

SELECT g.GroupName, count(ga.GroupID) as totalMember
from groupaccount ga
join `group` g on ga.GroupID = g.GroupID
group by g.GroupID
having totalMember >=5
union all
SELECT g.GroupName, count(ga.GroupID) as totalMember
from groupaccount ga
join `group` g on ga.GroupID = g.GroupID
group by g.GroupID
having totalMember <=7;