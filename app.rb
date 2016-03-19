require 'sinatra'
require 'stripe'
require 'slim'
require 'sass'
require 'mongoid'
require 'twilio-ruby'
require 'open-uri'

class PetFacts < Sinatra::Application

  def is_number?(i)
    true if Float(i) rescue false
  end

  configure do
    
  end

  # Load Mongoid
  Mongoid.load!('./config/mongoid.yml', :ENV['RACK_ENV'])

  # Load Twilio
  client = Twilio::REST::Client.new ENV['TWIL_ACC_SID'], ENV['TWIL_AUTH']

  # Load Stripe
  set :publishable_key, ENV['STRIPE_PUB']
  set :secret_key, ENV['STRIPE_SECRET']
  Stripe.api_key = settings.secret_key

  get '/send-fact' do
    slim :'send-fact'
  end

  post '/send-fact' do
    puts params[:optionsRadios]
    puts params[:number]

    case params[:optionsRadios]
      when 'animal'
        # Animal Facts
        open("https://www.pet-facts.co/pet-fact?key=#{ENV['MASTER_KEY']}&number=#{params[:number]}")

      when 'turnbull'
        # Malcolm Turnbull Quotes
        open("https://www.pet-facts.co/turnbull?key=#{ENV['MASTER_KEY']}&number=#{params[:number]}")

      when 3
        # Kim Kardashian Quotes
        open("https://www.pet-facts.co/kardashian?key=#{ENV['MASTER_KEY']}&number=#{params[:number]}")

      when 4
        # Trump Quotes
        open("https://www.pet-facts.co/trump?key=#{ENV['MASTER_KEY']}&number=#{params[:number]}")

      else
        # Something went wrong... This shouldn't be possible
        open("https://www.pet-facts.co/pet-fact?key=#{ENV['MASTER_KEY']}&number=#{params[:number]}")

    end


    slim :'thank-you'
  end


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

  get '/turnbull' do
    if params[:key] == ENV['MASTER_KEY']

      if params[:number]
        fact = Facts.random_turnbull_fact
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

  get '/donate' do
    slim :donate
  end

  post '/donate' do
    if is_number?(params[:amount].to_f)

      @amount = ((params[:amount].to_f)*100).to_i

      Stripe::Charge.create(
          :amount => @amount,
          :currency => "aud",
          :source => params[:stripeToken], # obtained with Stripe.js
          :description => "Charge for test@example.com"
      )

      slim :'thank-you'
    else
      'something went wrong up'
    end
  end



end

require_relative 'models/_init'
require_relative 'helpers/_init'
require_relative 'routes/_init'