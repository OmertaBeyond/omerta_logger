module OmertaLogger
  module Import
    class GameStatistic < Base
      def import
        counts = @xml.css("counts")
        economy = @xml.css("economy")
        game_stats = @version.game_statistics.new
        game_stats.date = @loader.generated
        game_stats.users_total = counts.css("total").text
        game_stats.users_alive = counts.css("alive").text
        game_stats.users_dead = counts.css("dead").text
        game_stats.lackeys_working = counts.css("lackeys").text
        game_stats.users_online_now = counts.css("online now").text
        game_stats.users_online_today = counts.css("online today").text
        game_stats.users_online_week = counts.css("online week").text
        game_stats.registrations_today = counts.css("registrations today").text
        game_stats.registrations_week = counts.css("registrations week").text
        game_stats.bullets = economy.css("bullets").text
        game_stats.money_pocket = economy.css("pocketmoney").text
        game_stats.money_bank = economy.css("bank").text
        game_stats.money_familybank = economy.css("familybank").text
        game_stats.honorpoints = economy.css("honorpoints").text
        game_stats.car_attempts = economy.css("carattempts").text
        game_stats.crime_attempts = economy.css("crimeattempts").text
        game_stats.bustouts = economy.css("bustouts").text
        game_stats.cars = economy.css("cars").text
        game_stats.save
      end
    end
  end
end