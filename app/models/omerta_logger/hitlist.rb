module OmertaLogger
  class Hitlist < ActiveRecord::Base
    belongs_to :version
    belongs_to :target, class_name: 'User', foreign_key: 'target_id'
    belongs_to :hitlister, class_name: 'User', foreign_key: 'hitlister_id'
  end
end
