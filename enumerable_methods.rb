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

  if block_given?
    return self.my_select { |el| yield(el) }.length == self.to_a.length
  end

  if !param && !block_given?
    class_type = self[0].class
    return self.my_select { |el| el.class == class_type }.length == self.to_a.length
  end

end
# p %w[ant bear cat].my_all?(/t/)
# p [1, 2i, 3.14].my_all?(Numeric)
# p %w[ant bear cat].all? { |word| word.length >= 3 }
# p [nil, true, 99].all?

def my_any?(param=nil)
  if param  # If there is parameter given
    if param.is_a?(Regexp)  # check if Regex class passed as 'parameter'
      self.my_each do |el|
        if (el =~ param)  # if at least one regex is matched
          return true  # return true
        end
      end
    elsif param.is_a?(Class)
      self.my_each do |el|
        if (el.is_a?(param))  # if at least one element class is matched with Class given via param 
          return true # return true
        end
      end
    end
    return false # if my_each ends without finding given class in any el return false
  end

  if block_given?
    self.my_each do |el|
      if yield(el)
        return true
      end
    end
    return false
  end

  if !param && !block_given?
    self.my_each { |el| return true if (el != nil || el != false) }
  end

end
# p %w[ant bear cat].my_any?(/d/)
# p [nil, true, 99].my_any?(Integer)
# p %w[ant bear cat].my_any? { |word| word.length >= 4 }
#p [nil, true, false].any?

def my_none? (param=nil)
  if self.length == 0 
    return true
  end
  if param
    if param.is_a?(Regexp)
      self.my_select { |item| !(item =~ param) }.length == self.to_a.length
    elsif param.is_a?(Class)
        self.my_select { |item| !item.is_a? param }.length == self.to_a.length
    end
  end
  if block_given?
    return self.my_select { |item| !yield(item) }.length == self.to_a.length
  end
  if !param && !block_given?
    return self.my_select { |item| !item }.length == self.to_a.length
  end
end


def my_count(param=nil)
  if param
    return self.my_select { |item| item == param}.length
  end
  if block_given?
    return self.my_select {|item| yield(item)}.length
  end
end
#p [1, 2, 4,2,4,5,6,2, 2].my_count(2)
# p [1, 2, 4,2,4,5,6,2, 2].my_count{ |x| x%2==0 } 


def my_map
  arr = []
  if block_given?
    self.to_a.my_each { |el| arr << yield(el)}
  end
end

# p (1..4).map { |i| i*i }      #=> [1, 4, 9, 16]
# p (1..4).collect { "cat"  }   #=> ["cat", "cat", "cat", "cat"]

def my_inject(param1=nil, param2=nil)
  if param1 && !param2 && !block_given?
    if param1.is_a?(Symbol) || param1.is_a?(String)
      self_arr = self.to_a
      memo = self_arr[0]
      case param1
      when :+, '+'
        self_arr[1..-1].my_each{ |el| memo += el }
      when :*, '*'
        self_arr[1..-1].my_each{ |el| memo *= el }
      when :-, '-'
        self_arr[1..-1].my_each{ |el| memo -= el }
      when :/, '/'
        self_arr[1..-1].my_each{ |el| memo /= el }
      when :**, '**'
        self_arr[1..-1].my_each{ |el| memo **= el }
      end
      memo
    end
  elsif param1 && param2 && !block_given?
    self_arr = self.to_a
    memo = param1
    case param2
    when :+, '+'
      self_arr.my_each{ |el| memo += el }
    when :*, '*'
      self_arr.my_each{ |el| memo *= el }
    when :-, '-'
      self_arr.my_each{ |el| memo -= el }
    when :/, '/'
      self_arr.my_each{ |el| memo /= el }
    when :**, '**'
      self_arr.my_each{ |el| memo **= el }
    end
    memo
  end
  if block_given? && param1
    self_arr = self.to_a
    self_arr.my_each do |el|
      memo = memo.nil? ? yield(param1, el) : yield(memo, el) 
    end
    memo
  elsif block_given? && !param1
    self_arr=self.to_a
    memo = param1
    self_arr.my_each {|el| memo = memo.nil? ? el : yield(memo, el)}
  end
  memo
end

# p (5..10).my_inject(:**)
# p (5..10).my_inject('+')
# p (5..10).my_inject(1, :+)
# p (5..10).my_inject{ |product, n| product + n }

end
def multiply_els(arr)
  return arr.my_inject(:*)
end
# multiply_els([2,4,5])