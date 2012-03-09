module ReferersHelper
  
  def sort_referers_by_frequency referers
    frequency = referers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    referer_list = frequency.sort_by { |k,v| v }
    referer_list.reverse
  end
end
