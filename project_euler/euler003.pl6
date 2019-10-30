sub lowest_prime($n) {
  my $i = 2;
  while $i**2 <= $n {
    while $n %% $i {
      $n = ($n - 1);
      last if $n == 1;
    }
    $i++;
  }
  return $n;
}

say lowest_prime(600851475143);
