# Tell if two words are anagrams of each other #
my $a = prompt("First word: ");
my $b = prompt("Second word: ");

say normalize($a) eq normalize($b) ?? "Anagrams" !! "Not anagrams";

sub normalize($word) {
  return $word.comb.sort.join('');
}

# To make the program accept phrases #
sub normalize($phrase) {
  return $phrase.lc.comb.sort.join('').trans(' ' => '');
}
