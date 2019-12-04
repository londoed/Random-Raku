# Find duplicate fragments in the same text #
my $text = $*IN.slurp;
$text .= lc;
$text ~~ s:g/\W+/ /;
my $length =  $text.chars;

my %phrases;
my $start = 0;

while $text ~~ m:c($start)/(<< [\w+] ** 5 %% \s >>) .+ $0/ {
  $start = $0.from + 1;
  %phrases{$0}++;

  print (100 * $start / $length).fmt('%i%% ');
  say $0;
}

say "\nDuplicated strings: ";

for %phrases.keys.sort({ %phrases{$^b} <=> %phrases{$^a} }) {
  say "$_ = " ~ %phrases{$_} + 1;
}
