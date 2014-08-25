object @version
attributes :version, :start, :end

child :families => :families do
  extends "omerta_logger/families/show"
end

child :users => :users do
  extends "omerta_logger/users/show"
end