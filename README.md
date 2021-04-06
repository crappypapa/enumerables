# Enumerable Methods

> The main goal of this project is to learn how to use Ruby to create Enumerable methods that are identical to the pre-defined methods.
The following were the methods created

- #my_each
- #my_each_with_index
- #my_select
- #my_all?
- #my_any?
- #my_none?
- #my_count
- #my_map
- #my_inject

## Built With

- Ruby

## Getting Started

No prerequisites

To get a local copy up and running:

1) Clone the repo or download the Zip folder
2) Install ruby and run "ruby enumerable_methods.rb" in your terminal


To get a local copy up and running follow these simple example steps.


## Run tests

### my_each

```[1,3,5,7].my_each{|number| p number}  #=> 1357```

### my_each_with_index

```["a","b","c","d"].my_each_with_index{|item,index| p "#{item} ,#{index}"} #=> ([a,0] [b,1] [c,2] [d,3]```

```{first: 'sasd', second: 'ads'}.my_each_with_index {|hash, index| p "hash: #{hash} index: #{index}"}  #=> "hash: [:first, \"sasd\"] index: 0" "hash: [:second, \"ads\"] index: 1" ```

```(1..3).my_each_with_index {|el, index| p index } #=> 1 , 2, 3```

### my_select

```p [1,2,3,4,5].my_select { |num|  num % 2 == 0 } #=> [2,4]```

```p [:foo, :bar].my_select { |x| x == :foo } #=> [:foo]```

```p (1..5).my_select { |num|  num % 2 == 0 }```

### my_all?

```p %w[ant bear cat].my_all?(/t/) #=> false```

```p [1, 2i, 3.14].my_all?(Numeric) #=> true```

```p %w[ant bear cat].all? { |word| word.length >= 3 } #=> true```

```p [nil, true, 99].all? #=> false```

```p [1,1,1].my_all?() #=> true```

### my_any?

```p %w[ant bear cat].my_any?(/d/) #=> false```

```p [nil, true, 99].my_any?(Integer) #=> true```

```p %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true```

```p [nil, true, false].any? #=> true```

```p (1..3).my_any?{ |i| i > 2 }  #=>true```

```p ['man', 'man', 'man'].my_any?('d')  #=>  false```

### my_count?

```p [1, 2, 4,2,4,5,6,2, 2].my_count(2) #=> 4```

```p [1, 2, 4,2,4,5,6,2, 2].my_count{ |x| x%2==0 } #=> 7```

### my_map

```p (1..4).map { |i| i*i }  #=> [1, 4, 9, 16]```

```p (1..4).collect { "cat"  }   #=> ["cat", "cat", "cat","cat"]```

```test_proc = proc { |x| x**2 } ```   
```p [2, 3, 4].my_map(test_proc){ |i| i*1 } #=> [4, 9, 16]```

### my_inject

```p (5..10).my_inject(:*) #=> 151200```

```p (5..10).my_inject('+') #=> 45```

```p (5..10).my_inject(1, :+) #=> 46```

```p (5..10).my_inject{ |add, n| add + n } #=> 45```

## Run Rspec tests

1) Clone the repo by running git clone https://github.com/crappypapa/enumerables.git Or download the zip folder



2) Make sure you have rspec installed, or you can install by running ```gem install rspec```

3) ```cd``` into the '../enumerables' folder

4) run ```rspec``` in the terminal
## Authors

👤 **Olaoluwa Soladoye**

- GitHub: [@crappypapa](https://github.com/crappypapa)
- Twitter: [@_laoluwa](https://twitter.com/_laoluwa)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!


## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Microverse
- Odin Project