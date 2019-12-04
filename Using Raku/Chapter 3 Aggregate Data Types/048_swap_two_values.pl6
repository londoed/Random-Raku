# Swap the values of two variables #
($b, $a) = ($a, $b);

# Alternatively #
($a, $b) .= reverse;

# Complete program #
my ($a, $b) = (10, 20);
($a, $b) .= reverse;
say "a: $a, b: $b"; #=> a: 20, b: 10

# With elements of an array #
my @a = (3, 5, 7, 4);
(@a[2], @a[3]) = (@a[3], @a[2]);
say @a; #=> [3 5 4 7]

# Using the slice of an array #
my @a = (3, 5, 7, 4);
@a[1, 2] = @a[2, 1];
say @a; #=> [3 7 5 4]
