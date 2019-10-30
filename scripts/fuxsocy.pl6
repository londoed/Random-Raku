#!/usr/bin/env perl6

#######################################
############### FuxSocy ###############
#######################################

# Written to imitate the Python script output in MR. ROBOT! #

use Math;
use Time;
use Random;

sub MAIN() {
  say "Executing FuxSocy";
  say "Loading Source of Entropy";

  my $entropy = "/dev/random".IO.slurp;

  for 0 .. 31 -> $i {
    for 0 .. $i -> $_ {
      say "#";
    }
    for $i .. 30 {
      say " ";
    }
    if $i < 30 {
      say " {ceil($i / 30.0 * 100.0)}\r";
    } else {
      say " COMPLETE\r";
    }
    flush();
    $_ = $entropy.read(2);
  }

  say "";
  say "";

  say "Generating Keys...";
  for 0 .. 31 -> $i {
    for 0 .. $i -> &_ {
      say "#";
    }
    for $i .. 30 -> $_ {
      say " ";
    }
    if $i < 30 {
      say " {ceil($i / 30.0 * 100.0)}\r";
    } else {
      say " COMPLETE\r";
    }
    flush();
    sleep(0.3);
  }

  say "";
  say "";

  say "Locating target files.";
  say "Beginning crypto operations...";

  my @paths = </bin /boot /dev /etc /home>;

  for @paths -> $path {
    say "Encrypting $path";
    sleep(1.0 + rand() * 2.0);
  }

  say "\x1b[1m\x1b[5mit's happening\x1b[0m";
}
