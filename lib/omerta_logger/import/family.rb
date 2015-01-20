module OmertaLogger
  module Import
    class Family < Base
      def import_families
        @xml.css("families family").each do |xml_family|
          family = @version.families.find_or_create_by(ext_family_id: xml_family["id"])
          family.name = xml_family.css("name").text
          family.worth = xml_family.css("worth").text
          family.rank = xml_family.css("rank").text
          family.user_count = xml_family.css("users").text
          family.hq = xml_family.css("hq").text
          family.color = xml_family.css("color").text
          family.bank = xml_family.css("bank").text
          family.city = enumify(xml_family.css("city").text)
          family.alive = true
          family.first_seen = @loader.generated if family.first_seen.nil?
          family.save
        end
      end

      def import_tops
        @xml.css("families family").each do |xml_family|
          family = @version.families.find_by_ext_family_id(xml_family["id"])
          don = @version.users.find_by_ext_user_id(xml_family.css("boss").first["id"].to_i)
          family.don = don
          sotto = @version.users.find_by_ext_user_id(xml_family.css("sotto").first["id"].to_i)
          family.sotto = sotto
          consig = @version.users.find_by_ext_user_id(xml_family.css("consig").first["id"].to_i)
          family.consig = consig
        end
      end

      def import_deaths
        @xml.css("family_deaths family").each do |xml_family|
          family = @version.families.find_or_create_by(ext_family_id: xml_family["id"])
          family.name = xml_family.css("name").text
          family.alive = false
          family.rip_topic = xml_family.css("riptopic").text
          family.death_date = Time.at(xml_family.css("time").text.to_i)
          family.save
        end
      end
    end
  end
end