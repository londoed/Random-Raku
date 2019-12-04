# Find the minimum and the maximum numbers in the given list of integers #
my @list = (7, 6, 12, 3, 4, 10, 2, 5, 15, 6, 7, 8, 9, 3);
say @list.min; #=> 2
say @list.max; #=> 15

# min() and max() can used as binary operators #
say 7 min 8; #=> 7
say 7 max 8; #=> 8

# Chaining binary operators #
say 7 min 5 min 8; #=> 5
say 7 max 5 max 8; #=> 8

# Expressing this with reduction meta-operator #
say [min] 7, 9, 5; #=> 5
say [max] 7, 9, 5; #=> 9

# Lists are also accepted #
say [min] @list;  #=> 2
