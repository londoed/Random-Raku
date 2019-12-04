# Remove the leading, trailing, and double spaces from a given string #
my $string = "Hello,    World!";
$string ~~ s:g/\s+/ /;

# ANOTHER WAY #
say $string.trim;
say trim($string);

# Trim trailing and trim leading #
say '¡' ~ ' Hi '.trim-leading; #=> ¡Hi
say ' Hi '.trim-trailing ~ '!'; #=> 		Hi!
