class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/" do
    { message: "Good luck with your project!" }.to_json
  end


  delete '/students/:id' do
    yeeted = Student.find(params[:id])
    yeeted.destroy
    yeeted.to_json
  end

  delete '/teachers/:id' do
    deleted = Teacher.find(params[:id])
    deleted.destroy
    deleted.to_json
  end

  delete '/courses/:id' do
    deleted = Course.find(params[:id])
    deleted.destroy
    deleted.to_json
  end

#delete routes
  get '/courses' do
    all_courses = Course.all
    all_courses.to_json(only: [:id, :course_name, :course_period, :total_units, :fees_amount])
  end

  get '/students' do
    all_students = Student.all
    all_students.to_json(only: [:id, :name, :race, :planet, :course_id, :teacher_id])
  end

  get '/teachers' do
    all_teachers = Teacher.all
    all_teachers.to_json(only: [:id, :name, :specialisation, :street_address, :salary])
  end

  get '/students/:id' do
    single_student = Student.find(params[:id])
    single_student.to_json(only: [:id, :name, :race, :planet], include: {
      course: { only: [:course_name]}
    })
  end

  get '/teachers/:id' do
    single_teacher = Teacher.find(params[:id])
    single_teacher.to_json(only: [:id, :name, :specialisation, :street_address, :salary],
      include: {students: {only: [:name], include: {course: {only: [:course_name]}}}}
    )
  end

  get '/courses/:id' do
    single_course = Course.find(params[:id])
    single_course.to_json(only: [:id, :course_name, :course_period, :total_units, :fees_amount], include: {students: {only: [:name]}})
  end

  get '/courses/edit/:id' do
    single_course = Course.find(params[:id])
    single_course.to_json(only: [:id, :course_period, :total_units, :fees_amount], include: {students: {only: [:name]}})
  end

end
