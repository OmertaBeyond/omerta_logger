object @user
attributes :ext_user_id => :id
attributes :name, :gender, :rank, :honor_points,:level, :donor,
           :family_role, :first_seen, :last_seen, :alive, :akill,
           :death_date, :death_family, :died_without_family, :rip_topic

node(:family) do |user|
  partial "omerta_logger/families/show", :object => user.family, :locals => { :hide_users => true }
end unless locals[:hide_family]