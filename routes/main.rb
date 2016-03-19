require 'open-uri'

class PetFacts < Sinatra::Application
  get '/' do
    slim :index
  end

  get '/payment' do
    slim :payment
  end

  post '/payment' do
    @amount = 20

    if true
      @charge = Stripe::Charge.create(
          :amount => @amount,
          :currency => "aud",
          :card => params[:stripeToken],
          :description => "Pet Facts"
      )
      puts params[:number]
      str = open("http://www.pet-facts.co/pet-fact?key=#{ENV['MASTER_KEY']}&number=#{params[:number]}")
      puts str

      slim :'/stripe/thank-you'
    else
      slim :'/error/stripe-fail'
    end
  end

  get('/style.css') do
    scss :'../stylesheets/style'
  end

end