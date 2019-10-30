#!/usr/bin/env perl6

###########################################
############### FLASH CARDS ###############
###########################################

my @flash;

class Card {
  has $.question;
  has $.answer;
}

my Card $card .= new;

my @file = @*ARGV;

for @file -> $line {
  if $line ~~ /(.*)\s{3,10}(.*)/ {
    @flash.push(my Card $card .= new($1.strip, $2.strip));
  }
}

for @flash -> $_ {
  my $drill = @flash.pick;
  my $guess = prompt("[*] {$drill.question}? ");

  if $guess.lc == $drill.answer.lc {
    say "\n\n[+] CORRECT! --- The answer is: {$drill.answer}\n\n\n";
  } else {
    say "\n\n[-] INCORRECT --- The answer is {$drill.answer}\n\n\n";
  }

  @flash.delete($drill);
}

# until @flash ~~ Nil {
#   for @flash
#   my $drill = @flash.pick;
#   my $guess = prompt("[*] {$drill.question}? ");
#
#   if $guess.lc == $drill.answer.lc {
#     say "\n\n[+] CORRECT! --- The answer is: {$drill.answer}\n\n\n";
#   } else {
#     say "\n\n[-] INCORRECT --- The answer is {$drill.answer}\n\n\n";
#   }
# }
