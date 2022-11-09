require './book'
require './person_file'
require './rental'
require './student_file'
require './teacher_file'
require './persist'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  # Create a book
  def create_book
    print 'Whats the book title?:'
    title = gets.chomp
    print 'Who is the author?:'
    author = gets.chomp
    book = Book.new(title, author)
    @books.push(book)
    _books = []
    @books.each do |book|
      _books << { title: book.title, author: book.author }
    end
    store = Persist.new('books.json')
    store.save(_books)
    puts 'Awesome! Book created successfully'
  end

  # List all books
  def list_books
    if @books.empty?
      puts 'Aww, no books found'
    else
      @books.each do |book|
        puts "#{book.title} by #{book.author}"
      end
    end
  end

  # List people
  def list_people
    if @people.empty?
      puts 'Hmm, no person found'
    else
      @people.each do |person|
        puts "Name: #{person.name} | Age: #{person.age} | ID: #{person.id}"
      end
    end
  end

  # Create student
  def create_student
    print 'What\'s the age of the new student?:'
    age = gets.chomp
    print 'What\'s the name?:'
    name = gets.chomp
    print 'Should parent permission be assigned? [Y/N]:'
    parent_permission = gets.chomp.downcase
    case parent_permission
    when 'n'
      student = Student.new(age, nil, name, parent_permission: false)
      @people.push(student)
      puts 'Awesome! Student created successfully'
    when 'y'
      student = Student.new(age, nil, name, parent_permission: true)
      @people.push(student)
      puts 'Awesome! Student created successfully'
    end
  end

  # Create teacher
  def create_teacher
    print 'What\'s the age of the new teacher?:'
    age = gets.chomp
    print 'What about the name:'
    name = gets.chomp
    print 'What\'s the specialization?:'
    specialization = gets.chomp
    teacher = Teacher.new(age, specialization, name)
    @people.push(teacher)
    _teacher = []
    @books.each do |teacher|
      _teacher << { title: teacher.title, author: teacher.author }
    end
    store = Persist.new('person.json')
    store.save(_teacher)
    puts 'Awesome! Teacher created successfully'
  end

  # Create person
  def create_person
    print 'Start by selecting Student (1) or Teacher (2):'
    person_type = gets.chomp
    case person_type
    when '1'
      create_student
    when '2'
      create_teacher
    else
      puts 'Invalid option. Please select 1 or 2'
    end
  end

  # create rental
  def create_rental
    puts 'Let\'s begin by selecting a book from the following list'
    @books.each_with_index do |book, index|
      puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}"
    end
    book_index = gets.chomp.to_i
    puts 'Now let\'s select a person from the following list'
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    person_index = gets.chomp.to_i
    print 'Lastly lets add a date:'
    date = gets.chomp
    rental = Rental.new(date, @books[book_index], @people[person_index])
    @rentals.push(rental)
    puts 'Awesome! The book has been rented'
  end

  # List all rentals for a given person id.
  def list_rental
    puts 'Whose rental records would you like to see?'
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    person_index = gets.chomp.to_i
    @rentals.each do |rental|
      if rental.person.id == @people[person_index].id
        puts "Date: #{rental.date}, Book: #{rental.book.title}, Person: #{rental.person.name}"
      end
    end
  end
end
