require_relative 'selectMenu/select'
require_relative 'selectMenu/menu_list'
require_relative 'classes/book'
require_relative 'classes/label'
require_relative 'data/preserve'

class App
  attr_accessor :books, :label

  def initialize
    @books = []
    @label = []
  end

  def colorize_output(color_code, statements)
    puts "\e[#{color_code}m#{statements}\e[0m"
  end

  def colorize_outprint(color_code, statements)
    print "\e[#{color_code}m#{statements}\e[0m"
  end

  def add_book
    puts 'Enter the name of the book:'
    name = gets.chomp
    puts 'Enter the publisher: '
    publisher = gets.chomp
    puts 'Please enter the author name:'
    author = gets.chomp
    puts 'Please enter state of the book: good or bad'
    cover_state = gets.chomp
    if cover_state != 'good' && cover_state != 'bad'
      colorize_output(31, 'Invalid state 🚫 ')
      return
    end
    puts 'Enter the published date of the book: YY-MM-DD'
    date = gets.chomp
    book = Book.new(name, publisher, cover_state, date, author)
    @books << book
    save_data(@books, './data/book.json')
    colorize_output(32, "Book '#{name}' was added successfully 🤹‍♂️✅!")
  end

  def add_label
    puts 'Enter the title of label of the book:\n'
    label_title = gets.chomp
    puts 'Enter label color of the book:\n'
    label_color = gets.chomp
    new_label = Label.new(label_title, label_color)
    @labels << new_label
    save_data(@labels, './data/label.json')
    colorize_output(32, "label '#{label_title}' was added successfully 🤹‍♂️✅!")
  end

  def list_all_books
    @books = read_data('./data/book.json')
    if @books.empty?
      colorize_output(31, 'No books found 🚫 ')
    else
      puts 'Book List:'
      @books.each_with_index do |book, index|
        print "#{index + 1}-Name: #{book['name']}, Publisher: #{book['publisher']},
       Cover state: #{book['cover_state']}, Published date: #{book['publish_date']}, Author: #{book['author']}\n\n"
      end
    end
  end

  def list_all_labels
    @labels = read_data('./data/label.json')
    if @labels.empty?
      colorize_output(31, 'No labels found')
    else
      puts "------------------------\n"
      @label.each do |label|
        print "ID: #{label.id} , Label-Title: #{label.title} , Color: #{label.color}\n"
      end
      puts "--------------------------\n\n"
    end
  end
end
