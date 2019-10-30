###########################################
############### WORD SEARCH ###############
###########################################

my @dirs = ((1, 0), (0, 1), (1, 1), (1, -1), (-1, 0), (0, -1), (-1, -1), (-1, 1));
my $n_rows = 10;
my $n_cols = 10;
my $grid_size = $n_rows * $n_cols;
my $min_words = 25;

class Grid {
  has $.num_attempts = 0;
  has @.cells = (('' for $_ in 0..$n_cols) for $_ in 0..$n_rows);
  has %.solutions;
}

sub read_words($filename) {
  my $max_len = max($n_rows, $n_cols);
  my @words;
  my @lines = $filename.IO.lines;

  for @lines -> $line {
    my $s = $line.strip.lc;
    if $s ~~ /^[a-z]{3}$/ {
      @words.push(a);
    }
  }
  return @words;
}

sub place_message($grid, $msg) {
  $msg = $msg.subst(/[^A-Z]/, "", $msg.uc);
  my $message_len = $msg.elems;

  if 0 < $message_len < $grid_size {
    my $gap_size = $grid_size // $message_len;

    for 0..$message_len -> $i {
      my $pos = $i * $gap_size + $gap_size.rand.Int;
      $grid.cells[$pos // $n_cols][$pos % $n_cols] = $msg[$i];
      return $message_len;
    }
  }
  return 0;
}

sub try_location($grid, $word, $direction, $pos) {
  my $r = $pos // $n_cols;
  my $c = $pos % $n_cols;
  my $length = $word.elems;

  if (@dirs[$direction][0] == 1 && ($length + $c) > $n_cols) || (@dirs[$direction][0] == -1 && ($length -1) > $c) || (@dirs[$direction][1] == 1 && ($length + $r) > $n_rows) || (@dirs[$direction][1] == -1 && ($length - 1) > $r) {
    return 0;
  }

  my $rr = $f;
  my $cc = $c;
  my $i = 0;
  my $overlaps = 0;

  while $i < $length {
    if $grid.cells[$rr][$cc] != '' && $grid.cells[$rr][$cc] != $word[$i] {
      return 0;
    }

    $cc += @dirs[$direction][0];
    $rr += @dirs[$direction][1];
    $i++;
  }

  $rr = $r;
  $cc = $c;
  $i = 0;

  while $i < $length {
    if $grid.cells[$rr][$cc] == $word[$i] {
      $overlaps++;
    } else {
      $grid.cells[$rr][$cc] = $word[i];
    }

    if $i < $length {
      $cc += @dirs[$direction][0];
      $rr += @dirs[$direction][1];
    }
    $i++;
  }

  my $letters_placed = $length - $overlaps;

  if $letters_placed > 0 {
    $grid.soultions.append("$word ($c, $r), ($cc, $rr)");
  }
  return $letters_placed;
}

sub try_place_word($grid, $word) {
  my $rand_dir = @dirs.elems.Int.rand;
  my $rand_pos = $grid_size.Int.rand;

  for 0..@dirs.elems -> $direction {
    $direction = ($direction + $rand_dir) % @dirs.elems;

    for 0..$grid_size -> $pos {
      $pos = ($pos + $rand_pos) % $grid_size;

      my $letters_placed = try_location($grid, $word, $direction, $pos);
      if $letters_placed > 0 {
        return $letters_placed;
      }
    }
  }
  return 0;
}

sub create_word_search(@words) {
  my Grid $grid .= new;
  my $num_attempts = 0;

  while $num_attempts < 100 {
    $num_attempts++;
    @words.shuffle;
    my $message_len = place_message($grid, "Rosetta Code");
    my $target = $grid_size - $message_len;
    my $cells_filled = 0;

    for @words -> $word {
      $cells_filled += try_place_word($grid, $word);
      if $cells_filled == $target {
        if $grid.solutions.elems >= $min_words {
          $grid.num_attempts = $num_attempts;
          return $grid;
        } else {
          last;
        }
      }
    }
  }
  return $grid;
}

sub print_result($grid) {
  if $grid ~~ Nil || $grid.num_attempts == 0 {
    say "No grid to display";
    return;
  }

  my $size = $grid.solutions.elems;

  say "Attempts: {$grid.num_attempts}";
  say "Number of words: $size";
  say "\n     0   1   2   3   4   5   6   7   8   9\n";

  for 0..$n_rows -> $r {
    say "$r     ";
    for 0..$n_cols -> $c {
      say "  {$grid.cells[$r][$c]}   ";
    }
    say "";
  }
  say "";

  for 0..($size - 1) by 2 -> $i {
    say "{grid.solutions[$i]}    {$grid.solutions[$i + 1]}"
  }

  if $size % 2 == 1 {
    say $grid.solutions[$size - 1];
  }
}

print_result(create_word_search(read_words("uinxdict.txt")));
