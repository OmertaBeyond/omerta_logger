module OmertaLogger
  module Import
    class GameStatistic < Base
      COUNT_MAPPING   = { users_total: 'total', users_alive: 'alive', users_dead: 'dead',
                          lackeys_working: 'lackeys', users_online_now: 'online now',
                          users_online_today: 'online today', users_online_week: 'online week',
                          registrations_today: 'registrations today', registrations_week: 'registrations week' }.freeze
      ECONOMY_MAPPING = { bullets: 'bullets', money_pocket: 'pocketmoney', money_bank: 'bank',
                          money_familybank: 'familybank', honorpoints: 'honorpoints',
                          car_attempts: 'carattempts', crime_attempts: 'crimeattempts', bustouts: 'bustouts',
                          cars: 'cars' }.freeze

      def import
        counts     = @xml.css('counts')
        economy    = @xml.css('economy')

        game_stats = @version.game_statistics.new

        COUNT_MAPPING.each do |k, v|
          game_stats[k] = counts.css(v).text
        end

        ECONOMY_MAPPING.each do |k, v|
          game_stats[k] = economy.css(v).text
        end

        game_stats.date = @loader.generated

        game_stats.save
        Rails.logger.debug 'saved game stats'
      end
    end
  end
end
