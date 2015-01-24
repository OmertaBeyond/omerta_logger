object @user
attributes :ext_user_id => :id
attributes :name, :gender, :rank, :honor_points,:level, :donor,
           :family_role, :first_seen, :last_seen, :alive, :akill,
           :death_date, :death_family, :died_without_family, :rip_topic,
           :online_percentage

node(:family) do |user|
  partial "omerta_logger/families/show", :object => user.family, :locals => { :hide_users => true }
end unless locals[:hide_family]

child :user_name_histories => :name_changes do
  extends "omerta_logger/user_name_histories/show"
end

child :user_rank_histories => :promotions do
  extends "omerta_logger/user_rank_histories/show"
end

child :user_revives => :revives do
  extends "omerta_logger/user_revives/show"
end