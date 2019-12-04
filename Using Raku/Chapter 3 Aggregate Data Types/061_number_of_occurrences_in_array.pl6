# Count how many times a particular element appears in the array #
my @data = <
  apple pear grape lemon
  peach apple banana grape
  pineapple avocade
>;

my $n = @data.grep('grape').elems;
say $n; #=> 2

# Determining the number of occurances for more than one element #
my %count;
%count{$_}++ for @data;

say %count<pineapple>; #=> 1
say %count<grape>; #=> 2
