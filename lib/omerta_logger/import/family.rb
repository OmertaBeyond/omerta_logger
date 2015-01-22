module OmertaLogger
  module Import
    class Family < Base
      XML_MAPPING = { name: "name", worth: "worth", rank: "rank", user_count: "users", hq: "hq",
                      color: "color", bank: "bank" }

      def import_families
        @xml.css("families family").each do |xml_family|
          family = @version.families.find_or_create_by(ext_family_id: xml_family["id"])
          newfam = { city: enumify(xml_family.css("city").text),
                     alive: true,
                     first_seen: (@loader.generated if family.first_seen.nil?) }
          XML_MAPPING.each do |k, v|
            newfam[k] = xml_family.css(v).text
          end
          family.update_attributes(newfam)
        end
      end

      def import_tops
        @xml.css("families family").each do |xml_family|
          family        = @version.families.find_by_ext_family_id(xml_family["id"])
          don           = @version.users.find_by_ext_user_id(xml_family.css("boss").first["id"].to_i)
          family.don    = don
          sotto         = @version.users.find_by_ext_user_id(xml_family.css("sotto").first["id"].to_i)
          family.sotto  = sotto
          consig        = @version.users.find_by_ext_user_id(xml_family.css("consig").first["id"].to_i)
          family.consig = consig
        end
      end

      def import_deaths
        @xml.css("family_deaths family").each do |xml_family|
          family            = @version.families.find_or_create_by(ext_family_id: xml_family["id"])
          family.name       = xml_family.css("name").text
          family.alive      = false
          family.rip_topic  = xml_family.css("riptopic").text
          family.death_date = Time.at(xml_family.css("time").text.to_i)
          family.save
        end
      end
    end
  end
end