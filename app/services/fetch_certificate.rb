require 'active_support/core_ext/module/delegation'
require 'openssl'
require 'resolv'

class FetchCertificate
  attr_reader :domain
  delegate :hostname, :port, to: :domain
  delegate :peer_cert, to: :ssl_socket

  def self.call(domain)
    new(domain).call
  end

  def initialize(domain)
    @domain = domain
  end

  def call
    peer_cert
  end

  def ssl_context
    @ssl_context ||= OpenSSL::SSL::SSLContext.new.tap do |context|
      context.set_params(verify_mode: OpenSSL::SSL::VERIFY_NONE)
    end
  end

  def ssl_socket
    @ssl_socket ||= OpenSSL::SSL::SSLSocket.new(tcp_socket, ssl_context).tap do |socket|
      socket.hostname = hostname
      socket.sync_close = true
      socket.connect
    end
  end

  def tcp_socket
    @tcp_socket ||= Socket.tcp(ip_address, port, resolv_timeout: 2, connect_timeout: 2)
  end

  def ip_address
    @ip_address ||= Resolv.getaddress(hostname)
  end

end
