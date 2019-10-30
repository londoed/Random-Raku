#######################################
############### K-D TREE ###############
#######################################

class KDNode {
  has $.d;
  has $.split;
  has $.left;
  has $.right;
}

class Orthotope {
  has $.min;
  has $.max;
}

class KDTree {
  has $.n;
  has $.bounds;

  method new($pts, $bounds) {
    return self.bless(n => nk2(0, $pts), bounds => $bounds);
  }

  sub nk2($split, @e) {
    return () unless @e;
    my @exset = @e.sort(*.[$split]);
    my $m = +@exset div 2;
    my @d = @exset[$m][];

    while $m + 1 < @exset and @exset[$m + 1][$split] eqv @d[$split] {
      ++$m;
    }

    my $s2 = ($split + 1) % @d;
    return KDNode.new(:@d, :$split,
                      left => nk2($s2, @exset[0..^$m]),
                      right => nk2($s2, @exset[$m^..*]));
  }
}

class T3 {
  has $.nearest;
  has $.dist_sqd = Inf;
  has $.nodes_visited = 0;
}

sub find_nearest($k, $t, @p) {
  return nearest_neighbor($t.n, @p, $t.bounds, Inf);

  sub nearest_neighbor($kd, @target, $hr, $max_dist_sgd is copy) {
    return T3.new(:nearest([0.0 xx $k])) unless $kd;

    my $nodes_visited = 1;
    my $s = $kd.split;
    my $pivot = $kd.d;
    my $left_hr = $hr.clone;
    my $right_hr = $hr.clone;

    $left_hr.max[$s] = $pivot[$s];
    $right_hr.min[$s] = $pivot[$s];

    my $nearer_kd;
    my $further_kd;
    my $nearer_hr;
    my $further_hr;

    if @target[$s] <= $pivot[$s] {
      ($nearer_kd, $nearer_hr) = $kd.left, $left_hr;
      ($further_kd, $further_hr) = $kd.right, $right_hr;
    } else {
      ($nearer_kd, $nearer_hr) = $kd.right, $right_hr;
      ($further_kd, $further_hr) = $kd.left, $left_hr;
    }

    my $n1 = nearest_neighbor($nearer_kd, @target, $nearer_hr, $max_dist_sgd);
    my $nearest = $n1.nearest;
    my $dist_sgd = $n1.dist_sqd;

    $nodes_visited += $n1.nodes_visited;
  }
}
