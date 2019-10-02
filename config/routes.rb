Rails.application.routes.draw do
  post 'results', to: 'search#results'
end
