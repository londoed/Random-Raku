# Generate the numbers of the Pascal triangle and print them #
my @row = 1;
say 1;
for 1..6 {
  @row = (|@row, 0) >>+<< (0, |@row);
  say @row.join(' ');
}

# Using a subroutine (from Rosetta Code) #
sub pascal($n where $n >= 1) {
  say my @last = 1;
  for 1..$n - 1 -> $row {
    @last = 1, |map: { @last[$_] + @last[$_ + 1] }, 0..$row - 2, 1;
    say @last;
  }
}
