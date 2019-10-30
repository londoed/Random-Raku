#!/usr/bin/env perl6

########################################
############### READ CSV ###############
########################################

use v6.d;

unless @*ARGV[0] {
  say "[!] USAGE: perl6 csv.pl6 <filename.ext>";
  say "[!] EXAMPLE: perl6 csv.pl6 data.csv";
  exit;
}

unless @*ARGV[0].IO.e {
  say "\n[-] The file could not be found, check the path";
  say "[!] USAGE: perl6 csv.pl6 data.csv";
  exit;
}

my $file = open(@*ARGV[0], :r);
my $header = prompt("[*] Does the file include header information [Y/n]? ").chomp;

if $header.lc eq "y" {
  $header = $file.shift;
  say $header.join("\t");

  for $file -> $line {
    say $line;
    say $line.join("\t");
  }
} else {
  for $file -> $line {
    say $line;

    for $line -> $elem {
      say "$elem\t";
    }
  }
}
