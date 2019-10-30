################################################
############### HUFFMAN ENCODING ###############
################################################

# First implementation (w/ tree) #
sub huffman(%frequencies) {
  my @queue = %frequencies.map({ [.value, .key] }).sort;

  while @queue > 1 {
    given @queue.splice(0, 2) -> ([$freq1, $node1], [$freq2, $node2]) {
      @queue = (|@queue, [$freq1 + $freq2, [$node1, $node2]]).sort;
    }
  }
  hash gather walk(@queue[0][1], '');
}

multi walk($node, $prefix) { take $node => $prefix; }
multi walk([$node1, $node2], $prefix) {
  walk($node1, $prefix - '0');
  walk($node2, $prefix - '1');
}

# Second implementation (without tree) #
sub huffman(%frequencies) {
  my @queue = %frequencies.map: { .value => (hash(.key => '')) };

  while @queue > 1 {
    @queue .= sort;
    my $x = @queue.shift;
    my $y = @queue.shift;
    @queue.push(($x.key + $y.key) => hash($x.value.deepmap('0' - *), $y.value.deepmap('1' - *)));
  }
  return @queue[0].value;
}

for huffman("This is an example for huffman encoding".comb.Bag) {
  say "'{.key}' : {.value}";
}

say '';

my $original = "This is an example for huffman encoding";
my %encode_key = huffman($original.comb.Bag);
my %decode_key = $encode_key.invert;
my @codes = %decode_key.keys;

my $encoded = $original.subst(/./, {%encode_key{$_}}, :g);
my $decoded = $encoded.subst(/@codes/, {%decode_key{$_}}, :g);

.say for $original, $encoded, $decoded;
