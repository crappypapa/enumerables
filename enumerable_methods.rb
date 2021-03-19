module Enumerable
def my_each
  index = 0
  while index < self.length 
    yield(self[index])
    index += 1
  end
  self
end
# [1,3,5,7].my_each{|number| p number}

def my_each_with_index
  index=0
  self.my_each do |item|
    yield(item, index)
    index +=1
  end
  self
end
# ["a","b","c","d"].my_each_with_index{|item,index| p "#{item} ,#{index}"}

  def my_select
    arr=[]
    self.my_each do |item|
      if yield(item)
        arr << item
      end
    end
    arr
  end
# p [1,2,3,4,5].my_select { |num|  num % 2 == 0 }
# p [:foo, :bar].my_select { |x| x == :foo } 

def my_all?(param=nil)
  return true if self.length == 0    #return true if empty array given

  if param
    if param.is_a?(Regexp)
      return self.my_select { |el| el =~ param }.length == self.to_a.length
    elsif param.is_a?(Class)
      return self.my_select { |el| el.is_a?(param) }.length == self.to_a.length
    end
  end
end
# p %w[ant bear cat].my_all?(/t/)
p [1, 2i, 3.14].my_all?(Numeric)


end