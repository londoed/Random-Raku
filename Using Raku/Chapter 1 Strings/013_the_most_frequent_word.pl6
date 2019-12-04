# Find the most frequent word in the given text #
my $text = prompt("Text: ");
my %count;
%count{$_}++ for $text.lc.comb(/\w+/);
say (sort({ %count{$^b} <=> %count{$^a} }), %count.keys)[0];

# Extractng the number of repititions #
my $max = %count{(sort({ %count{$^b} <=> %count{$^a} }), count.keys)[0]}
.say for %count.keys.grep({ %count{$_} == $max });
