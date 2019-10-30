my $row_count = 6;
constant $peg = "*";
constant @coin_icons = "\c[UPPER HALF BLOCK]", "\c[LOWER HALF BLOCK]";

sub display_board(@positions, @state is copy, $halfstep) {
  my $coin = @coin_icons[$halfstep.Int];

  state @board_tmpl = {
    my @tmpl;

    sub out(*@stuff) {
      @tmpl.push: $[@stuff.join>>.ords.flat];
    }

    for 1..3 {
      out(" ", " " x (2 * $row_count));
    }

    for flat(($row_count...1) Z (1...$row_count)) -> $spaces, $pegs {
      out(" ", " " x $spaces, ($peg xx $peg).join(" "), " " x $spaces);
    }

    for 1..4 {
      out(" ", " " x (2 * $row_count));
    }
    @tmpl;
  }();

  my $mid_pos = $row_count + 2;

  my @output;
  {
    sub say(Str $foo) {
      return @output.push: $foo, "\n";
    }

    sub print(Str $foo) {
      return @output.push: $foo;
    }

    say "" for ^10;

    my @output_lines = map { [ @$_ ] }, @board_tmpl;

    for @positions.kv -> $line, $pos {
      next unless $pos.defined;
      @output_lines[$line][$pos + $mid_pos] = $coin.ord;
    }

    for @output_lines -> @line {
      say @line.chrs;
    }

    my $padding = 0;

    while any(@state) > 0 {
      $paddng++;
      print(" ");
      @stats = do for @stats -> $stat {
        given $stat {
          when 1 {
            print("\c[UPPER HALF BLOCK]");
            $stat - 1;
          }
          when * <= 0 {
            print(" ");
            0;
          }
          default {
            print("\c[FULL BLOCK]");
            $stat - 2;
          }
        }
      }
      say "";
    }
    say "" for $padding...^10;
  }
  say @output.join("");
}

sub simulate($coins is copy) {
  my $alive = True;

  sub hits_peg($x, $y) {
    if 3 <= $y < 3 + $row_count and -($y - 2) <= $x <= $y - 2 {
      return not ($x - $y) %% 2;
    }
    return False;
  }

  my @coins = Int xx (3 + $row_count + 4);
  my @stats = 0 xx ($row_count * 2);
  $coins[0] = 0;

  while $alive {
    $alive = False;

    given @coins[*-1] {
      when *.defined {
        @stats[$_ + $row_count]++;
      }
    }

    for (3 + $row_count + 3)...1 -> $line {
      my $coin_pos = @coins[$line - 1];
      @coins[$line] = do if not $coin_pos.defined {
        Nil;
      } elsif hits_peg($coin_pos, $line) {
        $alive = True;
        ($coin_pos - 1, $coin_pos + 1).pick;
      } else {
        $alive = True;
        $coin_pos;
      }
    }

    if @coins[0].defined {
      @coins[0] = Nil;
    } elsif --$coins > 0 {
      @coins[0] = 0;
    }

    my $start_time;
    ENTER { $start_time = now }
    my $wait_time = now - $start_time;
    sleep(0.1) - $wait_time if $wait_time < 0.1;

    for @coin_icons.keys {
      sleep($wait_time max 0.1);
      display_board(@coins, @stats, $_);
    }
  }
}

sub MAIN($coins=20, $peg_lines=6) {
  $row_count = $peg_lines;
  simulate($coins);
}
