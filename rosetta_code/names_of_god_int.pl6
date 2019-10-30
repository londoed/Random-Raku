##################################################################
############### 9 BILLION NAMES OF THE GOD INTEGER ###############
##################################################################

my @todo = $[1];
my @sums = 0;

sub next_row($n) {
  for +@todo..$n -> $l {
    @sums[$l] = 0;
    print "$l\r" if $l < $n;
    my $r = [];
    for reverse(^$l) -> $x {
      my @x := @todo[$x];
      if @x {
        $r.push: @sums[$x] += @x.shift;
      } else {
        $r.push: @sums[$x];
      }
    }
    @todo.push($r);
  }
  return @todo[$n];
}

say "[+] Rows: ";
say .fmt('%2d'), ": ", next_row($_)[] for 1..10;

say "\n[+] Sums: ";
for <23 123 1234 12345> {
  say $_, "\t", [+] next_row($_)[];
}
