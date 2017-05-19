require 'net/ftp'
require 'net/ftp/list'
require 'zlib'
require 'stringio'

module OmertaLogger
  module Import
    class ArchiveLoader
      attr_accessor :domain, :version, :imported_updates, :last_generated, :ftp

      def initialize(version)
        @domain = version.domain
        @version = version
        @last_generated = version.last_version_update.generated unless version.last_version_update.nil?
        @imported_updates = 0
      end

      def ftp_file_list(host, path)
        @ftp = Net::FTP.open(host)
        @ftp.passive = true
        @ftp.login
        @ftp.chdir(path)
        files = []
        @ftp.list('*') do |e|
          entry = Net::FTP::List.parse(e)
          next unless entry.file?
          files << entry.basename
        end
        files
      end

      def import
        uri = URI.parse(@domain.archive_url)
        files = ftp_file_list(uri.host, "#{uri.path}/#{@version.version}")
        files.map! { |file| { basename: file, date: DateTime.strptime(file, '%Y-%m-%d--%H-%M-%S') } }
        files.select! { |file| @last_generated.nil? || file[:date] > @last_generated }
        import_files(files.sort_by { |file| file[:date] })
      end

      def import_files(files)
        files.each do |file|
          Rails.logger.info "importing #{file[:basename]} from archive"
          gz = Zlib::GzipReader.new StringIO.new(@ftp.getbinaryfile(file[:basename], nil))
          loader = OmertaLogger::Import::Loader.new(@domain.name)
          loader.import_from_string(gz.read)
          @imported_updates += 1
        end
      end
    end
  end
end
