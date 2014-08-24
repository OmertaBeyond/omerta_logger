module OmertaLogger
  class Family < ActiveRecord::Base
    has_many :users
    has_many :user_family_histories
    belongs_to :don, class_name: User
    belongs_to :sotto, class_name: User
    belongs_to :consig, class_name: User
    belongs_to :version

    enum city: [ :detroit, :chicago, :new_york, :las_vegas,
                 :philadelphia, :baltimore, :corleone, :palermo ]
  end
end
