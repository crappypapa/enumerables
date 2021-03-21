module Enumerable
  def my_each
    return to_a.to_enum(:my_each) unless block_given?

    self_arr = to_a
    index = 0

    if is_a?(Hash)

      while index < keys.length
        yield(self_arr[index])
        index += 1
      end

    end

    while index < self_arr.length
      yield(self_arr[index])
      index += 1
    end
    self
  end

  def my_each_with_index
    self_arr = to_a
    return to_enum(:my_each_with_index) unless block_given?

    index = 0
    self_arr.my_each do |item|
      yield(item, index)
      index += 1
    end
    self
  end

  def my_select
    arr = []
    return to_enum(:my_select) unless block_given?

    my_each do |item|
      arr << item if yield(item)
    end
    arr
  end

  def my_all?(param = nil, &block)\
    self_arr = to_a
    return true if self_arr.length.zero?

    if param
      case param
      when Regexp
        return my_select { |el| el =~ param }.length == self_arr.length
      when Class
        return my_select { |el| el.is_a?(param) }.length == self_arr.length
      else
        self_arr.my_each { |el| return false if el != param }
        return true
      end
    end
    return my_select(&block).length == self_arr.length if block_given?

    if !param && !block_given?
      my_each { |el| return false if [nil, false].include?(el) }
      true
    end
  end

  def my_any?(param = nil)
    self_arr = to_a 

    if param 
      case param
      when Regexp
        my_each { |el| return true if el =~ param } # if at least one regex is matched return true
      when Class
        my_each do |el|
          if el.is_a?(param) # if at least one element class is matched with Class given via param
            return true # return true
          end
        end
      else
        self_arr.my_each { |el| return true if el == param }
        return false
      end
      return false # if my_each ends without finding given class in any el return false
    end
    if block_given?
      my_each do |el|
        return true if yield(el)
      end
      return false
    end
    # rubocop:disable Style/GuardClause
    if !param && !block_given? # if no param nor block given check if at least on element is not nil nor false
      self_arr.my_each { |el| return true if el } # if non of elements is true than its false
      false
    end
    # rubocop:enable Style/GuardClause
  end

  def my_none?(param = nil)
    self_arr = to_a
    return true if self_arr.length.zero?

    if param
      case param
      when Regexp
        self_arr.my_each { |item| return false if item =~ param }
        return true
      when Class
        return my_select { |item| !item.is_a? param }.length == to_a.length
      else
        self_arr.my_each { |el| return false if el == param }
        return true
      end
    end
    return my_select { |item| !yield(item) }.length == to_a.length if block_given?

    my_select(&:!).length == to_a.length if !param && !block_given?
  end

  def my_count(param = nil, &block)
    return my_select { |item| item == param }.length if param

    return my_select(&block).length if block_given?

    my_select { |item| item }.length
  end

  def my_map(proc = nil)
    return to_enum unless block_given? # return enum obj if no block given

    arr = []
    if block_given? && !proc
      to_a.my_each { |el| arr << yield(el) }
    elsif proc
      to_a.my_each { |el| arr << proc.call(el) }
    end
    arr
  end

  def my_inject(param1 = nil, param2 = nil)
    raise 'LocalJumpError' unless block_given? || param1 || param2

    if param1 && !param2 && !block_given?
      if param1.is_a?(Symbol) || param1.is_a?(String)
        self_arr = to_a
        memo = self_arr[0]
        case param1
        when :+, '+'
          self_arr[1..-1].my_each { |el| memo += el }
        when :*, '*'
          self_arr[1..-1].my_each { |el| memo *= el }
        when :-, '-'
          self_arr[1..-1].my_each { |el| memo -= el }
        when :/, '/'
          self_arr[1..-1].my_each { |el| memo /= el }
        when :**, '**'
          self_arr[1..-1].my_each { |el| memo **= el }
        end
        memo
      end
    elsif param1 && param2 && !block_given?
      self_arr = to_a
      memo = param1
      case param2
      when :+, '+'
        self_arr.my_each { |el| memo += el }
      when :*, '*'
        self_arr.my_each { |el| memo *= el }
      when :-, '-'
        self_arr.my_each { |el| memo -= el }
      when :/, '/'
        self_arr.my_each { |el| memo /= el }
      when :**, '**'
        self_arr.my_each { |el| memo **= el }
      end
      memo
    end
    if block_given? && param1
      self_arr = to_a
      self_arr.my_each do |el|
        memo = memo.nil? ? yield(param1, el) : yield(memo, el)
      end
      memo
    elsif !block_given? && param1.is_a?(Proc)
      p 'yeah'
    elsif block_given? && !param1
      self_arr = to_a
      memo = param1
      self_arr.my_each { |el| memo = memo.nil? ? el : yield(memo, el) }
    end
    memo
  end

end

def multiply_els(arr)
  arr.my_inject(:*)
end

arr = [1, 9, 2]
p multiply_els(arr)
