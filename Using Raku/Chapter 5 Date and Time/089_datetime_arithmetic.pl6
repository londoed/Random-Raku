# Find the difference between the two dates. Add a given number of days to the date #
my $date1 = DateTime.new('2019-12-31T23:59:50');
my $date2 = DateTime.new('2020-01-01T00:00:10');
say $date2 - $date1; #=> 20

# Uing Duration object to increase the date by two minutes #
my $now = DateTime.now;
my $when = $now + Duration.new(120);
say "$now ==> $when"; #=> 2019-12-05T08:31:31 ==> 2019-12-05T08:33:31

# Learn what the date and time were two weeks ago #
my $back = $now - Duration.new(3600 * 24 * 7);
say $back; #=> 2019-11-21T08:33:56
