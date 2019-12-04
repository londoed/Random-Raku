# Generate a random number between 0 and N #
say 1.rand; #=> betweeon 0 and 1
say 2.5.rand; #=> between 0 and 2.5
say pi.rand; #=> between 0 and pi

# To generate random integer numbers #
say 10.rand.Int; #=> Int between 0 and 9

# Using the srand() function to set a seed #
srand(1);
my $a = 10.rand;

srand(1);
my $b = 10.rand;
say $a == $b; #=> True
