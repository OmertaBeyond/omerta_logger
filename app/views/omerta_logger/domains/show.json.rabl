object @domain
attributes :name => :domain_name
child :versions => :versions do
  extends "omerta_logger/versions/show"
end