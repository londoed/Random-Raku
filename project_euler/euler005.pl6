sub find_multiple($m, $n) {
  my $i = 1;
  for $m .. $n -> $j {
    $i *= $j / gcd($i, $j);
  }
  return $i;
}

sub gcd($a, $b) {
  while $b > 0 {
    $a %= $b;
    return $b if $a == 0;
    $b %= $a;
  }
  return $a;
}

say find_multiple(2, 20);
