module OmertaLogger
  module Import
    class Hitlist < Base
      def import
        @xml.css("hitlists hitlist").each do |xml_hitlist|
          hitlist        = @version.hitlists.find_or_create_by(ext_hitlist_id: xml_hitlist["id"].to_i)
          hitlist.date   = Time.at(xml_hitlist.css("time").text.to_i)
          hitlist.amount = Time.at(xml_hitlist.css("amount").text.to_i)
          hitlist.target = @version.users.find_or_create_by({ ext_user_id: xml_hitlist.css("target").first["id"].to_i,
                                                              name:        xml_hitlist.css("target").text })
          if xml_hitlist.css("by").first["id"].to_i != 0
            hitlist.hitlister = @version.users.find_or_create_by({ ext_user_id: xml_hitlist.css("by").first["id"].to_i,
                                                                   name:        xml_hitlist.css("by").text })
          else
            hitlist.hitlister = nil
          end
          hitlist.save
        end
      end
    end
  end
end