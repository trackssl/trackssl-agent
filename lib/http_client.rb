module HttpClient
  def client
    @client ||= Faraday.new do |faraday|
      faraday.url_prefix = base_url
      faraday.headers['Authorization'] = "Bearer #{auth_token}"
      faraday.headers['Content-Type'] = 'application/json'
      faraday.headers['Accept'] = 'application/json'
      faraday.adapter Faraday.default_adapter
    end
  end

  def base_url
    ENV['TRACKSSL_URL'] || 'https://app.trackssl.com'
  end

  def auth_token
    ENV['TRACKSSL_AUTH_TOKEN']
  end

  def agent_token
    ENV['TRACKSSL_AGENT_TOKEN']
  end

end
