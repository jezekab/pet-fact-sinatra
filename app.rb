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
    client.account.messages.create(
        :from => ENV['TWIL_ID'],
        :to => ENV['PERSONAL'],
        :body => 'Hello babe.'
    )
  end

end