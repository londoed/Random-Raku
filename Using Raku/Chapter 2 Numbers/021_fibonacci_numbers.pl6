# Print the Nth Fibonacci number #
my ($a, $b) = (1, 1);
($a, $b) = ($b, $a + $b) for 3..10;
say $b;

# Using the sequence operator #
my @fib = 1, 1, * + * ... *;
say @fib[9]; #=> 55
