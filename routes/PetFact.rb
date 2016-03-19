class PetFacts < Sinatra::Application
  get '/pet-fact/new' do
    if params[:key] == ENV['MASTER_KEY']
      @petFact = PetFact.new
      slim :'pet-fact/new'
    else
      'Bad Authentication Key'
    end
  end

  post '/pet-fact/new' do
    petFact = PetFact.create(params[:PetFact])
    if petFact.save
      'success'
    else
      'fail'
    end
  end
end