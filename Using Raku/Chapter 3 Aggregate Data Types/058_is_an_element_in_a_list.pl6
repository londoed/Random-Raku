# Tell if the given value is in the list #
my @array = (10, 14, 0, 15, 17, 20, 30, 35);
my $x = 17;
say "In the list" if $x ~~ any(@array); #=> In the list

# Using filtering with the grep() method #
say "In the list" if grep: { $x }, @array; #=> In the list

# Using the first() method if the value is not zero, NOTE: returns the first element that matches the pattern #
say "In the list" if first($x, @array); #=> In the list

# To extend to zero values #
say "In the list" if $x == first($x, @array); #=> In the list

# Using a Hash as a lookup table #
my %hash = map: { $_ => 1 }, @array;
say "In the list" if %hash{$x}; #=> In the list
