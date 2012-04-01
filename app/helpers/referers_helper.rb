module ReferersHelper
  
  def sort_referers_by_frequency referers
    referred_list = referers.map {|i| i.url_id}
    frequency = referred_list.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    referer_list = frequency.sort_by { |_,v| v; p v }
    p referer_list
    referer_list.reverse
  end
end
