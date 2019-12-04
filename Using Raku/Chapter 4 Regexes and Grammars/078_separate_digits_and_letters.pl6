# In a given string that contains letters and digits, insert dashes on the boarders between the digit and letter sequences #
my $s = "6TGT68";
$s ~~ s:g/(<:alpha>) (<:digit>) | (<:digit>) (<:alpha>) /$0-$1/;
say $s; #=> 6-TGT-68
