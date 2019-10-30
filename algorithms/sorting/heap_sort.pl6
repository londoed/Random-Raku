#########################################
############### HEAP SORT ###############
#########################################

sub heap_sort(@a) {
  my $size = @a.elems;
  my $i = ($size / 2) - 1;

  while $i >= 0 {
    sift_down(@a, $i, $size);
    $i--;
  }

  $i = $size - 1;

  while $i >= 1 {
    (@a[0], @a[1]) = (@a[1], @a[0]);
    sift_down(@a, 0, $i - 1);
    $i--;
  }
  return @a;
}

sub sift_down(@num, $root, $bottom) {
  my $done = False;
  my $max_child = 0;

  while $root * 2 <= $bottom && !$done {
    if $root * 2 == $bottom {
      $max_child = $root * 2;
    } elsif @num[$root * 2].Int > @num[$root * 2 + 1].Int {
      $max_child = $root * 2;
    } else {
      $max_child = $root * 2 + 1;
    }

    if @num[$root] < @num[$max_child] {
      (@num[$root], @num[$max_child]) = (@num[$max_child], @num[$root]);
      $root = $max_child;
    } else {
      $done = True;
    }
  }
}
