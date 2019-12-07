require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  mount OmertaLogger::Engine => '/omerta_logger'
  mount Sidekiq::Web => '/sidekiq'
end
