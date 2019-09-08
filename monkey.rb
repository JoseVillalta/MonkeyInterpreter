require_relative 'lib/repl/repl'

puts("Welcome to the Monkey Interpreter")
print(">>")

line = gets.chomp
while(line)
  if line == 'exit'
    break
  end
  puts("The line is #{line}")
  r = Repl.new
  r.start(line)
  print('>> ')
  line = gets.chomp
end
