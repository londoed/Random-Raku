# Calcuate the distance between the two points on a surface #
my ($x1, $y1) = (10, 3);
my ($x2, $y2) = (9, 1);
say sqrt(($x1 - $x2)**2 + ($y1 - $y2)**2);

# Using complex numbers #
my $a = 10+3i;
my $b = 9+1i;
say ($a - $b).abs; #=> (10+3i -0-1i 0+4i 10+0i)
