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

  def create_book
    print 'Whats the book title?:'
    title = gets.chomp
    print 'Who is the author?:'
    author = gets.chomp
    book = Book.new(title, author)
    @books.push(book)
    load_books = Persist.new('books.json')
    books = load_books.load
    @books.each do |b|
      books << { title: b.title, author: b.author }
    end
    store = Persist.new('books.json')
    store.save(books)
    puts 'Awesome! Book created successfully'
  end

  # List all books
  def list_books
    load_books = Persist.new('books.json')
    books = load_books.load
    if books.empty?
      puts 'Aww, no books found'
    else
      books.each do |book|
        puts "#{book['title']} by #{book['author']}"
      end
    end
  end

  # List people
  def list_people
    load_people = Persist.new('person.json')
    people = load_people.load
    if people.empty?
      puts 'Hmm, no person found'
    else
      people.each do |person|
        puts "Name: #{person['name']} | Age: #{person['age']} | id: #{person['id']}"
      end
    end
  end

  # Create student
  # disable Metrics/MethodLength
  def create_student
    print 'What\'s the age of the new student?:'
    age = gets.chomp
    print 'What\'s the name?:'
    name = gets.chomp
    print 'Should parent permission be assigned? [Y/N]:'
    parent_permission = gets.chomp.downcase
    # save_student = []
    save = Persist.new('person.json')
    save_student = save.load

    student = Student.new(age, nil, name, parent_permission: parent_permission)
    @people.push(student)
    @people.each do |s|
      save_student << { age: s.age, name: s.name, id: s.id }
    end
    save.save(save_student)
    puts 'Awesome! Student created successfully'
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
    store = Persist.new('person.json')
    teach = store.load

    @people.each do |t|
      teach << { age: t.age, name: t.name, id: t.id }
    end

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
  # rubocop:disable Metrics/MethodLength
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
    ren = []
    @rentals.each do |r|
      ren << { date: r.date, book: r.book.title, person: r.person.name, person_id: r.person.id }
    end

    store = Persist.new('rental.json')
    store.save(_rental)

    puts 'Awesome! The book has been rented'
  end

  # List all rentals for a given person id.
  def list_rental
    load_rentals = Persist.new('rental.json')
    rentals = load_rentals.load
    load_people = Persist.new('person.json')
    people = load_people.load
    puts 'Whose rental records would you like to see?'
    people.each_with_index do |person, index|
      puts "#{index}) [#{person['class']}] Name: #{person['name']}, id: #{person['id']}, Age: #{person['age']}"
    end
    person_index = gets.chomp.to_i
    rentals.each do |r|
      puts "id: #{r['person_id']}, Date: #{r['date']}, Book: #{r['book']}, Person: #{r['person']}"
    end
  end
end
