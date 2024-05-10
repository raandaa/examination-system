
create table Department
(
   dept_id int primary key Identity,
   dept_name  varchar(50) not null unique,
);

create table Student
(
   Std_id int primary key Identity,
   Fname  varchar(50) not null,
   Lname  varchar(50) not null,
   DoB    date  not null,
   dept_id int  not null
   CONSTRAINT FK_Student_department
        FOREIGN KEY (dept_id)
        REFERENCES Department(dept_id)
);

create table Instructor
(
   ins_id int primary key Identity,
   ins_name  varchar(50) not null,
   dept_id int not null
   CONSTRAINT FK_Instructor_department
        FOREIGN KEY (dept_id)
        REFERENCES Department(dept_id)
);

create table Course
(
   Course_id int primary key Identity,
   course_name  varchar(50) not null,
   ins_id int not null,
   dept_id int not null
   CONSTRAINT FK_Course_department
        FOREIGN KEY (dept_id)
        REFERENCES Department(dept_id),
   CONSTRAINT   FK_Course_Instructor
        FOREIGN KEY (ins_id)
        REFERENCES Instructor(ins_id)
);

create table Topic
(
   Topic_id int primary key Identity,
   Topic_name  varchar(50) not null,
   crs_id int not null
   CONSTRAINT FK_Topic_Course
        FOREIGN KEY (crs_id)
        REFERENCES Course(Course_id)
);

create table StudentCourses
(
   Std_id int,
   Course_id int
   CONSTRAINT FK_StudentCourses_Student
        FOREIGN KEY (Std_id)
        REFERENCES Student(std_id),

   CONSTRAINT   FK_StudentCourses_Course
        FOREIGN KEY (Course_id)
        REFERENCES Course(Course_id),

   CONSTRAINT PK_StudentCourses PRIMARY KEY (Std_id, Course_id)
);

create table Exam
(
   Exam_id int primary key Identity,
   duration  int not null,
   Date date not null,
   total_marks int,
   crs_id int not null,
   stud_id int not null,
   score int 
   CONSTRAINT FK_Exam_Student
        FOREIGN KEY (stud_id)
        REFERENCES Student(std_id),
   CONSTRAINT   FK_Exam_Course
        FOREIGN KEY (crs_id)
        REFERENCES Course(Course_id)
);

create table Question
(
   qest_id int primary key Identity,
   text  varchar(300) not null,
   type  varchar(5) not null,
   Score int not null,     --weight
   level varchar(5) not null,
);

create table ExamQuestions
(
   exam_id int,
   question_id int 

   CONSTRAINT   FK_ExamQuestions_Question
        FOREIGN KEY (question_id)
        REFERENCES Question(qest_id),

   CONSTRAINT FK_ExamQuestions_Exam
        FOREIGN KEY (exam_id)
        REFERENCES Exam(Exam_id),
   CONSTRAINT PK_ExamQuestions PRIMARY KEY (exam_id, question_id)
);    


create table Choice
(
   choice_id int Identity,
   text  varchar(300) not null,
   is_correct bit not null,
   question_id int not null
   CONSTRAINT FK_Choice_question
        FOREIGN KEY (question_id)
        REFERENCES Question(qest_id),
   CONSTRAINT PK_ChoiceQuestions PRIMARY KEY (choice_id, question_id)

);
alter table Choice
drop CONSTRAINT PK_ChoiceQuestions

alter table Choice
Add Primary key(choice_id)

create table Answer
(
   stud_id int,
   question_id int,
   exam_id int ,
   choice_id int not null

   CONSTRAINT FK_Answer_Student
        FOREIGN KEY (stud_id)
        REFERENCES Student(std_id),

   CONSTRAINT   FK_Answer_Question
        FOREIGN KEY (question_id)
        REFERENCES Question(qest_id),

   CONSTRAINT FK_Answer_Exam
        FOREIGN KEY (exam_id)
        REFERENCES Exam(Exam_id),

   CONSTRAINT   FK_Answer_Choice
        FOREIGN KEY (choice_id)
        REFERENCES Choice(Choice_id),

   CONSTRAINT PK_Answer PRIMARY KEY (stud_id, question_id, exam_id)
);

--Select ,Insert update and delete in any table
--------------DEPARTMENT------------------------

create function GetDepartmentById(@DeptId int)
returns table
as 
return
(
	select Dept.* from Department Dept where Dept.dept_id=@DeptId
)

--Get Department by Id
create proc sp_GetDepartmentById @DeptId int
as
	select * from GetDepartmentById(@DeptId)


--Insert new table
create proc sp_InsertNewDepartment @DeptName varchar(50)
as
	begin try
		Insert into Department (dept_name)
		values(@DeptName)
	end try
	begin catch
		select 'This Department already exists'
	end catch


--Update Department table
create proc sp_UpdateDepartment @DeptId int,@NewDeptName varchar(50)
as
	begin try
		update Department
		set dept_name=@NewDeptName
		where dept_id=@DeptId
	end try
	begin catch
		select 'Could not update...The New Name already taken'
end catch

--Delete Department table
create proc sp_DeleteDepartment @DeptId int
as
	begin try
		Delete from Department
		where dept_id=@DeptId
	end try
	begin catch
		select 'Could not delete the table'
	end catch




---------------STUDENT---------------------

create proc sp_GetStudentById @StudId int
as
	select * from Student st
	where st.Std_id=@StudId


--Insert new table
create proc sp_InsertNewStudent @StudFName varchar(50),@StudLName varchar(50),@DOB Date,@DeptId int
as
	begin try
		Insert into Student (Fname,Lname,DoB,dept_id)
		values(@StudFName,@StudLName,@DOB,@DeptId)
	end try
	begin catch
		select 'Could not add this student'
	end catch


--Update Student table
create proc sp_UpdateStudent @StudId int,@StudFName varchar(50),@StudLName varchar(50),@DOB Date,@DeptId int
as
	begin try
		update Student
		set Fname=@StudFName,
		    Lname=@StudLName,
			DoB=@DOB,
			dept_id=@DeptId
		where Std_id=@StudId
	end try
	begin catch
		select 'Could not update the student record'
	end catch

--Delete Student table
create proc sp_DeleteStudent @StudId int
as
	begin try
		Delete from Student
		where Std_id=@StudId
	end try
	begin catch
		select 'Could not delete this student'
	end catch


------------INSTRUCTOR-------------------

create proc sp_GetInstuctorById @InsId int
as
	select * from Instructor Ins
	where Ins.ins_id=@InsId


--Insert new table
create proc sp_InsertNewInstructor @InsName varchar(50),@DeptId int
as
	begin try
		Insert into Instructor(ins_name,dept_id)
		values(@InsName,@DeptId)
	end try
	begin catch
		select 'Could not add this Instuctor'
	end catch


--Update INSTRUCTOR table
create proc sp_UpdateInstructor @InsId int,@InsName varchar(50),@DeptId int
as
	begin try
		update Instructor
		set ins_name=@InsName,
			dept_id=@DeptId
		where ins_id=@InsId
	end try
	begin catch
		select 'Could not update the Instructor record'
	end catch

--Delete INSTRUCTOR table
create proc sp_DeleteInstuctor  @InsId int
as
	begin try
		Delete from Instructor
		where ins_id=@InsId
	end try
	begin catch
		select 'Could not delete this instructor'
	end catch

	------------COURSE-------------------

create proc sp_GetCourseById @CrsId int
as
	select * from Course crs
	where crs.Course_id=@CrsId


--Insert new table
create proc sp_InsertNewCourse @CrsName varchar(50),@InsId int,@DeptId int
as
	begin try
		Insert into Course(course_name,ins_id,dept_id)
		values(@CrsName,@InsId,@DeptId)
	end try
	begin catch
		select 'Could not add this course'
	end catch


--Update Course table
create proc sp_UpdateCourse @CrsId int,@CrsName varchar(50),@InsId int,@DeptId int
as
	begin try
		update Course
		set course_name=@CrsName,
			ins_id=@InsId,
			dept_id=@DeptId
		where Course_id=@CrsId
	end try
	begin catch
		select 'Could not update this course record'
	end catch

--Delete Course table
create proc sp_DeleteCourse  @CrsId int
as
	begin try
		Delete from Course
		where Course_id=@CrsId
	end try
	begin catch
		select 'Could not delete this course'
	end catch