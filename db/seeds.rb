# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

stud1 = Student.create(name: "aux",
               rut: "asdasdas1"
)
stud2 = Student.create(name: "aux2",
               rut: "asdasdas2"
)




aux = Teacher.create(name: 'Pedro',
                     last_name: 'Cortes',
                     email: 'Email@uc.cl',
                     rut: '943671137-2',
                     password: 'topsecret',
                     password_confirmation: 'topsecret'
              )

course1 = Course.create(teacher_id: aux.id,
              subject: 'math',
              grade: '8',
              level: 'b',
              )
course1.students << stud1
course1.students << stud2
course1.save

students = []
students << stud1
students << stud2
nombres =["juan","pedro","diego","jose","josefina","raul","gabriel","maria","juana","sofia"]
ruts=["23556256-3","23347118-1","23765349-8","23257839-8","23226899-2","23468343-3","23764165-6","23158042-6","23942584-7","23984934-3"]

0.upto(9) do |i|
  stuaux =  Student.create(name: nombres[i],
                 rut: ruts[i])
  course1.students << stuaux
  course1.save
  students << stuaux
end


course2 = Course.create(teacher_id: aux.id,
              subject: 'math',
              grade: 'I',
              level: 'a',
              )
Student.create(name: "aux",
               rut: "asdasdas1"
)
Student.create(name: "aux2",
               rut: "asdasdas2"
)

course2.students << stud1
course2.students << stud2
course2.save


1.upto(10) do |i|
  0.upto(students.length-1) do |j|
  Assistance.create(date: DateTime.new(2017, 5, i, 10, 0, 0),
                    attend: [true, false].sample,
                    student_id:students[j].id,
                    course_id: course1.id,
                    )
  end
end

1.upto(10) do |i|
  Assistance.create(date: DateTime.new(2017, 5, i, 11, 30, 0),
                    attend: [true, false].sample,
                    student_id:stud2.id,
                    course_id: course2.id,
                    )
  Assistance.create(date: DateTime.new(2017, 5, i, 11, 30, 0),
                    attend: [true, false].sample,
                    student_id:stud1.id,
                    course_id: course2.id,
                    )
end
