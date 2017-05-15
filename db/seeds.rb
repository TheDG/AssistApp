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


Course.create(teacher_id: aux.id,
              subject: 'math',
              grade: 'I',
              level: 'a',
              )

