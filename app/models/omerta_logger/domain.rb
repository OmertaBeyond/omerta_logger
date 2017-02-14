# == Schema Information
#
# Table name: omerta_logger_domains
#
#  id          :integer          not null, primary key
#  name        :string
#  api_url     :string
#  created_at  :datetime
#  updated_at  :datetime
#  archive_url :string
#

module OmertaLogger
  class Domain < ApplicationRecord
    has_many :versions, dependent: :destroy
  end
end
