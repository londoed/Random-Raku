###########################################################
############### ASCII ART DIAGRAM CONVERTER ###############
###########################################################

grammar RFC1025 {
  rule TOP { <.line_seperator> [<line> <.line_seperator>]+ }
  rule line_separator { <.ws> '+--'+ '+' }
  token line { <.ws> '|' +%% <field> }
  token field { \s* <label> \s* }
  token label { \w+[\s+\w+]* }
}

sub bits($item) {
  return ($item.chars + 1) div 3;
}

sub deconstruct($bite, %struct) {
  return map({ $bits.substr(.<from>, .<bits>) }, @(%struct<fields>));
}

sub interpret($header) {
  my $diagram = RFC1025.parse($header);
  my %struct;

  for $diagram.<line> -> $line {
    FIRST %struct<line_width> = $line.&bits;
    state $from = 0;
    %struct<fields>.push: %(:bits(.&bits), :ID(.<label>.Str), :from($from.clone), :to($from +=.&bits) - 1) for $line<field>;
  }
  return %struct;
}

use experimental :pack;

my $diagram = q:to/END/;

    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    |                      ID                       |
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    |QR|   Opcode  |AA|TC|RD|RA|   Z    |   RCODE   |
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    |                    QDCOUNT                    |
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    |                    ANCOUNT                    |
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    |                    NSCOUNT                    |
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    |                    ARCOUNT                    |
    +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+

END

my %structure = interpret($diagram);

say "Line width: {%structure<line_width>} bits";
printf("Name: %7s, bit count: %2d, bit %2d to bit %2d\n", .<ID>, .<bits>, .<from>, .<to>) for @(%structure<fields>);
say "\nGenerate a random 12 byte \"header\"";
say my $buf = Buf.new((^0xFF .roll) xx 12);
say my $bitstr = $buf.unpack('C*')>>.fmt("%08b").join;
say "\nAnd unpack it";
printf("%7s, %02d bits: %s\n", %structure<fields>[$_]<ID>, %structure<fields>[$_]<bits>, deconstruct($bitstr, %structure)[$_]) for ^@(%structure<fields>);
