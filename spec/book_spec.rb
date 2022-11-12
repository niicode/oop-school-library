require_relative './../book'

describe Book do
  context 'When testing the Book class' do
    it 'should create a new book when book class is instantiated' do
      book = Book.new('title', 'author')
      expect(book.title).to eq 'title'
      expect(book.author).to eq 'author'
    end
  end
end
