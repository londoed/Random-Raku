######################################################
############### CHECK WORD FREQUENCIES ###############
######################################################

unless @*ARGV[0] {
  say "\n[-] You need to include a file to test";
  say "[!] USAGE: ~$ perl6 word_freq.pl6 filetest.txt";
  exit;
}

unless @*ARGV[0] ~~ File {
  say "\n[-] The file could not be found, check the path";
  say "\n[!] USAGE: ~$ perl6 word_freq.pl6 filetest.txt";
  exit;
}

my @file = @*ARGV[0];
my Hash %words .= new;

for @file -> $line {
  for %words.value -> $i
  $line.lc.split;
  %words{$i}++;
}

my @sorted;

for %words.value -> $a, $b {
  @sorted = %words.value.sort($a[1] <=> $b[1]);
}

$tmp = @sorted.elems;

for 1..10 -> $j {
  $tmp--;
  say "[+] \"{@sorted[$tmp][0]}\" has {@sorted[$tmp][1]} occurences";
}
