# == Schema Information
#
# Table name: omerta_logger_family_name_histories
#
#  id        :integer          not null, primary key
#  name      :string
#  date      :datetime
#  family_id :integer
#

module OmertaLogger
  class FamilyNameHistory < ActiveRecord::Base
    belongs_to :family
  end
end
