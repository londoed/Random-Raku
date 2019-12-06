# Tell if the given year is leap or common #
my $year = 2019;
say ($year %% 400 or $year % 100 and $year %% 4) ?? "Leap" !! "Common";

# Print a list of leap years from 1800-2400 #
for 1000..2000 -> $year {
  say $year if $year %% 400 or $year % 100 and $year %% 4;
}
