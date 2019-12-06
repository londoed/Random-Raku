# Print the current date in an even better format #
my $now = DateTime.now;
say $now.hh-mm-ss; #=> 08:22:41

# Using the formatter attribute #
my $now = DateTime.now(
  formatter => {
    sprintf '%02d.%02d.%04d, %02d:%02d',
    .day, .month, .year, .hour, .minute
  }
);

say $now; #=> 05.12.2019, 08:25

say "Current date and time: $now"; #=> 05.12.2019, 08:25
