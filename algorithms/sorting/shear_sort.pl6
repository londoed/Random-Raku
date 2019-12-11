##########################################
############### SHEAR SORT ###############
##########################################

class ShearSort {
  sub sort(@a) {
    my $div = 1;
    my $i = 1;

    while $i**2 <= @a.elems {
      if @a.elems %% $i {
        $div = 1;
      }
      $i++;
    }

    has $.rows = $div;
    has $.cols = @a.elems / $div;
    has $.log = log($.rows).Int;

    for 0..$.log -> $_ {
      for 0..($.cols / 2) -> $_ {
        for 0..$.rows -> $i {
          part1_sort(@a, $i * $.cols, ($i + 1) * $.cols, 1, $i %% 2);
        }

        for 0..$.rows -> $i {
          part2_sort(@a, $i * $.cols, ($i + 1) * $.cols, 1, $i %% 2);
        }
      }

      for 0..($.rows / 2) -> $_ {
        for 0..$.cols -> $i {
          part1_sort(@a, $i, $.rows * $.cols + 1, $.cols, True);
        }

        for 0..$.cols -> $i {
          part2_sort(@a, $i, $.rows * $.cols + 1, $.cols, True);
        }
      }
    }

    for 0..($.cols / 2) -> $_ {
      for 0..$.rows -> $i {
        part1_sort(@a, $i * $.cols, ($i + 1) * $.cols, 1, True);
      }

      for 0..$.rows -> $i {
        part2_sort(@a, $i * $.cols, ($i + 1) * $.cols, 1, True);
      }
    }
    return @a;
  }

  sub part1_sort(@ap_array, $a_low, $a_hi, $a_nx, $a_up) {
    part_sort(@ap_array, $a_low, $a_hi, $a_nx, $a_up);
  }

  sub part2_sort(@ap_array, $a_low, $a_hi, $a_nx, $a_up) {
    part_sort(@ap_array, $a_low + $a_nx, $a_hi, $a_nx, $a_up);
  }

  sub part_sort(@ap_array, $j, $a_hi, $a_nx, $a_up) {
    while $j + $a_nx < $a_hi {
      if (($a_up && @ap_array[$j] > @ap_array[$j + $a_nx]) || (!$a_up && @ap_array[$j] < @ap_array[$j + $a_nx])) {
        (@ap_array[$j], @ap_array[$j + $a_nx]) = (@ap_array[$j + $a_nx], @ap_array[$]);
      }
      $j += $a_nx * 2;
    }
  }
}
