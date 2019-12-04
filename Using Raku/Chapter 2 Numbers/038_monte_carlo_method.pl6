# Calculate the area of a circle and the volume of a sphere of radius 1 using the Monte Carlo method #
my $inside = 0;
my $n = 100_000;

for 1..$n {
  my @point = map { 2.rand - 1 }, 1..2;
  $inside++ if sqrt([+] map * **2, @point) < 1;
}

say 4 * $inside / $n; #=> approximately prints 3.14392

# For sphere #
my $inside = 0;
my $n = 100_000;

for 1..$n {
  my @point = map { 2.rand - 1 }, 1..3;
  $inside++ if sqrt([+] map * **2, @point) < 1;
}

say 8 * $inside / $n; #=> approximately prints 4.189s
