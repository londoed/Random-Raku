my $total = 0;

for 1 .. 1000 -> $i {
  if $i % 3 == 0 || $i % 5 == 0 {
    $total++;
  }
}

say($total);
