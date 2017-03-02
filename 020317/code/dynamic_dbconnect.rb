require 'rubygems'
require 'sqlite3'

class DatabaseConnect
  attr_accessor :databaseName,:dbconnect
  def initialize(databaseName)
    @databaseName=databaseName
  end
  def createSQLite
    @dbconnect=SQLite3::Database.new(@databaseName)
    puts "new Database created"
  end

  def connectSqlite
    begin
      @dbconnect = SQLite3::Database.open(@databaseName)
      puts "SUCCESSFULLY Connect"
      @dbconnect.results_as_hash = true
    rescue SQLite3::Exception => e
      puts "Exception occurred"
      puts e
    end
  end

  def createTable
    @dbconnect.execute %q{
        CREATE TABLE IF NOT EXISTS person(
        id integer primary key,
        name varchar(50),
        email varchar(50),
        gender varchar(6),
        age integer)
      }
    puts "Table created"
  end

  def insertDatabase(user)
    @dbconnect.execute("INSERT INTO person (name, email, gender, age) VALUES (?, ?, ?, ?)",user.name,user.mail,user.gender,user.age)
  end

  def findPerson
    puts "Enter name or ID of person to find:"
    id = gets.chomp
    person = @dbconnect.execute("SELECT * FROM person WHERE name = ? OR id = ?", id, id.to_i).first
    unless person
      puts "No result found"
      return
    end
    puts %Q{Name: #{person['name']}
    E-mail: #{person['email']}
    Gender: #{person['gender']}
    Age: #{person['age']}}
  end

  # def showInformation
  #   @dbconnect.execute("SELECT * FROM person") do |rows|
  #     # puts rows[0].to_s+"  "+rows[1].to_s+"  "+rows[2].to_s+"  "+rows[3].to_s+"  "+rows[4].to_s
  #     puts rows.inspect
  #   end
  # end
  def showInformation
    person=@dbconnect.execute "SELECT * FROM person"
    puts %Q{ID   ||Name   ||Email    ||Gender    ||Age    }
    puts"========================================================"
    person.each do |person|

      puts %Q{#{person['id']}||#{person['name']} || #{person['email']} || #{person['gender']} ||#{person['age']}}

      puts"========================================================"
    end
  end

  def deletePerson
    puts "Enter name or ID of person to delete:"
    id = gets.chomp
    person = @dbconnect.execute("DELETE FROM person WHERE name = ? OR id = ?", id, id.to_i).first
    puts "Data Deleted"
    showInformation
  end

  def disconnect_database
    @dbconnect.close
    puts "Database Disconnected"
    exit
  end
end

class Person
  attr_accessor :name,:mail,:gender,:age
  def initialize(name,mail,gender,age)
    @name=name
    @mail=mail
    @gender=gender
    @age=age
  end
end