# Compare a fraction from the two given integers--numerator and denominator--and reduce it to lowest terms #
my $a = 16;
my $b = 280;

my $gcd = $a gcd $b;
say $a/$gcd; #=> 2
say $b/$gcd; #=> 35;

# Using the rational (Rat) data type #
my Rat $r = $a/$b;
say $r.numerator; #=> 2
say $r.denominator; #=> 35

dd $r; #=> Rat $r = <2/35>
