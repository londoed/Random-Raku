# Check if the given array contains increasing (or decreasing) numbers #
my @data = (3, 7, 19, 20, 34);
say [<] @data; #=> True (increasing order)
say [>] @data; #=> False (not decreasing order)

# Showing what the reduction operator is actually doing... #
say @data[0] < @data[1] < @data[2] < @data[3] < @data[4]; #=> True

# This works because you can chain comparative operators like this #
my $x = 15;
say "Ok" if 10 < $x < 20; #=> Ok
