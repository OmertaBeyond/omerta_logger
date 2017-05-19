object @family
attributes ext_family_id: :id
attributes :name, :worth, :rank, :user_count, :hq, :color, :bank,
           :city, :alive, :first_seen, :death_date, :rip_topic, :position

unless locals[:hide_users]
  child users: :users do
    extends 'omerta_logger/users/show', locals: { hide_family: true }
  end
end

child family_name_histories: :name_changes do
  extends 'omerta_logger/family_name_histories/show'
end
