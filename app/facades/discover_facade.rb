class DiscoverFacade
  def top_twenty
    service = DiscoverService.new

    data = service.top_rated
    data[:results].first(20)
  end

  def search_result(title)
    service = DiscoverService.new

    data = service.search_title(title)
    data[:results].first(20)
  end
end