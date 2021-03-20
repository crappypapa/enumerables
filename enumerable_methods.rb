module Enumerable
  def my_each
    return self.to_a.to_enum unless block_given?  # return enum obj if no block given
    self_arr = self.to_a
    index = 0

    if self.is_a?(Hash)
     keys = self.keys
     values = self.values

     while index < keys.length
      yield(keys[index], values[index])
      index += 1
    end

    end

    while index < self_arr.length
      yield(self_arr[index])
      index += 1
    end
    self
  end

  # p ['a', 'b'].my_each
    # p (1..5).each.my_each{ |item| p item}
    {first: 1, second: 2}.my_each {|key, value| p value}

  def my_each_with_index
    index = 0
    my_each do |item|
      yield(item, index)
      index += 1
    end
    self
  end

  def my_select
    arr = []
    my_each do |item|
      arr << item if yield(item)
    end
    arr
  end

  # rubocop:Style/Case
  def my_all?(param = nil, &block)
    return true if length.zero? # return true if empty array given

    if param
      case param
      when Regexp
        return my_select { |el| el =~ param }.length == to_a.length
      when Class
        return my_select { |el| el.is_a?(param) }.length == to_a.length
      end
    end
    return my_select(&block).length == to_a.length if block_given?

    # rubocop:disable Style/GuardClause
    if !param && !block_given?
      class_type = self[0].class
      my_select { |el| el.instance_of?(class_type) }.length == to_a.length
    end
  end
  # rubocop:enable Style/GuardClause

  # rubocop:Style/Case
  def my_any?(param = nil)
    if param # If there is parameter given
      case param
      when Regexp # check if Regex class passed as 'parameter'
        my_each { |el| return true if el =~ param } # if at least one regex is matched return true
      when Class
        my_each do |el|
          if el.is_a?(param) # if at least one element class is matched with Class given via param
            return true # return true
          end
        end
      end
      return false # if my_each ends without finding given class in any el return false
    end
    if block_given?
      my_each do |el|
        return true if yield(el)
      end
      return false
    end
    my_each { |el| return true if !el.nil? || el != false } if !param && !block_given?
  end

  def my_none?(param = nil)
    return true if length.zero?

    if param
      case param
      when Regexp
        my_select { |item| item !~ param }.length == to_a.length
      when Class
        my_select { |item| !item.is_a? param }.length == to_a.length
      end
    end
    return my_select { |item| !yield(item) }.length == to_a.length if block_given?

    my_select(&:!).length == to_a.length if !param && !block_given?
  end

  def my_count(param = nil, &block)
    return my_select { |item| item == param }.length if param

    my_select(&block).length if block_given?
  end

  def my_map(proc = nil)
    arr = []
    if block_given?
      to_a.my_each { |el| arr << yield(el) }
    elsif proc
      to_a.my_each { |el| arr << proc.call(el) }
    end
    arr
  end

  # rubocop:Style/Case
  def my_inject(param1 = nil, param2 = nil)
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
