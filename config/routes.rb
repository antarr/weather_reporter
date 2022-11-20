# == Route Map
#

Rails.application.routes.draw do
  get 'forecast/index'
  post 'forecast/search'
  root 'forecast#index'
end
