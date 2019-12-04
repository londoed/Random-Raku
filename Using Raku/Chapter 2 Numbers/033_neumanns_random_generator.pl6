# Implement the von Neumann's random number generator (also known as Middle-square method) #
my $n = 1234;
$n **= 2;
$n = sprintf('%08i', $seed);
say $n;

# Refinement for missing zero digits #
my $n = 1234;
$n **= 2;
$n ~~ /(. ** 0..4)..$/;
say ~$0;

# Without treating the number as a string #
my $n = 1234;
$n **= 2;
$n = ($n / 100).Int % 10_000;
say ~$0;

# Uisng a traditional for-loop #
my $n = 1234;

for 1..30 {
  $n **= 2;
  $n ~~ /(. ** 0..4)..$/;
  $n = ~$0;
  say $n;
}
