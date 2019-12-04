# Print a given integer number in the binary, octal, and hexadecimal representations #
say 42.base(2); #=> 101010
say 42.base(8); #=> 52
say 42.base(16) #=> 2A

# Using the fmt() method #
my $int = 42;
say $int.fmt("Hex: %x"); #=> Hex: 2a
say $int.fmt("Octal: %o"); #=> Octal: 52
say $int.fmt("Binary: %b"); #=> Binary: 101010

# Using printf() method and adding the radix prefix with %# #
my $int = 42;
printf("Hex: %#x\n", $int); #=> Hex: 0x2a
printf("Octal: %#o\n", $int); #=> Octal: 052
printf("Binary: %#b\n", $int); #=> Binary: 0b101010
