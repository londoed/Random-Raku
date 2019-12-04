# Decide if the given number is a prime number #
say "Prime" if is-prime(17); #=> Prime

# As a method on an object of the Int type #
my $n = 15;
say $n.is-prime ?? "$n is prime" !! "$n is not prime"; #=> 15 is not prime
