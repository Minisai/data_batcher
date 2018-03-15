require 'net/http'
require 'uri'

class EventsBatchSender
  attr_reader :events_batch
  delegate :event_records, to: :events_batch

  def initialize(events_batch)
    @events_batch = events_batch
  end

  def send_batch
    send_request
  end

  private

  def send_request
    Net::HTTP.new(uri.host, uri.port).request(request)
  end

  # TODO: Set uri from env variables
  def uri
    @uri ||= URI.parse('http://localhost:3000/users')
  end

  def request
    request = Net::HTTP::Post.new(uri.request_uri)
    request.body = params
  end

  def params
    event_records.pluck(:value)
  end
end
