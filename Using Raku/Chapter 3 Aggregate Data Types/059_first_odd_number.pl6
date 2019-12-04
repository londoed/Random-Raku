# Find the first odd number in a list of integers #
my @nums = (2, 4, 18, 9, 16, 7, 10);
my $first = @nums.first: { * % 2 };
say $first; #=> 9

# Using traditional style call with first #
my $first = @nums.first(* % 2);

# Using filtering with grep() #
my @odd = grep: { $_ % 2 }, @nums;
say @odd[0]; #=> 9

# Using the smartmatch operator with regular expressions #
@nums ~~ /(\d* <[12379]>$)/;
say $/[0]; #=> 9
