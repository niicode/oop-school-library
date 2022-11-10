require_relative './../person_file'

describe Person do
  context 'When testing the Person class' do
    it 'should create a new book when person class is instantiated' do
      person = Person.new(34, 'Duane David')
      id = person.id
      expect(person.age).to eq 34
      expect(person.name).to eq 'Duane David'
      expect(person.id).to eq id
    end
  end
end