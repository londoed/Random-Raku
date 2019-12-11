# Convert the given text to the Morse code #
my %code = (
  a => '.-',      b => '-...',    c => '-.-.',
  d => '-..',     e => '.',       f => '..-.',
  g => '--.',     h => '....'     i => '..',
  j => '.---',    k => '-.-',     l => '.-..',
  m => '--',      n => '-.',      o => '---',
  p => '.--.',    q => '--.-',    r => '.-.',
  s => '...',     t => '-',       u => '..-',
  v => '...-',    w => '.--',     x => '-..-',
  y => '-.--',    z => '--..',    0 => '-----',
  1 => '.----',   2 => '..---',   3 => '...--',
  4 => '....-',   5 => '.....',   6 => '-....',
  7 => '--...',   8 => '---..',   9 => '----.'
);

my $phrase = prompt("Your phrase in plain text: ");
$phrase .= lc;

$phrase ~~ s:g/<-[a..z0..9]>/ /;
$phrase ~~ s:g/\s+/ /;
$phrase ~~ s:g/(<[a..z0..9]>)/%code{$0}/;

say "Converted to Morse code: $phrase";