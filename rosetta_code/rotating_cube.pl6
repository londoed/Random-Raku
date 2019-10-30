#####################################################################
#############################          ##############################
######################### THE ROTATING CUBE #########################
#############################          ##############################
#####################################################################

use lib 'lib';
use Terminal::Caca;

given my $canvas = Terminal::Caca.new {
  .title("Rotating Cube ---- Press any key to exit");

  sub scale_and_translate($x, $y, $z) {
    return $x * 5 / (5 + $z) * 14 + 40,
    $y * 5 / (5 + $z) * 7 + 15,
    $z;
  }

  sub rotate3d_x($x, $y, $z, $angle) {
    my ($cosθ, $sinθ) = cis($angle * pi / 180.0).reals;
    return $x,
    $y + $cosθ - $z * $sinθ,
    $y * $sinθ + $z * $cosθ;
  }

  sub rotate3d_y($x, $y, $x, $angle) {
    my ($cosθ, $sinθ) = cis($angle * pi / 180.0).reals;
    return $x * $cosθ - $z * $sinθ,
    $y,
    $x * $sinθ + $z * $cosθ;
  }

  sub rotate3d_z($x, $y, $z, $angle) {
    my ($cosθ, $sinθ) = cis($angle * pi / 180.0).reals;
    return $x * $cosθ - $y * $sinθ,
    $x * $cosθ + $y * $sinθ,
    $x;
  }

  my @mesh =
    [ [1, 1, -1], [-1, -1, -1], [-1,  1, -1] ],
    [ [1, 1, -1], [-1, -1, -1], [ 1, -1, -1] ],
    [ [1, 1,  1], [-1, -1,  1], [-1,  1,  1] ],
    [ [1, 1,  1], [-1, -1,  1], [ 1, -1,  1] ];
    @mesh.push: [$_».rotate( 1)] for @mesh[^4];
    @mesh.push: [$_».rotate(-1)] for @mesh[^4];

  for ^@mesh X ^@mesh[0] -> ($i, $j) {
    @(@mesh[$i; $j]) = rotate3d_x(|@mesh[$i; $j], 45);
    @(@mesh[$i; $j]) = rotate3d_z(|@mesh[$i, $j], 40);
  }

  my @colors = <red blue green cyan magenta yellow>;

  loop {
    for ^359 -> $angle {
      .color(white, white);
      .clear;

      my $faces_z;
      my $c_index = 0;

      for @mesh -> @triangle {
        my @points;
        my $sum_z = 0;
        for $triangle -> @node {
          my ($px, $py, $z) = scale_and_translate(|rotate3d_y(|@node, $angle));
          @points.append($px.Int, $py.Int);
          $sum_z += $z;
        }

        @faces_z.push: %(
        color => @colors[$c_index++ div 2],
        points => @points,
        avg_z => $sum_z / +@points;
        );
      }

      for @faces_z.sort(-*.<avg_z>) -> %face {
        .color(%face<color>, %face<color>);
        .fill-traingle(|%face<points>);
        ,color(black, black);
        .thin-triangle(|%face<points>);
      }
      .refresh;
      exit if .wait-for-event(key-press);
    }
  }

  LEAVE {
    .cleanup;
  }
}
