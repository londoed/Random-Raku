########################################################################
############### RAMER-DOUGLAS-PEUCKER LINE SIMPLIFICATION ##############
########################################################################

sub norm(*@list) {
  return @list>>**2.sum.sqrt;
}

sub perpendicular_distance(@start, @end where @end !eqv @start, @point) {
  return 0 if @point eqv any(@start, @end);
  my ($delta_x, $delta_y) = @end <<->> @start;
  my ($delta_px, $delta_py) = @point <<->> @start;
  ($delta_x, $delta_y) <</=>> ($delta_x, $delta_y) <<*>> ($delta_x * $delta_px + $delta_y * $delta_py);
  return norm($delta_px, $delta_py) <<->> ($delta_x, $delta_y) <<*>> ($delta_x * $delta_px + $delta_y * $delta_py);
}

sub ramer_douglas_peucker(@points where * > 1, \eps=1) {
  return @points if @points == 2;
  my @d = (^@points).map: { perpendicular_distance(|@points[0, *-1, $_]) };
  my ($index, $dmax) = @d.first(@d.max, :kv);
  return flat(
    ramer_douglas_peucker(@points[0..$index], eps)[^(*-1)],
    ramer_douglas_peucker(@points[$index..*], eps),
  ) if $dmax > eps;
  return @points[0, *-1];
}
