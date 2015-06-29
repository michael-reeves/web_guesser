require "sinatra"
require "sinatra/reloader"


def reset
  @@guesses = 5
  @@secret_number = rand(100)
end

reset

get '/' do
  guess = params["guess"].to_i
  message, color = check_guess(guess)
  reset if color == 'green'

  # render the ERB template and pass in the number and message
  erb :index, :locals => { :number => @@secret_number,
                           :message => message,
                           :color => color,
                           :guesses => @@guesses
                         }
end

def check_guess(guess)
  if guess > @@secret_number + 5
    result = ["Way too high!", 'red']
  elsif guess > @@secret_number
    result = ["Too high!", '#FF9090']
  elsif guess < @@secret_number - 5
    result = ["Way too low!", 'red']
  elsif guess < @@secret_number
    result = ["Too low!", '#FF9090']
  else
    @@guesses = 5
    result = ['You got it right! A new number has been created.', 'green']
  end

  @@guesses -= 1

  if @@guesses == 0
    reset
    unless result[1] == 'green'
      result = ['You ran out of guesses. A new number has been created.',
                'white']
    end
  end

  return result
end

