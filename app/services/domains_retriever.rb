class DomainsRetriever
  def self.call
    new.call
  end

  def call
    Domain.transaction do
      Domain.delete_all
      new_domains.each(&Domain.method(:create!))
    end
  end

  def new_domains
    @new_domains ||= JSON.parse(response.body).dig('data')
  end

  def response
    @response ||= client.get(url)
  end

  def client
    @client ||= Faraday.new do |faraday|
      faraday.headers['Authorization'] = "Bearer #{auth_token}"
      faraday.headers['Content-Type'] = 'application/json'
      faraday.headers['Accept'] = 'application/json'
      faraday.adapter Faraday.default_adapter
    end
  end

  def url
    URI(File.join(base_url, 'api', 'v1', 'agents', agent_token, 'domains'))
  end

  def base_url
    ENV['TRACKSSL_URL']
  end

  def auth_token
    ENV['TRACKSSL_AUTH_TOKEN']
  end

  def agent_token
    ENV['TRACKSSL_AGENT_TOKEN']
  end

end
