# Convert a number to a Roman numerals string #
my $n = 2018;
my $roman;
my @romans = (
  (1000 => <M MM MMM>),
  (100 => <C CC CCC CD D DC DCC DCCC CM>),
  (10 => <X XX XXX XL L LX LXX LXXX XC>),
  (1 => <I II III IV V VI VII VIII IX>),
);

for @romans -> $i {
  my $digit = ($n / $i.key).Int;
  $roman ~= $i.value[$digit - 1] if $digit;
  $n %= $i.key;
}

say $roman; #=> MMXVIII
