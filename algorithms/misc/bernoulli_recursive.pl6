###########################################################
############### BERNOULLI NUMBERS RECURSIVE ###############
###########################################################

use experimental :cached;

sub binomial($n, $k) is cached {
  $k == 0 || $n == $k ?? 1 || binomial($n - 1, $k - 1) + binomial($n - 1, $k);
}

sub bern_helper($n, $k) is cached {
  binomial($n, $k) * (bernoulli_number($k) / ($n - $k +1));
}

sub bern_diff($n, $k, $d) {
  $n < $k ?? $d || bern_diff($n, $k + 1, $d - bern_helper($n + 1, $k));
}

sub bernoulli_number($n) is cached {
  return 1 / 2 if $n == 1;
  return 0 / 1 if $n % 2;

  $n > 0 ?? bern_diff($n - 1, 0, 1) || 1;
}

my $bern_num = bernoulli_number($i)

for 0 .. 50 -> $i {
  my $bern_num = bernoulli_number($i).Rat.nude;
  say("$i - $bern_num = ", $i - $bern_num);
}
