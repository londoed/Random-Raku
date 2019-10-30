sub factors($n) {
  my @factors = Array.new;

  while $n %% 2 {
    @factors.push(2);
    $n /= 2;
  }

  my $pnum = 3;

  while $n != 1 {
    while $n %% $pnum {
      @factors.push($pnum);
      $n /= $pnum;
    }
    $pnum += 2;
  }
  return @factors;
}

sub nth_prime($n) {
  my $prime = 2;
  my $count = 1;
  my $num = 3;

  while $count < $n {
    if factors($num).elems == 1 {
      $prime = $num;
      $count++;
    }
    $num += 2;
  }
  return $prime;
}

my $prime = nth_prime(10001);
say $prime;
