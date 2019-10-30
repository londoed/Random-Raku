#################################################
############### DECONVOLUTION/2D+ ###############
#################################################

sub deconvolve_n(@g, @f) {
  my @h_size = @g.shape >>-<< @f.shape >>+<< 1;
  my @to_solve = coords(@g.shape).map: { [row(@g, @f, $^coords, $h_size)] };
  my @solved = rref(@to_solve);
  my @h;

  for flat(coords(@h_size) Z @solved[*;*-1]) -> $_, $v {
    $h.AT-POS(|$_) = $v;
  }
  return @h;
}

sub row(@g, @f, @g_coord, $h_size) {
  my @row;
  @g_coord = @g_coord[(^@f.shape)];
  for coords($h_size) -> @hc {
    my @f_coord;
    for ^@hc -> $i {
      my $window = @g_coord[$i] - @hc[$i];
      @f_coord.push($window) and next if 0 <= $window < @f.shape[$i];
      last;
    }
    @row.push(@f_coord == @hc ?? @f.AT-POS(|@f_coord) !! 0);
  }
  @row.push(@g.AT-POS(|@g_coord));
  return @row;
}

sub coords(@dim) {
  return @[reverse($_) for [X] ([^$_] for reverse(@dim))];
}

sub rref(@m) {
  return unless @m;
  my ($lead, $rows, $cols) = (0, +@m, +@m[0]);

  if $rows >= $cols {
    @m = trim_system(@m);
    $rows = +@m;
  }

  for ^$rows -> $r {
    $lead < $cols or return @m;
    my $i = $r;

    until @m[$i; $lead] {
      ++$i == $rows or next;
      $i = $r;
      ++$lead == $cols or return @m;
    }

    @m[$i, $r] = @m[$r, $i] if $r != $i;
    my $lv = @m[$r; $lead];
    @m[$r] >>/=>> $lv;

    for ^$rows -> $n {
      next if $n == $r;
      @m[$n] >>-=>> @m[$r] >>*>> (@m[$n; $lead] // 0);
    }
    ++$lead;
  }
  return @m;

  sub trim_system($m) {
    my ($vars, @t) = +$m[0] - 1;
    for ^$vars -> $lead {
      for ^$m -> $row {
        @t.push(|$m.splice($row, 1)) and last if $m[$row; $lead];
      }
    }
    while +@t < $vars and +$m {
      @t.push($m.splice(0, 1));
    }
    return @t;
  }
}

sub pretty_print(@array, $indent=0) {
  if @array[0] ~~ Array {
    say ' ' x $indent, "[";
    pretty_print($_, $indent + 2) for @array;
    say ' ' x $indent, "]{$indent ?? ',' !! ''}";
  } else {
    say ' ' x $indent, "[{say_it(@array)} ]{$indent ?? ',' !! ''}";
  }
  sub say_it(@array) {
    return join(",", @array>>.fmt("%4s"));
  }
}

my @f[3;2;3] = (
  [
    [ -9,  5, -8 ],
    [  3,  5,  1 ],
  ],
  [
    [ -1, -7,  2 ],
    [ -5, -6,  6 ],
  ],
  [
    [  8,  5,  8 ],
    [ -2, -6, -4 ],
  ]
);

my @g[4;4;6] = (
  [
    [  54,  42,  53, -42,  85, -72 ],
    [  45,-170,  94, -36,  48,  73 ],
    [ -39,  65,-112, -16, -78, -72 ],
    [   6, -11,  -6,  62,  49,   8 ],
  ],
  [
    [ -57,  49, -23,  52,-135,  66 ],
    [ -23, 127, -58,  -5,-118,  64 ],
    [  87, -16, 121,  23, -41, -12 ],
    [ -19,  29,  35,-148, -11,  45 ],
  ],
  [
    [ -55,-147,-146, -31,  55,  60 ],
    [ -88, -45, -28,  46, -26,-144 ],
    [ -12,-107, -34, 150, 249,  66 ],
    [  11, -15, -34,  27, -78, -50 ],
  ],
  [
    [  56,  67, 108,   4,   2, -48 ],
    [  58,  67,  89,  32,  32,  -8 ],
    [ -42, -31,-103, -30, -23,  -8 ],
    [   6,   4, -26, -10,  26,  12 ],
  ]
);

say "# (+@f.shape)D array";
my @h = deconvolve_n(@g, @f);
say "h = ";
pretty_print(@h);
my @h_shaped[2; 3; 4] = @(deconvolve_n(@g, @f));
my @ff = deconvolve_n(@g, @h_shaped);
say "\nff = ";
pretty_print(@ff);
