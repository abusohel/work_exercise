load 'dynamic_dbconnect.rb'

createdatabase=DatabaseConnect.new("practisedatabase")
#createdatabase.createSQLite
createdatabase.connectSqlite
# # createdatabase.createTable
# person1=Person.new("Shonzon","shonzon@gmail.com","male",20)
# #createdatabase.insertDatabase(person1)
# createdatabase.showInformation
# #createdatabase.deletePerson
# createdatabase.disconnect_database


loop do
  puts %q{Please select an option:
1. Add Person
2. Find Person
3. Show all person
4. Delete person
5.QUIT}
  case gets.chomp
    when '1'
      puts "Enter name:"
      name = gets.chomp
      puts "Enter Email:"
      mail = gets.chomp
      puts "Enter gender:"
      gender = gets.chomp
      puts "Enter age:"
      age = gets.chomp
      person=Person.new(name,mail,gender,age)
      createdatabase.insertDatabase(person)
      puts "...........||||...................."
    when '2'
      createdatabase.findPerson
      puts "...........||||...................."
    when '3'
      createdatabase.showInformation
      puts "...........||||...................."
    when '4'
      createdatabase.deletePerson
      puts "...........||||...................."
    when '5'
      createdatabase.disconnect_database
  end
end