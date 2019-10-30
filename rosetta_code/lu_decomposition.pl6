################################################
############### LU DECOMPOSITION ###############
################################################

for ([1, 3, 5],
     [2, 4, 7],
     [1, 1, 0]
    ),
    ([11,  9, 24,  2],
     [ 1,  5,  2,  6],
     [ 3, 17, 18,  1],
     [ 2,  5,  7,  1]
    )
  -> @test {
  say-it('A Matrix', @test);
  say-it( $_[0], @($_[1]) ) for 'P Matrix', 'Aʼ Matrix', 'L Matrix', 'U Matrix' Z, lu @test;
}

sub lu(@a) {
  die unless @a.&is_square;
  my $n = +@a;
  my @P = pivotize(@a);
  my @A' = mmult(@P, @a);
  my @L = matrix_ident($n);
  my @U = matrix_zero($n);

  for ^$n -> $i {
    for ^$n -> $j {
      if $j >= $i {
        @U[$i][$j] = @A'[$i][$j] - [+] map({ @U[$_][$j] * @L[$i][$_] }), ^$i;
      } else {
        @L[$i][$j] = (@A'[$i][$j] - [+] map({ @U[$_][$j] * @L[$i][$_] }), ^$j) / @U[$j][$j];
      }
    }
  }
  return @P, @A', @L, @U;
}

sub pivotize(@m) {
  my $size = +@m;
  my @id = matrix_ident(@size);

  for ^$size -> $i {
    my $max = @m[$i][$i];
    my @row = $i;
    for $i ..^ $size -> $j {
      if @m[$j][$i] > $max {
        $max = @m[$j][$i];
        @row = $j;
      }
    }
    if @row != $i {
      @id[$row, $i] = @id[$i, $row];
    }
  }
  return @id;
}

sub is_square(@m) {
  return so @m == all(@m[*]);
}

sub matrix_zero($n, $m=$n) {
  return map({ [flat(0 xx $n)] }, ^$m);
}

sub matrix_ident($n) {
  return map({ flat(0 xx $_, 1, 0 xx $n - 1 - $_) }, ^$n);
}

sub mmult(@a, @b) {
  my @p;

  for ^@a X ^@b[0] -> ($r, $c) {
    @p[$r][$c] += @a[$r][$_] * @b[$_][$c] for ^@b;
  }
  return @p;
}

sub rat_int($num) {
  return $num unless $num ~~ Rat;
  return $num.narrow if $num.narrow.WHAT ~~ Int;
  $num.nude.join("/");
}

sub say_it($message, @array) {
  say "\n$message";
  $_>>.&rat_int.fmt("%7s").say for @array;
}
