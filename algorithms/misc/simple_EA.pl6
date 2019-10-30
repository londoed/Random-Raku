#############################################################
############### SIMPLE EVOLUTIONARY ALGORITHM ###############
#############################################################

constant $TARGET = "METHINKS IT IS LIKE A WEASEL";
constant $MUTATE_CHANCE = 0.08;
constant @ALPHABET = flat('A'..'Z', ' ');
constant $C = 100;

sub mutate() {
  return [~] (rand < $MUTATE_CHANCE ?? @ALPHABET.pick !! $_ for $^string.comb);
}

sub fitness() {
  return [+] $^string.comb Zeq $TARGET.comb;
}

loop {
  my $parent = @ALPHABET.roll($TARGET.chars).join;
  $parent ne $TARGET;
  $parent = max(:by(&fitness), mutate($parent) xx $C);
} { printf("%6d: '%s'\n", $++, $parent) }
