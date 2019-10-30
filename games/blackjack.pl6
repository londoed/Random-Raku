#!/usr/bin/env perl6

##############################################
############### BLACKJACK (21) ###############
##############################################

use v6;

my $player_is_human = 1;

my @values = (
  Ace => 1 | 11,
  Two => 2,
  Three => 3,
  Four => 4,
  Five => 5,
  Six => 6,
  Seven => 7,
  Eight => 8,
  Nine => 9,
  Ten => 10,
  Jack => 10,
  Queen => 10,
  King => 10
);

my @suites = <Spades Clubs Diamonds Hearts>;

my @deck = flat(@values X @suites).map: {my ($name, $value) = $^a.kv; $name ~= " of $^b"; $name => $value};
my @cards = @deck.pick(@deck.elems);

my @dealer;
my @player;

@dealer.push(@cards.shift);
@player.push(@cards.shift);
@dealer.push(@cards.shift);

say "DEALER: ";
say @dealer[0].key;
say "";

say "PLAYER: ";
.key.say for @player;

my $player_value = [+] @player.map: {.value};

loop {
  my $card = @cards.shift;
  @player.push($card);
  say $card.key;

  $player_value += $card.value;

  say "Current value is {$player_value.perl}";

  if $player_value == 21 {
    say "Congratulations, you win!";
    exit(0);
  } elsif $player_value < 21 {
    say "Hit (h) or stay (s)";
    my $choice;
    if $player_is_human {
      loop {
        $choice = lc $*IN.get;
        last if $choice eq "h" | "s";
        say "Invalid entry: 'h' or 's'";
      }
    } else {
      $choice = "stay" unless $player_value < 16;
    }
    say $choice;
    last if $choice ~~ /s/;
  } else {
    say "Sorry, you bust!";
    exit(0);
  }
}

say "";

$player_value = [max] (4..21).grep: {$_ == $player_value};

say "DEALER: ";
.key.say for @dealer;

my $dealer_value = [+] @dealer.map: {.value};

loop {
  say "Dealer value: {$dealer_value.perl}";

  if $dealer_value == any($player_value ^.. 21) {
    say "You lose!";
    exit(0);
  } elsif $dealer_value < 21 {
    my $card = @cards.shift;
    @dealer.push($card);
    say $card.key;
    $dealer_value += $card.value;
  } else {
    say "Dealer bust: you win!";
    exit(0);
  }
}
