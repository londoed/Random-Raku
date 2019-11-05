my $total = 0;

for 1 .. 1000 -> $i {
  if $i %% 3 || $i %% 5 {
    $total++;
  }
}

say($total);
