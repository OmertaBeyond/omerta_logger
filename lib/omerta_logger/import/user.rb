module OmertaLogger
  module Import
    class User < Base
      def import_users
        @xml.css("users user").each do |xml_user|
          user = @version.users.find_or_create_by(ext_user_id: xml_user["id"])
          user.name = xml_user.css("name").first.text
          user.gender = enumify(xml_user.css("gender").text)
          user.rank = enumify(xml_user.css("rank").text)
          user.honor_points = xml_user.css("hps").text
          user.level = enumify(xml_user.css("level").text)
          user.donor = xml_user.css("donate").text.to_i != 0
          user.first_seen = @loader.generated if user.first_seen.nil?
          user.last_seen = @loader.generated
          xml_family = xml_user.css("family")
          if xml_family.length > 0
            user.family = @version.families.find_by({ name: xml_family.css("name").text, alive: true })
            user.family_role = enumify(xml_family.css("role").text).sub("none", "member")
          else
            user.family = nil
            user.family_role = nil
          end
          user.alive = true
          user.save
        end
      end

      def import_deaths
        @xml.css("deaths user").each do |xml_user|
          user = @version.users.find_or_create_by(ext_user_id: xml_user["id"])
          user.name = xml_user.css("name").text
          user.rank = enumify(xml_user.css("rank").text)
          xml_family = xml_user.css("family")
          user.died_without_family = true
          if xml_family.text.nil?
            user.family = nil
          else
            user.family = @version.families.find_by({ name: xml_family.text })
            user.death_family = xml_family.text
            if xml_user.css("familyid").text != "0"
              user.died_without_family = false
            end
          end

          if xml_user.css("riptopic").text === "0"
            user.akill = true
          end

          user.alive = false
          user.death_date = Time.at(xml_user.css("time").text.to_i)

          user.save
        end
      end
    end
  end
end