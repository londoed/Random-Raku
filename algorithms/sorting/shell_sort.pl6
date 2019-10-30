##########################################
############### SHELL SORT ###############
##########################################

sub shell_sort(@a) {
  my $i = 0;
  my $j = 0;
  my $size = @a.elems;
  my $increment = $size / 2;
  my $tmp = 0;

  while $increment > 0 {
    $i = $increment;
    while $i < $size {
      $j = $i;
      $tmp = @a[$i];
      while $j >= $increment && @a[$j - $increment] > $tmp {
        @a[$j] = @a[$j - $increment];
        $j -= $increment;
      }
      @a[$j] = $tmp;
      $i++;
    }
    if $increment == 2 {
      $increment = 1;
    } else {
      $increment = ($increment / 2).Int;
    }
  }
  return @a;
}
