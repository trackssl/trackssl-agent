class Agent
  include Logging
  attr_reader :interval, :scheduler
  delegate :warn, :info, to: :logger

  def self.run(interval: nil)
    call(interval: interval)
  end

  def self.call(interval: nil)
    new(interval: interval).call
  end

  def initialize(interval: nil)
    @interval = interval || '4h'
    @scheduler = Rufus::Scheduler.new
  end

  def call
    info("Initializing TrackSSL agent with interval #{interval}")
    execute_run
    scheduler.every(interval, &method(:execute_run))
    scheduler.join
  end

  def execute_run
    info "Running TrackSSL agent"
    Domain.destroy_all
    retrieve_domains
    fetch_certificates
  rescue Faraday::Error  => e
    warn "Failed to run TrackSSL agent: #{e.class} #{e.message}"
    warn "retrying in 1 minute"
    scheduler.in('1m', &method(:execute_run))
  end

  def retrieve_domains
    DomainsRetriever.call
  end

  def fetch_certificates
    Domain.find_each(&CertificateSendWorker.method(:perform_async))
  end

end
