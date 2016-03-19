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
    @charge = Stripe::Charge.create(
        :amount => @amount,
        :currency => "aud",
        :card => params[:stripeToken],
        :description => "Pet Facts"
    )

    slim :'/stripe/thank-you'
  end

  get('/style.css') do
    scss :'../stylesheets/style'
  end

end