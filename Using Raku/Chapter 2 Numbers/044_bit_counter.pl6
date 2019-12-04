# Count the number of bits set to 1 in a binary representation of a positive integer number #

# First using the textual approach #
my $value = prompt("Enter value: ");
$value = $value.Int.base(2);
say "Binary representation: $value";
$value ~~ s:g/0//;
say "Number of is: {$value.chars}";

# Working directly with bits #
my $value = prompt("Enter value: ");
my $bits = 0;

repeat {
  $bits++ if $value +& 1;
  $value = $value +> 1;
} while $value > 0;

say "Number of is: $bits";
