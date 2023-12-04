class CertificateSendWorker
  include SuckerPunch::Job
  include HttpClient
  include Logging

  def perform(domain)
    info "#{domain.hostname} (#{domain.domain_id}) Retrieving certificate"
    domain.update(certificate: FetchCertificate.call(domain))

    info "#{domain.hostname} (#{domain.domain_id}) Sending certificate"
    response = client.post("/api/v1/agents/#{ENV['TRACKSSL_AGENT_TOKEN']}/certificate", {domain: domain}.to_json)

    if response.status == 200
      info "#{domain.hostname} (#{domain.domain_id}) certificate sent successfully."
    else
      info "#{domain.hostname} (#{domain.domain_id}) send failed. #{response.status}"
    end

    domain.destroy
  end
end
