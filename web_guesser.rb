require 'sinatra'
require 'sinatra/reloader'

@@guesses_remaining = 5
SECRET_NUMBER = rand(100)
number = SECRET_NUMBER

get '/' do
  guess = params["guess"]
  if params['cheat'] == "true"
    cheat_message = "The secret number is #{number}"
  end

  if guess.to_s.empty? == true
    message = "Guess the secret number!"
  elsif guess.to_i == number
    message = "You win! Let's play again. Guess the secret number!"
    number = rand(100)
    @@guesses_remaining = 5
  elsif @@guesses_remaining > 1
    message = check_guess(guess, number)
    @@guesses_remaining -=1
    message_two = "#{@@guesses_remaining} guesses left."
  else
    message = "You lose! Oh well. Let's start over. Guess the secret number!"
    number = rand(100)
    @@guesses_remaining = 5
  end

  erb :index, :locals => {:number => number, :message => message, :message_two => message_two, :cheat_message => cheat_message}

end

def check_guess(guess, number)
  if guess.to_i > (number + 5)
    message = "Way too high! Try again."
  elsif guess.to_i > number
    message = "Too high! Try again."
  elsif guess.to_i < (number - 5)
    message = "Way too low! Try again."
  elsif guess.to_i < number
    message = "Too low! Try again."
  else
    message = "You guessed right! The secret number is #{number}"
  end
end
