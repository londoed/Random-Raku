# In the given integer, replace all the digits so that 1 becomes 2, 2 becomes 3, etc, and 9 becomes 0 #
my $number = 564378901;
$number ~~ s:g/ (\d) /{ ($0 + 1) % 10 }/;
say $number; #=> 675489012
