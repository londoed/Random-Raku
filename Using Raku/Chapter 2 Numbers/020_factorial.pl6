# Print the factorial of a given number #
my $n = 5;
my $f = [*] 1..$n;
say $f;

# Using multifunctions to calculate the factorial of the smallest number 0 and 1 and one for the others #
multi sub factorial(Int $x where {$x < 2}) {
  return 1;
}

multi sub factorial(Int $x) {
  return $x * factorial($x - 1);
}

say factorial(5); #=> 120

# Difining your own postfix operator #
sub postfix:<!>($n) {
  return [*] 1..$n;
}

say 5!; #=> 120
my $x = 7;
say $x!; #=> 5040

# Recursive definition with postfix operator #
sub postfix:<!>($n) {
  $n <= 1 ?? 1 !! $n * ($n - 1);
}

say 5!; #=> 120
