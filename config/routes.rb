# == Route Map
#

Rails.application.routes.draw do
  get 'forecast/index'
  post 'forecast/index'
  root 'forecast#index'
end
