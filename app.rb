require 'sinatra'
require 'stripe'
require 'slim'
require 'sass'
require 'mongoid'
require 'twilio-ruby'

class PetFacts < Sinatra::Application
  disable :sessions

  # Load Mongoid
  Mongoid.load!('./config/mongoid.yml', :ENV['RACK_ENV'])

  # Load Twilio
  client = Twilio::REST::Client.new ENV['TWIL_ACC_SID'], ENV['TWIL_AUTH']

  # Load Stripe
  set :publishable_key, ENV['STRIPE_PUB']
  set :secret_key, ENV['STRIPE_SECRET']

  Stripe.api_key = settings.secret_key

  configure :production do
    set :clean_trace, true

  end

  get '/pet-fact' do
    if params[:key] == ENV['MASTER_KEY']

      if params[:number]
        fact = Facts.random_pet_fact
        puts fact
        client.account.messages.create(
            :from => ENV['TWIL_ID'],
            :to => params[:number],
            :body => fact
        )
        'Success, we think'
      else
        'No Number Provided'
      end

    else
      'Bad Authentication Key'
    end


  end

end

require_relative 'models/_init'
require_relative 'helpers/_init'
require_relative 'routes/_init'