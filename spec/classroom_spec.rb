require_relative './../classroom'

describe Classroom do
  context 'When testing the Classroom class' do
    it 'should create a new classroom when Classroom class is instantiated' do
      cl = Classroom.new('1E')
      expect(cl.label).to eq '1E'
    end
  end
end
