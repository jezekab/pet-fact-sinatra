class PetFacts < Sinatra::Application
  get '/turnbull/new' do
    if params[:key] == ENV['MASTER_KEY']
      @turnbull = Turnbull.new
      slim :'turnbull/new'
    else
      'Bad Authentication Key'
    end
  end

  post '/turnbull/new' do
    turnbull = Turnbull.create(params[:Turnbull])
    if turnbull.save
      'success'
    else
      'fail'
    end
  end
end