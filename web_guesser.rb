require "sinatra"
require "sinatra/reloader"


set :secret_number, rand(100)

get '/' do
  guess = params["guess"].to_i
  message = check_guess(guess)
  # render the ERB template and pass in the number and message
  erb :index, :locals => { :number => settings.secret_number,
                           :message => message
                         }

end

def check_guess(guess)
  if guess > settings.secret_number + 5
    'Way too high!'
  elsif guess > settings.secret_number
    'Too high!'
  elsif guess < settings.secret_number - 5
    'Way too low!'
  elsif guess < settings.secret_number
    'Too low!'
  else
    'You got it right!'
  end
end
