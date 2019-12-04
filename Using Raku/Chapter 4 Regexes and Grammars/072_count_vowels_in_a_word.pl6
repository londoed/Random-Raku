# Count the number of vowels in the given word #
my $word = "Hello";
$word ~~ m:g:i/<[aeiou]>/;
say $/.elems;

# Extending the match to allow characters with diacritics #
$word = "Münich";
$word ~~ m:g:i:m/<[aeiou]>/;
say $/.elems;

# Using the long adverb names #
$word ~~ m:global:ignorecase:ignoremark/<[aeiou]>/;
