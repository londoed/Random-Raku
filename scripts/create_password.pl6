#!/usr/bin/env perl6

unless @*ARGV[0] {
  say "[-] You need to include a password to test...";
  say "[!] USAGE: ~$ perl6 create_password.pl6 mysupersecretpassword";
  exit;
}

my $password = @*ARGV[0];
my @word = $password.split("");
my Hash %letters .= new;
my $set_size = 96;

for @word -> $i {
  %letters{$i} += 1.0;
}

for %letters.keys -> $j {
  %letters{$j} /= @word.elems;
}

my $entropy = -1 * %letters.keys.inject(0.Rat);

for $entropy -> $sum $k {
  $sum + (%letters{$k} * (log(%letters{$k}) / log(2.Rat)));
}

my $combinations = 96**$password.chars;
my $days = $combinations.Rat / (10_000_000 * 86_400);
my $years = $days / 365;

say "\n[+] The entropy value is: $entropy";
say "\n[+] And it will take ~ {$days < 365 ?? $days.Int} days";
