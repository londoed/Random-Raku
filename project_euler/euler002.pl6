my $total = 0;
my $prev = 0;
my Int $i = 1;

while $i <= 4_000_000 {
  $total += $i if $i %% 2;
  ($i, $prev) = $prev, $i;
}

say $total;
