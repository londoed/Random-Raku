# Find the prime factors of a given number #
my $n = 123456789;

my @list;
my @prime = grep { .is-prime }, 1..*;
my $pos = 0;

while $n > 1 {
  my $factor = @prime[$pos];
  $pos++;
  next unless $n %% $factor;

  $pos = 0;
  $n /= $factor;
  push(@list, $factor);
}

say @list; #=> [3 3 3607 3803]
