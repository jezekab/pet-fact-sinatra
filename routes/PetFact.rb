class PetFacts < Sinatra::Application
  get '/pet-fact/new' do
    if params[:key] == ENV['MASTER_KEY']
      slim :'pet-fact/new'
    else
      'Bad Authentication Key'
    end
  end

  post '/pet-fact/new' do
    PetFact = PetFact.create(params[:PetFact])
    if PetFact.save
      'success'
    else
      'fail'
    end
  end
end