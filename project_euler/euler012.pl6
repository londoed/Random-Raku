sub div_count($n) {
  my $count = 0;
  my $latest_div = 1;
  my $small_div = $n;

  while $latest_div < $small_div {
    if $n %% $latest_div {
      $small_div = $n / $latest_div;
      if $latest_div == $small_div {
        $count++;
      } else {
        $count += 2;
      }
    }
    $latest_div++;
  }
  return $count;
}

my $tri_num = 0;
my $i = 1;
my $stop = True;

while $stop {
  $tri_num++;
  if div_count($tri_num) <= 500 {
    $i++;
  } else {
    $stop = False;
  }
}

say $tri_num;
