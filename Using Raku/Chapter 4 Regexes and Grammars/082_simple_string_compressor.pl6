# Convert a string containing repeating characters to a string, where each repetition is represented by the character and the number of its copies #
my $str = "abccccdefffffggghhi";
$str ~~ s:g/( (<:alpha>) $0+ )/{$0[0] ~ $0.chars}/;
say $str; #=> abc4def5g3h2i
