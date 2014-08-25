object @family
attributes :ext_family_id => :id
attributes :name, :worth, :rank, :user_count, :hq, :color, :bank,
           :city, :alive, :first_seen, :death_date, :rip_topic

child :users => :users do
  extends "omerta_logger/users/show", :locals => { :hide_family => true }
end unless locals[:hide_users]