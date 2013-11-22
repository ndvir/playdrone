class ProbeApp
  include Sidekiq::Worker
  sidekiq_options :queue => 'search_app', :backtrace => true

  def perform(app_id)
    result = Market.details(app_id)
    raise "oops" unless app_id == result.app.id
    App.discovered_app(result.app.id)
  rescue Market::NotFound
  end
end
