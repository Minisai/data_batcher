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
    RestClient.post(url, params)
  end

  def url
    ENV['CONSUMER_URL']
  end

  def params
    event_records.pluck(:value)
  end
end
