sub is_triplet($a, $b, $c) {
  return True if $a**2 + $b**2 == $c**2;
  return False;
}

sub compute($n) {
  for 1 .. $n -> $i {
    for 1 .. $n -> $j {
      for 1 .. $n -> $k {
        if $i + $j + $k == $n && is_triplet($i, $j, $k) {
          return $i * $j * $k;
        }
      }
    }
  }
}

say compute(1000);
