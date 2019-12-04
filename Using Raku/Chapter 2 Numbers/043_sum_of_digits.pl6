# Calculate the sum of digits of a given number #
my $number = 139487854;
say [+] $number.split(''); #=> 49

# More traditional approach #
my $number = 139487854;
my $sum = 0;

while $number {
  $sum += $number % 10;
  $number = Int($number / 10);
}

say $sum; #=> 49
