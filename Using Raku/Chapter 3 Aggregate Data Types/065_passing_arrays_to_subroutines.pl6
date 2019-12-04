# Pass data, contained in an array, to a subroutine #
my @colors = <red blue green>;

sub f(@data, $sep) {
  @data.join($sep).say;
}

f(@colors, ', '); #=> red, green, blue

# With flattening the array #
sub g($a, $b, $c, $sep) {
  say "$a$sep$b$sep$c";
}

g(|@colors, ', '); #=> red, green, blue
