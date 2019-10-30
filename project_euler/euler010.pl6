sub is_prime($n) {
  if $n <= 3 {
    return $n > 1;
  } elsif $n %% 2 or $n %% 3 {
    return False;
  } else {
    for 5 .. sqrt($n.ceiling) ... 6 -> $i {
      if $n %% $i or $n %% ($i + 2) {
        return False;
      }
    }
    return True;
  }
}

sub compute($rnge) {
  my @arr_of_primes = Array.new;

  for 1 .. $rnge -> $j {
    @arr_of_primes.push($j) if is_prime($j);
  }
  return @arr_of_primes.sum;
}

say compute(2000000);
