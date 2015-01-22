module OmertaLogger
  module Import
    class GameStatistic < Base
      COUNT_MAPPING   = { users_total: "total", users_alive: "alive", users_dead: "dead",
                          lackeys_working: "lackeys", users_online_now: "online now",
                          users_online_today: "online today", users_online_week: "online week",
                          registrations_today: "registrations today", registrations_week: "registrations week" }
      ECONOMY_MAPPING = { bullets: "bullets", money_pocket: "pocketmoney", money_bank: "bank",
                          money_familybank: "familybank", honorpoints: "honorpoints",
                          car_attempts: "carattempts", crime_attempts: "crimeattempts", bustouts: "bustouts",
                          cars: "cars" }

      def import
        counts     = @xml.css("counts")
        economy    = @xml.css("economy")

        game_stats = @version.game_statistics.new

        COUNT_MAPPING.each do |k, v|
          game_stats[k] = counts.css(v).text
        end

        ECONOMY_MAPPING.each do |k, v|
          game_stats[k] = economy.css(v).text
        end

        game_stats.save
      end
    end
  end
end