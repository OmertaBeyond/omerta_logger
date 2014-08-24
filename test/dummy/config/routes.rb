Rails.application.routes.draw do

  mount OmertaLogger::Engine => "/omerta_logger"
end
