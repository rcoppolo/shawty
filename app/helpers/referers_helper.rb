module ReferersHelper
  
  def sort_by_freq referers
    freq = referers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    referers.sort_by! { |v| freq[v] }
    p freq
    out = []
    10.times do
      out << referers.first.keys.pop
    end
    
  end
end


a = [1,1,1,1,1,4,5,6,6,6,2,2,2,2,2,2,2,2,2,10]
 => [1, 1, 1, 1, 1, 4, 5, 6, 6, 6, 2, 2, 2, 2, 2, 2, 2, 2, 2, 10] 
1.9.3p125 :038 > freq = a.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
 => {1=>5, 4=>1, 5=>1, 6=>3, 2=>9, 10=>1} 
1.9.3p125 :039 > v = a.sort_by { |v| freq[v] }
 => [10, 5, 4, 6, 6, 6, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2] 
1.9.3p125 :040 > v.uniq
 => [10, 5, 4, 6, 1, 2] 
1.9.3p125 :041 > v.uniq.reverse
 => [2, 1, 6, 4, 5, 10]