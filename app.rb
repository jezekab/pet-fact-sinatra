require 'sinatra'
require 'mongoid'
require 'twilio-ruby'

class PetFacts < Sinatra::Application
  disable :sessions

  # Load Mongoid
  Mongoid.load!('./config/mongoid.yml', :ENV['RACK_ENV'])

  # Load Twilio
  client = Twilio::REST::Client.new ENV['TWIL_ACC_SID'], ENV['TWIL_AUTH']

  get '/pet-fact' do
    if params[:number]
      client.account.messages.create(
          :from => ENV['TWIL_ID'],
          :to => number,
          :body => 'Hello Thread'
      )
    else
      'No Number Provided'
    end

  end

end