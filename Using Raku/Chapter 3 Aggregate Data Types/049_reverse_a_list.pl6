# Print the given list in reverse order #
my @a = (10, 20, 30, 40, 50);
say @a.reverse; #=> (50 40 30 20 10)

# Reversing a range #
my $range = 10..15;
say $range; #=> 10..15
say $range.reverse; #=> (15 14 13 12 11 10)
