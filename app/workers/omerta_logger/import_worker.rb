require 'sidekiq-unique-jobs'

module OmertaLogger
  class ImportWorker
    include Sidekiq::Worker
    sidekiq_options queue: 'import', unique: :until_executed, retry: false,
                    unique_expiration: 1440 * 60, run_lock_expiration: 1440 * 60

    def perform(domain)
      require 'omerta_logger/import/loader'
      loader = OmertaLogger::Import::Loader.new(domain)
      loader.import_from_api
    end
  end
end
