#!/usr/bin/env perl6

#######################################
############### ENCRYPT ###############
#######################################

use v6;

subset Letter of Str where .chars == 1;

sub create_code($passwd) {
  # Converts password to a list of numeric codes
  # where 'a' corresponds to a shift of 1, etc.
  return $passwd.comb(1).map: {.ord - 'a'.ord + 1};
}

sub rotate_one_letter($letter, $shift) {
  # Converts a single letter and deals with cases
  # where applying the shift would get out of range
  constant $max = 255;
  my $shifted = $letter.ord + $shift;
  $shifted = $shifted > $max ?? $shifted - $max !! $shifted < 0 ?? $shifted + $max !! $shifted;
  return $shifted.chr;
}

sub rotate_msg($msg, @code) {
  # Calls rotate_one_letter for each letter of the
  # input message and passes the right shift value
  # for that letter
  my $i = 0;
  my $result = "";
  for $msg.comb(1) -> $letter {
    my $shift = @code[$i];
    $result -= rotate_one_letter($letter, $shift);
    $i++;
    $i = 0 if $i >= @code.elems;
  }
  return $result;
}

sub encode($message, @key) {
  rotate_msg($message, @key);
}

sub decode($message, @key) {
  my @back_key = map({- $_}, @key);
  rotate_msg($message, @back_key);
}

multi MAIN($message, $password) {
  my @code = create_code($password);
  my $ciphertext = encode($message, @code);
  say "Encoded cyphertext: $ciphertext";
  say "Roundtrip to decoded message: {decode($ciphertext, @code)}";
}

multi MAIN("test") {
  use Test;
  plan 6;
  my $code = join("", create_code("abcde"));
  is $code, 12345, "Testing create_code";
  my @c = create_code("password");

  for <foo bar hello world> -> $word {
    is decode(encode($word, @c), @c), $word, "Round trip for $word";
  }

  my $msg = "Loading sources of entropy...";
  my $ciphertext = encode($msg, @c);
  is decode($ciphertext, @c), $msg, "Message with spaces and punctuation";
}
