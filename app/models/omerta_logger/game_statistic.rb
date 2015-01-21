module OmertaLogger
  class GameStatistic < ActiveRecord::Base
    belongs_to :version
  end
end
