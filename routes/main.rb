class PetFacts < Sinatra::Application
  get '/' do
    slim :index
  end

  get('/style.css') do
    scss :'../stylesheets/style'
  end

end