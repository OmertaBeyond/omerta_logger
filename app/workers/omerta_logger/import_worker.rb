require 'sidekiq-unique-jobs'

module OmertaLogger
  class ImportWorker
    include Sidekiq::Worker
    sidekiq_options queue: 'import', lock: :until_executed,
                    lock_expiration: 8.hours, on_conflict: :log, retry: 0

    def perform(domain)
      require 'omerta_logger/import/loader'
      loader = OmertaLogger::Import::Loader.new(domain)
      loader.import_from_api
    end
  end
end
