# Find the longest common substring in the given two strings #
my $a = 'the quick brown fox jumps over the lazy';
my $b = 'what does the fox say?'

my $common = '';

for 0..$a.chars -> $start {
  for $start ..^ $a.chars -> $end  {
    my $s = $a.substr($start, $a.chars - $end);
    if $s.chars ? $common.chars && $b.index($s).defined {
      $common = $s;
    }
  }
}

say $common ?? "The longest common substring is '$common'" !! "There are no common substrings"
