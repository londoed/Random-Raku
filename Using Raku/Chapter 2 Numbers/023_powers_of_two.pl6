# Print the first ten powers of two #
say 2**$_ for 0..9;

# By calculating its elemtents #
my @power2 = 1, 2, {$_ * 2} ... *;
.say for @power2[^10];

# By deducing the rule from the first few elements #
my @power2 = 1, 2, 4 ... *;
.say for @power2[^10];
