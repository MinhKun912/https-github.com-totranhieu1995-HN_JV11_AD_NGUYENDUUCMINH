CREATE DATABASE Test2;
USE Test2;

CREATE TABLE Classes(
classID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
className NVARCHAR(50)
);

CREATE TABLE Students
(
    StudentID   INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    StudentName NVARCHAR(50) NOT NULL,
    email     VARCHAR(100),
    age INT
);

CREATE TABLE ClassStudent(
StudentID INT NOT NULL,
classesID INT NOT NULL,
FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
FOREIGN KEY (classesID) REFERENCES Classes(classID)
);

CREATE TABLE Subjects
(
    SubjectId   INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubJectName NVARCHAR(50) NOT NULL
);

CREATE TABLE Marks
(
    Mark    INT NOT NULL,
    SubjectId     INT NOT NULL,
    StudentId INT NOT NULL,
    FOREIGN KEY (SubjectId) REFERENCES Subjects (SubjectId),
    FOREIGN KEY (StudentID) REFERENCES Students (StudentID)
);


INSERT INTO Classes (className) VALUES 
('C0706L'),
('C0708G');

INSERT INTO Students (StudentName,age,email) VALUES 
('Nguyen Quang An',18,'an@yahoo.com'),
('Nguyen Cong Vinh',20,'vinh@gmail.com'),
('Nguyen Van Quyen',19,'quyen'),
('Pham Thanh Binh',25,'binh@com'),
('Nguyen Van Tai Em',30,'taiem@sport.vn');

INSERT INTO ClassStudent VALUES 
(1,1),
(2,1),
(3,2),
(4,2),
(5,2);

INSERT INTO Subjects VALUES 
(1,'SQL'),
(2,'JAVA'),
(3,'C'),
(4,'Visual Basic');

INSERT INTO Marks(Mark,SubjectId,StudentId) VALUES 
(8,1,1),
(4,2,1),
(9,1,1),
(7,1,3),
(3,1,4),
(5,2,5),
(8,3,3),
(1,3,5),
(3,2,4);

-- 1.hiển thị tất cả các học viên :
SELECT StudentName FROM Students ;
-- hay là hiển thị thông tin tất cả học viên ?
SELECT * FROM Students ;
-- 2.hiển thị tất cả danh sách tất cả môn học 
SELECT * FROM subjects;
-- 3.tính điểm trung bình :
SELECT S.StudentName,AVG(M.Mark) as 'Điểm trung bình ' FROM Students S
 JOIN Marks M ON M.StudentID = S.StudentID
 JOIN subjects ON subjects.SubjectId = M.SubjectId
 GROUP BY S.StudentID;
 -- 4.môn học có học sinh thi được điểm cao nhất:
 SELECT SubjectName,Students.StudentName,M.mark FROM Subjects
 JOIN Marks M ON M.SubjectId = Subjects.SubjectId
JOIN Students ON Students.StudentID = Subjects.SubjectId  WHERE M.Mark = (SELECT MAX(mark)from Marks);

-- 5.Danh so thu tu cua diem theo chieu giam:
SELECT (SELECT @COUNT :=@COUNT+1) AS 'STT' ,Mark FROM 
(SELECT @COUNT:=0 )STT, MarkS ORDER BY Mark DESC;
-- select subject. * from subject where  credit=(select max(credit) from subject); 
-- select subject. * from subject join mark m on m.subID = subject.subID
-- where m.mark=(select max(mark) from mark);
 
 -- 6. 
 ALTER TABLE Subjects MODIFY SubjectName NVARCHAR(255);
 
 -- 7.
 UPDATE Subjects SET SubjectName =CONCAT('DAT LA MON HOC ',SubjectName) ;
 
 -- 8.Viet Check Constraint de kiem tra do tuoi nhap vao trong bang Student yeu cau Age >15 va Age < 50

ALTER TABLE Students 
ADD CHECK (age>=18 and age <50);

-- 9Loai bo tat ca quan he giua cac bang
ALTER TABLE ClassStudent
DROP CONSTRAINT classstudent_ibfk_1,
DROP CONSTRAINT classstudent_ibfk_2;

ALTER TABLE marks
DROP CONSTRAINT marks_ibfk_1,
DROP CONSTRAINT marks_ibfk_2;

-- 10.Xoa hoc vien co StudentID la 1(?????????????)
DELETE FROM students WHERE StudentID = 1;
-- 11.Trong bang Student them mot column Status co kieu du lieu la Bit va co giatri Default la 1
ALTER TABLE Students
  ADD STATUS  BIT DEFAULT 1 ;
  -- 12.
UPDATE Students
SET STATUS  = 0;
