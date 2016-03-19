class PetFacts < Sinatra::Application
  get '/pet-fact' do
    if params[:key] == ENV['MASTER_KEY']

      if params[:number]
        client.account.messages.create(
            :from => ENV['TWIL_ID'],
            :to => params[:number],
            :body => 'Hello Thread'
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