module OmertaLogger
  module Import
    class Hitlist < Base
      def set_target(hitlist, xml_hitlist)
        hitlist.target = @version.users.find_or_create_by(ext_user_id: xml_hitlist.css('target').first['id'].to_i,
                                                          name:        xml_hitlist.css('target').text)
      end

      def set_hitlister(hitlist, xml_hitlist)
        if xml_hitlist.css('by').first['id'].to_i != 0
          hitlist.hitlister = @version.users.find_or_create_by(ext_user_id: xml_hitlist.css('by').first['id'].to_i,
                                                               name:        xml_hitlist.css('by').text)
        else
          hitlist.hitlister = nil
        end
      end

      def import
        @xml.css('hitlists hitlist').each do |xml_hitlist|
          hitlist        = @version.hitlists.find_or_create_by(ext_hitlist_id: xml_hitlist['id'].to_i)
          hitlist.date   = Time.at(xml_hitlist.css('time').text.to_i)
          hitlist.amount = Time.at(xml_hitlist.css('amount').text.to_i)
          set_target(hitlist, xml_hitlist)
          set_hitlister(hitlist, xml_hitlist)

          hitlist.save
        end
      end
    end
  end
end
