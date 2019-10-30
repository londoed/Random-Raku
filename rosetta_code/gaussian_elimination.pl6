####################################################
############### GAUSSIAN ELIMINATION ###############
####################################################

sub gauss_jordan_solve(@a, @b) {
  @b.kv.map: {@a[$^k].append: $^v};
  @a.&rref[*]»[*-1];
}

sub rref(@m) {
  return unless @m;
  my ($lead, $rows, $cols) = (0, +@m, +@m[0]);

  for ^&rows -> $r {
    $lead < $cols or return @m;
    my $i = $r;

    until @m[$i; $lead] {
      ++$i == $rows or next;
      $i = $r;
      ++$lead == $cols and return @m;
    }
    @m[$i, $r] = @m[$r. $i] if $r != $i;
    my $lv = @m[$r; $lead];
    @m[$r] »/=» $lv;

    for ^$rows -> $n {
      next if $n == $r;
      @m[$n] »-=» @m[$r] »*» (@m[$n; $lead] // 0);
    }
    ++$lead;
  }
  return @m;
}

sub rat_int($num) {
  return $num unless $num ~~ Rat;
  return $num.narrow if $num.narrow.WHAT ~~ Int;
  $num.nude.join('/');
}

sub say_it($message, @array, $fmt="%8s") {
  say "\n$message";
  $_».&rat_or_int.fmt($fmt).put for @array;
}

my @a = (
    [ 1.00, 0.00, 0.00,  0.00,  0.00,   0.00 ],
    [ 1.00, 0.63, 0.39,  0.25,  0.16,   0.10 ],
    [ 1.00, 1.26, 1.58,  1.98,  2.49,   3.13 ],
    [ 1.00, 1.88, 3.55,  6.70, 12.62,  23.80 ],
    [ 1.00, 2.51, 6.32, 15.88, 39.90, 100.28 ],
    [ 1.00, 3.14, 9.87, 31.01, 97.41, 306.02 ],
);

my @b = (-0.01, 0.61, 0.91, 0.99, 0.60, 0.02);

say_it("A matrix: ", @a, "%6.2f");
say_it("or, A in exact rationals: ", @a);
say_it("B matrix: ", @b, "%6.2f");
say_it("or, B in exact rationals: ", @b);
say_it("X matrix: ", (my @gj = gauss_jordan_solve(@a, @b)), "%16.12f");
say_it("or, X in exact rationals: ", @gj, "%28s");
