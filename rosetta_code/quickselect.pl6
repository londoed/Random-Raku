###########################################
############### QUICKSELECT ###############
###########################################

use v6.d;

my @v = <9 8 7 6 5 0 1 2 3 4>;
say map({ quickselect(@v, $_) }, 1..10);

sub partition(@vector, $left, $right, $pivot_idx) {
  my $pivot_value = @vector[$pivot_idx];
  @vector[$pivot_idx, $right] = @vector[$right, $pivot_idx];
  my $store_idx = $left;

  for $left..^$right -> $i {
    if @vector[$i] < $pivot_value {
      @vector[$store_idx, $i] = @vector[$i, $store_idx];
      $store_idx++;
    }
  }
  @vector[$right, $store_idx] = @vector[$store_idx, $right];
  return $store_idx;
}

sub quickselect(@vector, \k where 1..@vector, \l where 0..@vector=0, \r where 1..@vector=@vector.end) {
  my ($k, $left, $right) = k, l, r;

  loop {
    my $pivot_idx = ($left..$right).pick;
    my $pivot_new_idx = partition(@vector, $left, $right, $pivot_idx);
    my $pivot_dist = $pivot_new_idx - $left + 1;

    given $pivot_dist <=> $k {
      when Same {
        return @vector[$pivot_new_idx];
      } when More {
        $right = $pivot_new_idx - 1;
      } when Less {
        $k -= $pivot_dist;
        $left = $pivot_new_idx + 1;
      }
    }
  }
}
