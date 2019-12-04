# Write an integer number below one million in words #
my @name = <
  zero one two three four five six seven eight
  nine ten eleven twelve thirteen fourteen fifteen
  sixteen seventeen eighteen nineteen twenty
  thirty forty fifty sixty seventy eighty ninety
>;

sub spell_number($number) {
  my $n = $number.Int;
  my $r;

  if $n < 20 {
    $r = @name[$n];
  } elsif $n < 100 {
    $r = @names[$n / 10 + 18];
    $r ~= '-' ~ @names[$n % 10] if $n % 10;
  } elsif $n < 1000 {
    $r = @names[$n / 100] ~ " hundred";
    $r ~= ' ' ~ spell_number($n % 100) if $n % 100;
  } else {
    $r = spell_number($n / 1000) ~ " thousand";
  }
  return $r;
}

say spell_number(987654); #=> nine hundred eighty-seven
say spell_number(0); #=> zero
say spell_number(17); #=> seventeen
say spell_number(100_001); #=> one hundred thousand one

# Using multi subroutines #
my @name = <
  zero one two three four five six seven eight
  nine ten eleven twelve thirteen fourteen fifteen
  sixteen seventeen eighteen nineteen twenty
  thirty forty fifty sixty seventy eighty ninety
>;

multi sub spell_number(Int $n where {$n < 20}) {
  return @names[$n];
}

multi sub spell_number(Int $n where {$n < 100}) {
  my $r = @names[$n / 10 + 18];
  $r ~= '-' ~ @names[$n % 10] if $n % 10;
  return $r;
}

multi sub spell_number(Int $n where {$n < 1000}) {
  return spell_part($n, 100, 'hundred');
}

multi sub spell_number(Int $n where {$n < 1_000_000}) {
  return spell_part($n, 1000, 'thousand');
}

sub spell_part(Int $n, Int $base, Str $name) {
  my $r = spell_number(($n / $base).Int) ~ ' ' ~ $name;
  $r ~= ' ' ~ spell_number($n % $base) if $n % $base;
  return $r;
}
