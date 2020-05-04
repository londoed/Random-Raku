#!/usr/bin/env perl6

#################################################
############### Simple Calculator ###############
#################################################

use v6.d;

sub addition() {
  say "Addition";

  my $n = prompt("Enter a number: ").Rat;
  my $t = 0;
  my $ans = 0.0;

  while $n != 0 {
    $ans += $n;
    $t++
    $n = prompt("Enter another number (0 to calculate): ").Rat;
  }

  return ($ans, $t);
}

sub subtraction() {
  say "Subtraction";

  my $n = prompt("Enter a number: ").Rat;
  my $t = 0;
  my $sum = 0.0;

  while $n != 0 {
    $ans -= $n;
    $t++;
    $n = prompt("Enter another number (0 to calculate): ").Rat;
  }

  return ($ans, $t);
}

sub multiplication() {
  say "Multiplication";

  my $n = prompt("Enter a number: ").Rat;
  my $t = 0;
  my $ans = 1;

  while $n != 0 {
    $ans *= $n;
    $t++;
    $n = prompt("Enter another number (0 to calculate): ");
  }

  return ($ans, $t);
}

sub division() {
  say "Division";

  my $n = prompt("Enter a number: ").Rat;
  my $t = 0;
  my $m = prompt("Enter another number (0 to calculate): ").Rat;
  my $ans = $n;

  while $n != 0 && $m != 0 {
    if $ans == $n {
      $ans = $n / $m;
      $t++;
      $n = prompt("Enter another number (0 to calculate): ").Rat;
    } else {
      $ans /= $n;
      $t++;
      $n = prompt("Enter another number (0 to calculate): ").Rat;
    }
  }

  return ($ans, $t);
}

sub average() {
  my $an = addition();
  my $t = $an[1];
  my $a = $an[0];
  my $ans = $a / $t;
  return ($ans, $t)
}

sub MAIN() {
  while True {
    my $list = ();

    say "Simple Calculator in Raku/Perl6 by Eric Londo";
    say "\n\nDo you want to perform [A]ddition [S]ubtraction [M]ultiplication [D]ivision or A[V]erage? (press q to quit)";

    my $choice = $*IN.get.lc;

    if $choice ne 'q' {
      given $choice {
        when 'a' {
          $list = addition();
          say "The answer is {$list[0]}\tTotal Inputs: {$list[1]}";
        }

        when 's' {
          $list = subtraction();
          say "The answer is {$list[0]}\tTotal Inputs: {$list[1]}";
        }

        when 'm' {
          $list = multiplication();
          say "The answer is {$list[0]}\tTotal Inputs: {$list[1]}";
        }

        when 'd' {
          $list = division();
          say "The answer is {$list[0]}\tTotal Inputs: {$list[1]}";
        }

        when 'v' {
          $list = average();
          say "The answer is {$list[0]}\tTotal Inputs: {$list[1]}";
        }

        default { say "[!] ERROR: Invalid character"};
      }
    } else {
      last;
    }
  }
}
