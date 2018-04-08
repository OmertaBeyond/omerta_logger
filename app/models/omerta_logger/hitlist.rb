# == Schema Information
#
# Table name: omerta_logger_hitlists
#
#  id             :integer          not null, primary key
#  ext_hitlist_id :integer
#  version_id     :integer
#  date           :datetime
#  amount         :integer
#  target_id      :integer
#  hitlister_id   :integer
#

module OmertaLogger
  class Hitlist < ApplicationRecord
    belongs_to :version
    belongs_to :target, class_name: 'User', foreign_key: 'target_id',
                        inverse_of: false
    belongs_to :hitlister, class_name: 'User', foreign_key: 'hitlister_id',
                           inverse_of: false
  end
end
