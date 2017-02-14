# == Schema Information
#
# Table name: omerta_logger_version_updates
#
#  id         :integer          not null, primary key
#  version_id :integer
#  generated  :datetime
#  duration   :float
#

module OmertaLogger
  class VersionUpdate < ApplicationRecord
    belongs_to :version
  end
end
