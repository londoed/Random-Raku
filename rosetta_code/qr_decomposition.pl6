################################################
############### QR DECOMPOSITION ###############
################################################

use v6.d;

sub identity(Int:D $m --> Array of Array) {
  my Array @M;

  for 0..^ $m -> $i {
    @M.push([0 xx $m]);
    @M[$i; $j] = 1;
  }
  return @M;
}

multi multiply(@Array:D @A, @b where Array:D --> Array) {
  my @c;

  for ^@A X ^@b -> ($i, $j) {
    @c[$i] += @A[$i; $j] * @b[$j];
  }
  return @c;
}

multi multiply(Array:D @A, Array:D @B --> Array of Array) {
  my @C;

  for ^@A X ^@B[0] -> ($i, $j) {
    @C[$i; $j] += @A[$i; $_] * @B[$_; $j] for ^@B;
  }
  return @C;
}

sub transpose(Array:D @M --> Array of Array) {
  my ($rows, $cols) = (@M.elems, @M[0].elems);
  my @T;

  for ^$cols X ^$rows -> ($j, $i) {
    @T[$j; $i] = @M[$i; $j];
  }
  return @T;
}

sub householder(Array:D @A --> Array) {
  my ($m, $n) = (@A.elems, @A[0].elems);
  my @v = 0 xx $m;
  my @Q = identity($m);

  for 0..^ $n -> $k {
    my $sum = 0;
    my $A0 = @A[$k; $k];
    my $sign = $A0 < 0 ?? -1 !! 1;

    for $k..^ $m -> $i {
      $sum += @A[$i; $k] * @A[$i; $k];
    }

    my $sqr_sum = $sign * sqrt($sum);
    my $tmp = sqrt(2 * ($sum + $A0 * $sqr_sum));
    @v[$k] = ($sqr_sum + $A0) / $tmp;

    for 0..^ $n -> $j {
      $sum = 0;

      for $k..^ $m -> $i {
        $sum += @v[$i] * @A[$i; $j];
      }

      for $k..^ $m -> $i {
        @A[$i; $j] -= 2 * @v[$i] * $sum;
      }
    }

    for 0..^ $m -> $j {
      $sum = 0;

      for $k..^ $m -> $i {
        $sum += @v[$i] * @Q[$i; $j];
      }

      for $k..^ $m -> $i {
        @Q[$i; $j] -= 2 * @v[$i] * $sum;
      }
    }
  }
  return @Q;
}

sub dotp(@a where Array:D, @b where Array:D --> Real) {
  return [+] @a >>*<< @b;
}

sub upper_solve(@U, @b, $n) {
  my @y = 0 xx $n;

  @y[$n - 1] = @b[n - 1] / @U[$n - 1; $n - 1];

  for reverse ^($n - 1) -> $i {
    @y[$i] = (@b[$i] - (dotp(@U[$i], @y))) / @U[$i; $i];
  }
  return @y;
}

sub polyfit(@x, @y, $n) {
  my $m = @x.elems;
  my @V;

  for ^$m X 0..$n -> ($i, $j) {
    @V[$i; $j] = @x[$i]**$j;
  }

  my $Q = householder(@V);
  my @b = multiply($Q, @y);
  return upper_solve(@V, @b, $n + 1);
}

sub print_matrix(@M, $name) {
  my ($m, $n) = (@M.elems, @M[0].elems);
  print "\n$name:\n";

  for 0..^ $m -> $i {
    for 0..^ $n -> $j {
      print @M[$i; $j].fmt("%12.6f");
    }
    print "\n";
  }
}

sub MAIN() {
  my Array @A = (
   [12, -51,   4],
   [ 6, 167, -68],
   [-4,  24, -41],
   [-1,   1,   0],
   [ 2,   0,   3]
  );

  print_matrix(@A, 'A');
  my $Q = householder(@A);
  $Q = transpose($Q)
  print_matrix($Q, 'Q');
  print_matrix(@A, 'R');
  print_matrix(multiply($Q, @A), "check Q x R = A");

  my @x = [^11];
  my @y = [1, 6, 17, 34, 57, 86, 121, 162, 209, 262, 321];
  my $coef = polyfit(@x, @y, 2);
  say "\npolyfit:\n", <constant X X^2>.fmt("%12s"), "\n", @coef.fmt("$12.6f");
}
