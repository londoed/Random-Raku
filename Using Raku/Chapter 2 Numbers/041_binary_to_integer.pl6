# Convert a binary number to a decimal integer #
my $bin = '101101';
my $int = "0b$bin".Int;
say $int;  #=> 45

# Usng explici radix #
my $bin = '101101';
my $int = ":2<$bin>".Int;
say $int; #=> 45
