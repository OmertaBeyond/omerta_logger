require 'time_difference'

module OmertaLogger
  module Import
    class User < Base
      def calculate_online_time_increment
        @online_time_increment = TimeDifference.between(
          @previous_version_update.generated,
          @version_update.generated
        ).in_seconds
        @missed_cycles = false
        return unless @online_time_increment >= 10 * 60
        # 10 minutes between updates probably means we missed a few cycles
        # let's take an educated guess of 5 minutes
        @online_time_increment = 5 * 60
        @missed_cycles         = true
        Rails.logger.warn "online_time_increment value of #{@online_time_increment}s indicating missed cycles"
      end

      def update_online_time(user)
        user.online_time_seconds += @online_time_increment
        last_online_time = user.last_user_online_time
        if last_online_time.nil? || last_online_time.end != @previous_version_update.generated || @missed_cycles
          user.user_online_times.create(start: @previous_version_update.generated, end: @version_update.generated)
        else
          last_online_time.end = @version_update.generated
          last_online_time.save
        end
      end

      def update_family(user, xml_family)
        if !xml_family.empty?
          user.family      = @version.families.find_by(name: xml_family.css('name').text, alive: true)
          user.family_role = enumify(xml_family.css('role').text.sub('None', 'Member'))
          Rails.logger.debug "user #{user.name}: set new family #{user.family.name}"
        else
          user.family      = nil
          user.family_role = nil
          Rails.logger.debug "user #{user.name}: removed family"
        end
      end

      def import
        import_users
        import_deaths
      end

      def import_users
        calculate_online_time_increment
        @xml.css('users user').each do |xml_user|
          user = @version.users.find_or_create_by(ext_user_id: xml_user['id'])
          user.assign_attributes(name: xml_user.at_css('name').text,
                                 gender: enumify(xml_user.css('gender').text),
                                 rank: enumify(xml_user.css('rank').text),
                                 honor_points: xml_user.css('hps').text,
                                 level: enumify(xml_user.css('level').text),
                                 donor: xml_user.css('donate').text.to_i != 0,
                                 first_seen: user.first_seen || @loader.generated,
                                 last_seen: @loader.generated,
                                 alive: true)
          update_online_time(user)
          update_family(user, xml_user.css('family'))
          user.save
          Rails.logger.debug "imported user #{user.name}"
        end
      end

      def update_death_family(user, xml_user)
        xml_family = xml_user.css('family')
        user.died_without_family = true
        if xml_family.text.nil?
          user.family = nil
          Rails.logger.debug "user #{user.name} died without family"
        else
          user.death_family = xml_family.text
          user.died_without_family = false if xml_user.css('familyid').text != '0'
          Rails.logger.debug "user #{user.name} died in family #{user.death_family}"
        end
      end

      def import_deaths
        @xml.css('deaths user').each do |xml_user|
          user      = @version.users.find_or_create_by(ext_user_id: xml_user['id'])
          user.name = xml_user.css('name').text
          user.rank = enumify(xml_user.css('rank').text)

          update_death_family(user, xml_user)

          user.akill = true if xml_user.css('riptopic').text == '0'

          user.alive      = false
          user.rip_topic  = xml_user.css('riptopic').text
          user.death_date = Time.zone.at(xml_user.css('time').text.to_i)

          user.save
          Rails.logger.debug "imported death for user #{user.name}"
        end
      end
    end
  end
end
