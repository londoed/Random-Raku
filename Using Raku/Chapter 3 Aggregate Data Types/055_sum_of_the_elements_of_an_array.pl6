# Find the sum of the elements of an array of integers #
my @a = (4, 6, 8, 1, 0, 58, 1, 34, 7, 4, 2);
say [+] @a; #=> 125

# To sum all elements greater than 10 #
say [+] grep: { $_ > 10 }, @a; #=> 92

# Reduction operator spelled out in wordier version #
say reduce &infix:<+>, @a; #=> 125

# Using the built in sum() method #
my @a = (4, 6, 8, 1, 0, 58, 1, 34, 7, 4, 2);
say @a.sum; #=> 125
# OR #
say sum(@a); #=> 125
