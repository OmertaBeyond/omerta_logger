# == Schema Information
#
# Table name: omerta_logger_domains
#
#  id         :integer          not null, primary key
#  name       :string
#  api_url    :string
#  created_at :datetime
#  updated_at :datetime
#

module OmertaLogger
  class Domain < ActiveRecord::Base
    has_many :versions
  end
end
