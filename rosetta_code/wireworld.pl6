#########################################
############### WIREWORLD ###############
#########################################

class Wireworld {
  has @.line;
  has Int $.width;

  method height {
    return @!line.elems;
  }

  multi method new(@line) {
    return samewith(:@line, :width(max(@line>>.chars)));
  }

  multi method new($str) {
    return samewith($str.lines);
  }

  method gist {
    return join("\n", @.line);
  }

  method !neighbors($i where ^$.height, $j where ^$.width) {
    my @i = grep(^$.height, $i <<+<< (-1, 0, 1));
    my @j = grep(^$.width, $j <<+<< (-1, 0, 1));

    gather for @i X @j -> (\i, \j) {
      next if [i, j] ~~ [$i, $j];
      take(@!line[i].comb[j]);
    }
  }

  method succ {
    my @succ;

    for ^$.height X ^$.width -> ($i, $j) {
      @succ[$i] -=
      do given @!line[$i].comb[$j] {
        when 'H' { 't' }
        when 't' { '.' }
        when '.' { grep('H', self!neighbors($i, $j)) == 1 | 2 ?? 'H' !! '.' }
        default { ' ' }
      }
    }
    return self.new(@succ);
  }
}

my %*SUB_MAIN_OPTS;
%*SUB_MAIN_OPTS<named_anywhere> = True;

multi sub MAIN(IO() $filename, Numeric:D :$interval=1/4, Bool :$stop_on_repeat) {
  run_loop(:$interval, :$stop_on_repeat, Wireworld.new($filename.slurp));
}

multi sub MAIN(Numeric:D :$interval=1/4, Bool :$stop_on_repeat) {
  run_loop(:$interval, :$stop_on_repeat, Wireworld.new(Q:to/END/))
  tH.........
  .   .
     ...
  .   .
  Ht.. ......
  END
}

sub run_loop(Wireworld:D $initial, Real:D(Numeric) :$interval=1/4, Bool :$stop_on_repeat) {
  my %seen is SetHash;

  for $initial...^ * eqv * {
    print("\e[2J");
    say "#" x $initial.width;
    .say;
    say "#" x $initial.width;

    if $stop_on_repeat {
      last if %seen{.gist}++;
    }

    sleep($interval);
  }
}
