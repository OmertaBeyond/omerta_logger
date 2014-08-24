module OmertaLogger
  class UserFamilyHistory < ActiveRecord::Base
    belongs_to :user
    belongs_to :family
    enum family_role: [ :member, :capo, :sotto, :consig, :don ]
  end
end
