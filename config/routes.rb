Rails.application.routes.draw do
  # I assumed I do not need any versioning on my side
  post 'results', to: 'search#results', :defaults => { :format => :json }
end
