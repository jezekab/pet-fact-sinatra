require 'sinatra'
require 'stripe'
require 'slim'
require 'sass'
require 'mongoid'
require 'twilio-ruby'
require 'open-uri'

class PetFacts < Sinatra::Application

  # Load Mongoid
  Mongoid.load!('./config/mongoid.yml', :ENV['RACK_ENV'])

  # Load Twilio
  client = Twilio::REST::Client.new ENV['TWIL_ACC_SID'], ENV['TWIL_AUTH']

  # Load Stripe
  set :publishable_key, ENV['STRIPE_PUB']
  set :secret_key, ENV['STRIPE_SECRET']
  Stripe.api_key = settings.secret_key


  get '/pet-fact' do
    if params[:key] == ENV['MASTER_KEY']

      if params[:number]
        fact = Facts.random_pet_fact
        puts fact
        client.account.messages.create(
            :from => ENV['TWIL_ID'],
            :to => params[:number],
            :body => "#{fact} - https://www.pet-facts.co"
        )
        'Success, we think'
      else
        'No Number Provided'
      end

    else
      'Bad Authentication Key'
    end


  end

  post '/payment' do
    puts 'woof'

    @amount = 20
    puts params[:stripeToken]
    puts 'meow'
    puts params[:number]
    puts 'coco'
    puts params[:email]
    puts 'whiskey'

    Stripe::Charge.create(
        :amount => 20,
        :currency => "aud",
        :source => params[:stripeToken], # obtained with Stripe.js
        :description => "Charge for test@example.com"
    )

    open("https://www.pet-facts.co//pet-fact?key=#{ENV['MASTER_KEY']}&number=#{params[:number]}")

    "Message Complete"

  end



end

require_relative 'models/_init'
require_relative 'helpers/_init'
require_relative 'routes/_init'