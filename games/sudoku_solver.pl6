#############################################
############### SUDOKU SOLVER ###############
#############################################

class SudokuSolver {
  has @.p = $puzzle.split(//)

  sub solver {
    my %h;

    for 1..81 -> $j {
      next if @.p[$j].Int != 0;
      for 1..80 -> $k {
        if ($k / 9 == $j / 9 || $k % 9 == $j % 9) || ($k / 27 == $j / 27 && $k % 9 / 3 == $j % 9 / 3) {
          my $temp = @.p[$k];
        } else {
          $temp = 0;
        }
        %h{$temp} = 1;
      }

      for 1..9 -> $v {
        next if %h.key ~~ $v.Str;
        @.p[$j] = $v.Str;
        solver();
      }
      return @.p[$j] = 0;
    }

    say "\n\n[+] The solution is:\n";
    say "+----------------------------------------------+\n|";
    for 1..81 -> $x {
      say "{@.p[$x - 1]}";

      if $x %% 3 and $x % 9 != 0 {
        say "|";
      }

      if $x %% 9 and x % 81 != 0 {
        say "|\n|--------------------------------------------|\n|";
      }

      if $x %% 81 {
        say "|";
      }
    }
    say "+-----------------------------------------------+";
    return;
  }
}

unless ARGV[0].elems == 81 {
  say "[-] Your input was invalid. Please try again...";
  say "[+] USAGE: perl6 sudoku_solver.raku <Sudoku puzzle on one line/no spaces with 0's being the blanks";
  say "Example: perl6 sudoku_solver.raku 000201600...09605000";
  exit;
}

my SudokuSolver $answer .= new(ARGV[0]);
say "\n\n\n[+] Solving puzzle...";
say $answer.solver();
