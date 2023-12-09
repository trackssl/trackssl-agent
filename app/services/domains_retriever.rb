class DomainsRetriever
  include HttpClient
  include Logging

  def self.call
    new.call
  end

  def call
    info "Retrieving domains"
    Domain.transaction do
      new_domains.each(&Domain.method(:create!))
    end
    info "Retrived #{new_domains.count} domains"
  end

  def new_domains
    @new_domains ||= JSON.parse(response.body).dig('data') || []
  end

  def response
    @response ||= client.get(url)
  end

  def url
    URI(File.join(base_url, 'api', 'v1', 'agents', agent_token, 'domains'))
  end

end
