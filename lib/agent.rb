class Agent
  def self.run
    call
  end

  def self.call
    new.call
  end

  def call
    retrieve_domains
    fetch_certificates
    self
  end

  def retrieve_domains
    DomainsRetriever.call
  end

  def fetch_certificates
    Domain.find_each do |domain|
      puts "#{Time.now}: Fetching certificate for #{domain.hostname}"
      domain.update(certificate: FetchCertificate.call(domain))
    end
    puts
  end

end
