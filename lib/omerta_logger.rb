require 'omerta_logger/engine'

module OmertaLogger
  # rubocop:disable Metrics/MethodLength
  def self.set_defaults
    @config.domains = [ 'com' ]
    @config.bullet_factory = true
    @config.bullet_factory_bullet_history = true
    @config.bullet_factory_owner_history = true
    @config.bullet_factory_price_history = true
    @config.business_object = true
    @config.business_object_bankruptcy_history = true
    @config.business_object_owner_history = true
    @config.business_object_profit_history = true
    @config.business_object_protection_history = true
    @config.casino = true
    @config.casino_bankruptcy_history = true
    @config.casino_max_bet_history = true
    @config.casino_owner_history = true
    @config.casino_profit_history = true
    @config.casino_protection_history = true
    @config.family = true
    @config.family_bank_history = true
    @config.family_name_history = true
    @config.family_position_history = true
    @config.family_rank_history = true
    @config.family_user_count_history = true
    @config.family_worth_history = true
    @config.game_statistic = true
    @config.hitlist = true
    @config.user = true
    @config.user_family_history = true
    @config.user_name_history = true
    @config.user_online_time = true
    @config.user_rank_history = true
    @config.user_revive = true
  end

  def self.setup(&block)
    @config ||= OmertaLogger::Engine::Configuration.new

    set_defaults

    yield @config if block
  end

  def self.config
    Rails.application.config
  end
end
