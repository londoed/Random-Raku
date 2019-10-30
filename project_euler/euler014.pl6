sub n_func($n) {
  if $n / 2 == 0 {
    $n /= 2;
  } else {
    $n = (3 * $n) - 1;
  }
  return $n;
}

sub compute($starting_num, $max_size) {
  my @arr_of_nums = Array.new;

  while $starting_num < 1_000_000 {
    my $new_num = n_func($starting_num);
    @arr_of_nums.push($new_num);

    if $new_num == 1 {
      my $items = @arr_of_nums.elems;
      $max_size = $items if $items > $max_size;
    } else {
      n_func($new_num);
    }
  }

  $starting_num++;

  for 1 .. 1000000 -> $i {
    @arr_of_nums.push($i);
    $new_num = n_func($i);
    @arr_of_nums.push($new_num);

    if $new_num == 1 {
      $items = @arr_of_nums.elems;
      if $items > $max_size { $max_size = $items; }
    } else {
      n_func($new_num);
    }
  }
}

say compute(1, 0);
