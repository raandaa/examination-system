--Stored Procedures
--Student

create proc sp_GetStudentById @StudId int
as
	select * from Student st
	where st.Std_id=@StudId

GO 

CREATE PROCEDURE sp_SelectStudents    
AS
BEGIN
    SELECT * FROM Student 
END

GO

CREATE PROCEDURE sp_InsertStudent @Fname VARCHAR(50), @Lname VARCHAR(50), @DoB Date, @dept_id int    
AS
BEGIN
    INSERT INTO Student VALUES (@Fname, @Lname, @DoB, @dept_id) 
END

GO

CREATE PROCEDURE sp_DeleteStudent
    @StudentID INT
as
	begin try
		Delete from Student
		where Std_id=@StudentID
		return 1
	end try
	begin catch
		return -1
	end catch

GO

create proc sp_UpdateStudent @StudId int,@StudFName varchar(50),@StudLName varchar(50),@DOB Date,@DeptId int
as
	begin try
		update Student
		set Fname=@StudFName,
		    Lname=@StudLName,
			DoB=@DOB,
		    dept_id=@DeptId
		where Std_id=@StudId
		return 1
	end try
	begin catch
		return -1
	end catch
GO
----------------------------------------------------------------------------------------------------------------------------------------
--Instructor

create proc sp_GetInstuctorById @InsId int
as
	select * from Instructor Ins
	where Ins.ins_id=@InsId

GO

CREATE PROCEDURE sp_SelectInstructor 
AS
BEGIN
    SELECT * FROM Instructor 
END

GO

CREATE PROCEDURE sp_InsertInstructor @ins_name VARCHAR(50), @dept_id int    
AS
BEGIN
    INSERT INTO Instructor VALUES (@ins_name, @dept_id) 
END

GO

create proc sp_DeleteInstuctor  @InsId int
as
	begin try
		Delete from Instructor
		where ins_id=@InsId
		return 1
	end try
	begin catch
		return -1
	end catch

GO

create proc sp_UpdateInstructor @InsId int,@InsName varchar(50),@DeptId int
as
	begin try
		update Instructor
		set ins_name=@InsName,
			dept_id=@DeptId
		where ins_id=@InsId
		return 1
	end try
	begin catch
		return -1
	end catch

GO
-----------------------------------------------------------------------------------------------------------------------------------
--Course

create proc sp_GetCourseById @CrsId int
as
	select * from Course crs
	where crs.Course_id=@CrsId

GO

CREATE PROCEDURE sp_SelectCourses
AS
BEGIN
    SELECT * FROM Course 
END

GO

create proc sp_UpdateCourse @CrsId int,@CrsName varchar(50),@InsId int,@DeptId int
as
	begin try
		update Course
		set course_name=@CrsName,
			ins_id=@InsId,
			dept_id=@DeptId
		where Course_id=@CrsId
		return 1
	end try
	begin catch
		return -1
	end catch

GO
create proc sp_InsertNewCourse @CrsName varchar(50),@InsId int,@DeptId int
as
	begin try
		Insert into Course(course_name,ins_id,dept_id)
		values(@CrsName,@InsId,@DeptId)
		return 1
	end try
	begin catch
		return -1
	end catch

GO

create proc sp_DeleteCourse  @CrsId int
as
	begin try
		Delete from Course
		where Course_id=@CrsId
		return 1
	end try
	begin catch
		return -1
	end catch

GO


GO
---------------------------------------------------------------------------------------------------------------------------------------------
--Department

create proc sp_GetDepartmentById @DeptId int
as
	select * from Department
	WHERE dept_id = @DeptId

GO

CREATE PROCEDURE sp_SelectDepartments
AS
BEGIN
    SELECT * FROM Department 
END

GO

create proc sp_InsertNewDepartment @DeptName varchar(50)
as
	begin try
		Insert into Department (dept_name)
		values(@DeptName)
		return 1
	end try
	begin catch
		return -1
	end catch

GO

create proc sp_DeleteDepartment @DeptId int
as
	begin try
		Delete from Department
		where dept_id=@DeptId
		return 1
	end try
	begin catch
		return -1
	end catch

GO

create proc sp_UpdateDepartment @DeptId int,@NewDeptName varchar(50)
as
	begin try
		update Department
		set dept_name=@NewDeptName
		where dept_id=@DeptId
		return 1
	end try
	begin catch
		return -1
    end catch
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------
--Topic
CREATE PROCEDURE sp_SelectTopicByID @id int
AS
BEGIN
    SELECT * FROM Topic 
	WHERE Topic_id = @id

END

GO 

CREATE PROCEDURE sp_SelectTopics
AS
BEGIN
    SELECT * FROM Topic 
END

GO

CREATE PROCEDURE sp_InsertTopic @topicName VARCHAR(50), @crsID int
AS
BEGIN TRY
    INSERT INTO Topic VALUES (@topicName, @crsID) 
	return 1
END TRY
BEGIN CATCH
	return -1
END CATCH

GO

CREATE PROCEDURE sp_DeleteTopic
    @topicID INT
AS
BEGIN TRY
    DELETE FROM Topic WHERE Topic_id = @topicID
	return 1
END TRY
BEGIN CATCH
	return -1
END CATCH

GO

CREATE PROCEDURE sp_UpdateTopic
    @topicID INT,
	@name VARCHAR(50),
	@crsID int
AS
BEGIN TRY
    UPDATE Topic SET Topic_name = @name, crs_id = @crsID WHERE Topic_id = @topicID
	return 1
END TRY
BEGIN CATCH
	return -1
END CATCH

GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------
--Question
CREATE PROCEDURE sp_SelectQuestionByID @id int
AS
BEGIN
    SELECT * FROM Question 
	WHERE qest_id = @id

END

GO 

CREATE PROCEDURE sp_SelectQuestions
AS
BEGIN
    SELECT * FROM Question 
END

GO

CREATE PROCEDURE sp_InsertQuestion 

	@questionText VARCHAR(300), 
	@type varchar(5), 
	@weight int, 
	@level VARCHAR(5),
	@CrsID int
AS
BEGIN TRY
    INSERT INTO Question VALUES ( @questionText, @type, @weight, @level, @CrsID) 
	return 1
END TRY
BEGIN CATCH
	return -1
END CATCH

GO

CREATE PROCEDURE sp_DeleteQuestion
    @questionID INT
AS
BEGIN TRY
    DELETE FROM Question WHERE qest_id = @questionID
	return 1
END TRY
BEGIN CATCH
	return -1
END CATCH

GO

CREATE PROCEDURE sp_UpdateQuestion
    @questionID int,
	@questionText VARCHAR(300), 
	@type varchar(5), 
	@weight int, 
	@level VARCHAR(5)
AS
BEGIN TRY
    UPDATE Question SET text = @questionText, type = @type, Score = @weight, level = @level  WHERE qest_id = @questionID
	return 1
END TRY
BEGIN CATCH
	return -1
END CATCH

GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------
--Exam
CREATE PROCEDURE sp_SelectExamByID @id int
AS
BEGIN
    SELECT * FROM Exam WHERE Exam_id = @id
END

GO

CREATE PROCEDURE sp_SelectExams
AS
BEGIN
    SELECT * FROM Exam 
END

GO

CREATE PROCEDURE sp_InsertExam
	@duration int, 
	@date Date, 
	@totalMarks int, 
	@crs_id int,
	@stud_id int,
	@score int
AS
BEGIN TRY
    INSERT INTO Exam VALUES (
	@duration, 
	@date, 
	@totalMarks, 
	@crs_id,
	@stud_id,
	@score) 
	return 1
END TRY
BEGIN CATCH
	return -1
END CATCH

GO

CREATE PROCEDURE sp_DeleteExam
    @examID INT
AS
BEGIN TRY
    DELETE FROM Exam WHERE Exam_id = @examID
	return 1
END TRY
BEGIN CATCH
	return -1
END CATCH

GO

CREATE PROCEDURE sp_UpdateExam
    @examID int,
	@duration int, 
	@date Date, 
	@totalMarks int, 
	@score int
AS
BEGIN TRY
    UPDATE Exam SET duration = @duration, Date = @date, total_marks = @totalMarks, score = @score  WHERE Exam_id = @examID
	return 1
END TRY
BEGIN CATCH
	return -1
END CATCH

GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------
--Choice

CREATE PROCEDURE sp_SelectChoiceById @id int
AS
BEGIN
    SELECT * FROM Choice WHERE choice_id = @id
END

GO

CREATE PROCEDURE sp_SelectChoices
AS
BEGIN
    SELECT * FROM Choice 
END

GO

CREATE PROCEDURE sp_InsertChoice
	@txt varchar(300), 
	@is_correct bit,
	@questionID int
	
AS
BEGIN TRY
    INSERT INTO Choice VALUES (
	@txt, 
	@is_correct,
	@questionID)
	return 1
END TRY
BEGIN CATCH
	return -1
END CATCH

GO

CREATE PROCEDURE sp_DeleteChoice
    @choice_id INT, @questionID int
AS
BEGIN TRY
    DELETE FROM Choice WHERE choice_id = @choice_id AND question_id = @questionID
	return 1
END TRY
BEGIN CATCH
	return -1
END CATCH

GO

CREATE PROCEDURE sp_UpdateChoice
    @choiceID int,
	@txt varchar(300), 
	@is_correct bit,
	@questionID int
AS
BEGIN TRY
    UPDATE Choice SET text = @txt, is_correct = @is_correct  WHERE choice_id = @choiceID AND question_id = @questionID
	return 1
END TRY
BEGIN CATCH
	return -1
END CATCH

GO
-------------------------------------------------------------------------------------------------------------------------------------------------------
--Answer
CREATE PROCEDURE sp_SelectAnswerById @studId int, @questionID int, @examID int
AS
BEGIN
    SELECT * FROM Answer WHERE stud_id = @studId and question_id = @questionID and exam_id = @examID
END

GO

CREATE PROCEDURE sp_SelectAnswers
AS
BEGIN
    SELECT * FROM Answer 
END

GO

CREATE PROCEDURE sp_InsertAnswer
	@studID int,
	@questionID int,
	@examID int,
	@choiceID int
	
AS
BEGIN TRY
    INSERT INTO Answer VALUES (
	@studID,
	@questionID,
	@examID,
	@choiceID)
	return 1
END TRY
BEGIN CATCH
	return -1
END CATCH

GO

CREATE PROCEDURE sp_DeleteAnswer
    @studID INT, @questionID int, @examID int
AS
BEGIN TRY
    DELETE FROM Answer WHERE question_id = @questionID AND stud_id = @studID AND exam_id = @examID
	return 1
END TRY
BEGIN CATCH
	return -1
END CATCH

GO

CREATE PROCEDURE sp_UpdateAnswer
    @studID int,
	@questionID int,
	@examID int,
	@choiceID int
AS
BEGIN TRY
    UPDATE Answer SET choice_id = @choiceID  WHERE stud_id = @studID AND exam_id = @examID AND question_id = @questionID
	return 1
END TRY 
BEGIN CATCH
	return -1
END CATCH

GO
-------------------------------------------------------------------------------------------------------------------------------------------------------
--ExamQuestions


CREATE PROCEDURE sp_SelectExamQuestionsById @examId int
AS
BEGIN
    SELECT * FROM ExamQuestions WHERE exam_id = @examId
END

GO
CREATE PROCEDURE sp_SelectExamQuestions
AS
BEGIN
    SELECT * FROM ExamQuestions 
END

GO

CREATE PROCEDURE sp_InsertExamQuestion
	@examID int,
	@questionID int
AS
BEGIN TRY
    INSERT INTO ExamQuestions VALUES (
	@examID,
	@questionID
	)
	return 1
END TRY
BEGIN CATCH
	return -1
END CATCH

GO

CREATE PROCEDURE sp_DeleteExamQuestion
	@examID int, @questionID int
AS
BEGIN TRY
    DELETE FROM ExamQuestions WHERE question_id = @questionID AND exam_id = @examID
	return 1
END TRY
BEGIN CATCH
	return -1
END CATCH

GO

CREATE PROCEDURE sp_UpdateQuestionInExamQuestions
	@examID int,
	@oldQuestionID int,
	@newQuestionID int
AS
BEGIN TRY
    UPDATE ExamQuestions SET question_id = @newQuestionID  WHERE exam_id = @examID AND question_id = @oldQuestionID
	return 1
END TRY
BEGIN CATCH
	return -1
END CATCH

GO

CREATE PROCEDURE sp_UpdateExamInExamQuestions
	@oldExamID int,
	@questionID int,
	@newExamID int
AS
BEGIN TRY
    UPDATE ExamQuestions SET exam_id = @newExamID  WHERE exam_id = @oldExamID AND question_id = @questionID
	return 1
END TRY
BEGIN CATCH
	return -1
END CATCH

GO
-------------------------------------------------------------------------------------------------------------------------------------------------------
--StudentCourses
CREATE PROCEDURE sp_SelectStudentCoursesById @id int
AS
BEGIN
    SELECT * FROM StudentCourses  WHERE Std_id = @id
END

GO

CREATE PROCEDURE sp_SelectStudentCourses
AS
BEGIN
    SELECT * FROM StudentCourses 
END

GO

CREATE PROCEDURE sp_InsertStudentCourse
	@studID int,
	@crsID int
AS
BEGIN TRY
    INSERT INTO StudentCourses VALUES (
	@studID,
	@crsID
	)
	return 1
END TRY
BEGIN CATCH
	return -1
END CATCH

GO

CREATE PROCEDURE sp_DeleteCourseFromStudentCourses
	@studID int, @crsID int
AS
BEGIN TRY
    DELETE FROM StudentCourses WHERE Std_id = @studID AND Course_id = @crsID
	return 1
END TRY
BEGIN CATCH
	return -1
END CATCH

GO

CREATE PROCEDURE sp_UpdateCourseInStudentCourses
	@studID int, @oldCrsID int, @newCrsID int
AS
BEGIN TRY
    UPDATE StudentCourses SET Course_id = @newCrsID WHERE Std_id = @studID AND Course_id = @newCrsID
	return 1
END TRY
BEGIN CATCH
	return -1
END CATCH

GO

CREATE PROCEDURE sp_UpdateStudentInStudentCourses
	@oldStudID int, @crsID int, @newStudID int
AS
BEGIN TRY
    UPDATE StudentCourses SET Std_id = @newStudID WHERE Std_id = @oldStudID AND Course_id = @crsID
	return 1
END TRY
BEGIN CATCH
	return -1
END CATCH

GO
/*
update examQuestions
*/