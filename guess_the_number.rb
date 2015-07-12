# guess_the_number.rb
# By Luke A Chase
# chase.luke.a@gmail.com
# Copyright 2015

# /-------------------------------FUNCTIONS-----------------------------------\

## This is awesome. :)
def pc_speak(message)
  characters = message.split("")
  characters.each do |char|
    print char
    if char =~ /\A[ |.|,|:|;]\Z/
      sleep 0.08
    else
      sleep 0.02
    end
  end
end

def pc_prompt(question)
  pc_speak(question)
  gets.chop
end

def prompt(question)
  print question
  gets.chop
end

# accepts input value and regular expression to check, returns true or false
def valid_input(input, regex)
  !!(input =~ regex)
end

## The multiple returns in this function aren't necessary. And you can improve
## on this logic using Ruby symbols:
#
# def check_answer(guessed_number, actual_number)
#   if guessed_number == actual_number
#      :match
#   elsif guessed_number < actual_number
#      :low
#   else
#      :high
#   end
# end
#
# Or you could compact it:
#
# def check_answer(guessed_number, actual_number)
#   result = :high # default value
#   result = :match if guessed_number == actual_number
#   result = :low if guessed_number < actual_number
# end
#
# Then you can just check the symbol value later.
def check_answer(guessed_number, actual_number)
  if guessed_number == actual_number
    return 0 # won
  elsif guessed_number < actual_number
    return 1 # low
  else
    return 2 # high
  end
end

def game_won_message(guess_total)
  message = "\n$ You guessed my number in #{guess_total} "

  if guess_total == 1
    message += "guess"
  else
    message += "guesses"
  end

  case guess_total
  when 1
    message += "! You're a mind reader!"
  when 2, 3, 4
    message += "! That is most impressive."
  when 5, 6
    message += ". You can do better than that."
  else
    message += "... I'm sorry, better luck next time."
  end
end
# \---------------------------------------------------------------------------/

# /----------------------------------MAIN-------------------------------------\
# Global declarations
play_game = false
difficulty = [10, 100, 1000]

# Welcome, Chip ;)
pc_speak "\n$ Hi, I'm Chip. ;)\n\n"
sleep 0.50
pc_speak "$ Would you like to play a game? "
sleep 0.25
play_game = true if prompt("\('y' or 'n'\):\n> ") =~ /\A[y|Y]\Z/

while play_game do
  # New game declarations
  number_of_guesses = 0
  game_won = false

  game = pc_prompt "\n$ What game would you like to play?\n> "

  if game == "guess the number"
    pc_speak "\n$ Oh, I know that one! Lets play! =)\n\n"
  else
    pc_speak "\n$ I'm sorry, I don't know \"#{game}.\"\n\n"
    pc_speak "$ Lets play \"guess the number\" instead. :)\n\n"
  end

  begin
    difficulty_level = pc_prompt "$ Choose a difficulty level => 1, 2, or 3:\n> "
  end while !valid_input(difficulty_level, /\A[1|2|3]\Z/)
  difficulty_level = difficulty[difficulty_level.to_i-1]

  pc_speak "\n$ OK. I'll think of a number from 1 to #{difficulty_level}\n\n"
  pc_speak "    Thinking"
  8.times do
    print "."
    sleep 0.25
  end

  actual_number = 1 + rand(difficulty_level)
  pc_speak "\n\n$ Ok, I have a number in mind. What is your guess?\n"

  while !game_won do
    guessed_number = prompt "> Enter guess: "
    number_of_guesses += 1

    if valid_input(guessed_number, /\A[0-9]+\Z/)
      case check_answer(guessed_number.to_i, actual_number.to_i)
      ## see, if you use symbols here, you don't need the comments.
      # when :won
      #   game_won = true
      # when :low
      #   pc_speak.....
      # when :high
      #
      # Symbols are awesome. Use them.
      when 0 # won
        game_won = true
      when 1 # low
        pc_speak "\n$ Too low. Guess again.\n"
      when 2 # high
        pc_speak "\n$ Too high. Guess again.\n"
      end
    else
      pc_speak "\n$ I'm sorry, you must enter a valid integer. Please try again."
    end
  end
  pc_speak "#{game_won_message(number_of_guesses)}\n\n"

  pc_speak "$ Would you like to play another game? "
  
  ## Here's where I'd flip the logic to the positive. The =~ in Ruby will evaluate to a true or nil which is false.
  ## No need for the if statement.
  # play_game = prompt("\('y' or 'n'\):\n> ") =~ /\A[y|Y]\Z/
  play_game = false if prompt("\('y' or 'n'\):\n> ") =~ /\A[n|N]\Z/
end

## it seems to me that the $ could be part of the pc_speak function
## which would then allow you to change the prompt :)
pc_speak "\n$ Thank you. I enjoyed our interaction.\n"
sleep 0.50
pc_speak "\n$ Goodbye.\n\n"
# \---------------------------------------------------------------------------/
