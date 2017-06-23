# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

aux = Teacher.create(name: 'Pedro',
                     last_name: 'Cortes',
                     email: 'Email@uc.cl',
                     rut: '943671137-2',
                     password: 'topsecret',
                     password_confirmation: 'topsecret')

aux2 = Teacher.create(name: 'Diego',
                      last_name: 'Sinay',
                      email: 'dsinay@uc.cl',
                      rut: '123123-2',
                      admin: true,
                      password: '123123',
                      password_confirmation: '123123')

aux3 = Teacher.create(name: 'Juana',
                       last_name: 'Margara',
                       email: 'jnmar@uc.cl',
                       rut: '8532316-5',
                       admin: true,
                       password: '123123',
                       password_confirmation: '123123')

aux4 = Teacher.create(name: 'Gabriel',
                        last_name: 'Niai',
                        email: 'gabrieln@uc.cl',
                        rut: '10257537-9',
                        admin: false,
                        password: '123123',
                        password_confirmation: '123123')

course1 = Course.create(teacher_id: aux.id,
                        subject: 'Math',
                        grade: '8',
                        level: 'b')

course4 = Course.create(teacher_id: aux3.id,
                        subject: 'Chemistry',
                        grade: '8',
                        level: 'b')

course5 = Course.create(teacher_id: aux4.id,
                        subject: 'English',
                        grade: '8',
                        level: 'b')



students = []

nombres = %w[juan pedro diego jose josefina raul gabriel maria juan sofia]
last_names = %w[hais cortez besa drago gana sullivan wulf rivas ovalle navarro]

ruts = ['23556256-3', '23347118-1', '23765349-8', '23257839-8',
        '23226899-2', '23468343-3', '23764165-6', '23158042-6', '23942584-7', '23984934-3']

0.upto(4) do |i|
  stuaux = Student.create(name: nombres[i], rut: ruts[i], last_name: last_names[i])
  course1.students << stuaux
  course1.save
  course5.students << stuaux
  course5.save
  course4.students << stuaux
  course4.save
  students << stuaux
end

course2 = Course.create(teacher_id: aux2.id,
                        subject: 'English',
                        grade: '12',
                        level: 'HL2')

5.upto(9) do |i|
  stuaux = Student.create(name: nombres[i], rut: ruts[i], last_name: last_names[i])
  course2.students << stuaux
  course2.save
  students << stuaux
end

20.upto(29) do |i|
  0.upto(4) do |j|
    Assistance.create(date: DateTime.new(2017, 5, i, 10, 0, 0),
                      attend: [true, true, true, false].sample,
                      student_id: students[j].id,
                      course_id: course1.id)
    Assistance.create(date: DateTime.new(2017, 5, i, 10, 0, 0),
                      attend: [true, true, true, false].sample,
                      student_id: students[j].id,
                      course_id: course4.id)
    Assistance.create(date: DateTime.new(2017, 5, i, 10, 0, 0),
                      attend: [true, true, true, false].sample,
                      student_id: students[j].id,
                      course_id: course5.id)
  end
end

12.upto(20) do |i|
  5.upto(9) do |j|
    Assistance.create(date: DateTime.new(2017, 5, i, 10, 0, 0),
                      attend: [true, true, true, false].sample,
                      student_id: students[j].id,
                      course_id: course2.id)
  end
end
