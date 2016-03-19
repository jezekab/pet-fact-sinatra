require 'open-uri'

class PetFacts < Sinatra::Application
  get '/' do
    slim :index
  end

  get '/payment' do
    slim :payment
  end

  get('/style.css') do
    scss :'../stylesheets/style'
  end

  error Stripe::CardError do
    env['sinatra.error'].message
  end

end