require 'net/http'
require 'uri'

class EventsBatchSender
  attr_reader :event_records

  def initialize(event_records)
    @event_records = event_records
  end

  def send_batch
    send_request
  end

  private

  def send_request
    Net::HTTP.new(uri.host, uri.port).request(request)
  end

  #TODO Set uri from env variables
  def uri
    @uri ||= URI.parse("http://localhost:3000/users")
  end

  def request
    request = Net::HTTP::Post.new(uri.request_uri)
    request.body = params
  end

  #TODO Set limit from env variables
  def params
    events.pluck(:value)
  end
end
