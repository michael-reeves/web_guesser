require "sinatra"
require "sinatra/reloader"


set :secret_number, rand(100)

get '/' do
  guess = params["guess"].to_i
  message, color = check_guess(guess)
  # render the ERB template and pass in the number and message
  erb :index, :locals => { :number => settings.secret_number,
                           :message => message,
                           :color => color
                         }

end

def check_guess(guess)
  if guess > settings.secret_number + 5
    ['Way too high!', 'red']
  elsif guess > settings.secret_number
    ['Too high!', '#FF9090']
  elsif guess < settings.secret_number - 5
    ['Way too low!', 'red']
  elsif guess < settings.secret_number
    ['Too low!', '#FF9090']
  else
    ['You got it right!', 'green']
  end
end
