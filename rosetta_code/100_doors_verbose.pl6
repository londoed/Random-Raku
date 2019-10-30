#################################################
############### 100 DOORS PROBLEM ###############
#################################################

sub output(@arr, $max) {
  my $output = 1;

  for 1..^$max -> $index {
    if @arr[$index] {
      printf("%4d", $index);
      say '' if $output++ %% 10;
    }
  }
  say '';
}

sub MAIN(Int :$doors=100) {
  my $door_count = $doors + 1;
  my @door[$door_count] = 0 xx $door_count;

  INDEX:
  for 1...^$door_count -> $index {
    for ($index, * + $index ... *)[^$doors] -> $multiple {
      next INDEX if $multiple > $doors;
      @door[$multiple] = @door[$multiple] ?? 0 !! 1;
    }
  }
  return output(@door, $doors + 1);
}
