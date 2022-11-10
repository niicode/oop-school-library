require_relative './../student_file'

describe Student do
  context 'When testing the Student class' do
    it 'should create a new Student when student class is instantiated' do
      student = Student.new(23,'primary 3', 'Inieke')
      expect(student.age).to eq 23
      expect(student.name).to eq 'Inieke'
    end
  end
end
