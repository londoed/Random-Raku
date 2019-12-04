# Print a string in the reversed order form right to left #
my $string = "Hello, World!";
say $string.flip; #=> !dlroW ,olleH

# Flip can be used as a string method and standalone function #
say flip('Abcdef'); #=> fedcbA
say 'Word'.flip; #=> droW
# OR #
'Magic'.flip.say; #=> cigaM

# USING THE REVERSE ROUTINE #
my $string = "Hello, World!";
my $reversed = $string.split('').reverse().join('');
say $reversed; #=> !dlroW ,olleH
