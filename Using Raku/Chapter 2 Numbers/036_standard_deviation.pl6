# For the given data, calculate the standard deviation value (signa) #
my @data = (727.7, 1086.5, 1091.0, 1361.3, 1490.5, 1956.1);

my $avg = ([+] @data) / @data.elems;
my $sigma = sqrt(([+] map * ** 2, map * - $avg, @data) / (@data.elems - 1));
say $sigma; #=> 420.962489619523

# Merging the two maps into one #
my $sigma = sqrt(([+] map (* - $avg)**2, @data) / (@data.elems - 1));

# Using feed operators #
my @data = (727.7, 1086.5, 1091.0, 1361.3, 1490.5, 1956.1);

my $avg = ([+] @data) / @data.elems;
@data
  ==> map * - $avg
  ==> map * **2
  ==> reduce * + *
  ==> my @σ;
say sqrt(@σ[0] / (@data.elems - 1)); #=> 420.962489619523
