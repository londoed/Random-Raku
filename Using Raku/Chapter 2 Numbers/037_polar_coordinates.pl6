# Convert the Cartesian coordinates to polar and backward #
sub polar_to_cartesian($r, $phi) {
  return $r * cos($phi), $r * sin($phi);
}

sub cartesian_to_polar($x, $y) {
  return sqrt($x**2 + $y**2), atan($y / $x);
}

say cartesian_to_polar(1, 2); #=> (2.236068 1.107149)
say polar_to_cartesian(2.236068, 1.107149); #=> (1 2)

# Using variants for negative x and y coordinates #
sub cartesian_to_polar($x, $y) {
  return sqrt($x**2 + $y**2), cartesion_to_phi($x, $y);
}

multi sub cartesion_to_phi($x, $y where ($x > 0)) {
  return atan($y / $x);
}

multi sub cartesion_to_phi($x, $y where {$x < 0 && $y >= 0}) {
  return atan($y / $x) + pi;
}

multi sub cartesion_to_phi($x, $y where ($x < 0 && $y < 0)) {
  return atan($y / $x) - pi;
}

multi sub cartesion_to_phi($x, $y where {$x == 0 && $y > 0}) {
  return pi / 2;
}

mutli sub cartesion_to_phi($x, $y where ($x == 0 && $y < 0)) {
  return -pi / 2;
}

multi sub cartesion_to_phi($x, $y where {$x == 0 && $y == 0}) {
  return Nil;
}
