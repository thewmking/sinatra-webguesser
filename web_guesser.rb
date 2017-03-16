require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)
number = SECRET_NUMBER

get '/' do
  guess = params["guess"]
  if guess.to_s.empty? == true
    message = "Guess the secret number!"
  else
    message = check_guess(guess, number)
  end
  erb :index, :locals => {:number => number, :message => message}
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
