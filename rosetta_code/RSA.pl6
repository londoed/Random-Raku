########################################
############### RSA CODE ###############
########################################

constant $n = 9516311845790656153499716760847001433441357;
constant $e = 65537;
constant $d = 5671843187844953170308463622230283376298685;

my $secret_message = "NBODYSIMULATIONS";

package Message {
  my @alphabet = slip('A' .. 'Z'), ' ';
  my $rad = +@alphabet;
  my %code = @alphabet Z => 0 .. *;

  subset Text of Str where /^^ @alphabet+ $$/;

  our sub encode(Text $t) {
    return [+] %code{$t.flip.comb} Z* (1, $rad, $rad**2 ... *);
  }

  our sub decode(Int $n is copy) {
    @alphabet[
      gather loop {
        take $n % $rad;
        last if $n < $rad;
        $n div= $rad;
      }
    ].join.flip;
  }
}

use Test;
plan 1;

say "Secret message is $secret_message";
say "Secret message in integer form is $_" given my $numeric_message = Message::encode($secret_message);
say "After exponentiation with public exponent we get: $_" given my $numeric_cipher = expmod($numeric_message, $e, $n);
say "This turns into the string $_" given my $text_cipher = Message::decode($numeric_cipher);

say "If we re-encode it in integer form we get $_" given my $numeric_cipher2 = Message::encode($text_cipher);
say "After exponentiation with SECRET exponent we get: $_" given my $numeric_message2 = expmod($numeric_cipher2, $d, $n);
say "This turns into the string $_" given my $secret_message2 = Message::decode($numeric_message2);

is $secret_message, $secret_message2, "The message has been correctly decrypted";
