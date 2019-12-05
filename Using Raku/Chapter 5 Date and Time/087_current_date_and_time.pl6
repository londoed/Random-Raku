# Print current date and time as an epoch and in a human-readable format #
say time; #=> 1495785518

say DateTime.now; #=> 2019-12-04T10:27:47.500209+02:00.

# Accessing the separate elements of date and time #
my $dt = DateTime.now;

say $dt.day; #=> 04
say $dt.month; #=> 12
say $dt.year; #=> 2019
say $dt.hour; #=> 10
say $dt.minute; #=> 27
say $dt.second; #=> 5.55802702903748
say $dt.second.Int; #=> 5
