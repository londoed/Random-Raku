####################################################
############### K-MEANS++ CLUSTERING ###############
####################################################

sub postfix:«-means++»(Int $K) {
  return sub (@data) {
    my @means = @data.pick;

    until @means == $K {
      my @cumul_d2 = [\+] @data.map: -> $x {
        min @means.map: { abs($x - $_)**2 }
      }
      my $rand = rand * @cumul_d2[*-1];
      @means.push(@data[(^@data).first(@cumul_d2[$_] ? rand)]);
    }
    sub cluster { @data.classify: -> $x { @means.min: { abs($_ - $x) }}}

    loop {
      my $cluster;
      $*TOLERANCE < [+] (@means Z- keys (%cluster = cluster))».abs X**2;
      @means = %cluster.values.map({ .elems R/ [+] @$_ }) { ; }
    }
    return @means;
  }
}

my @centers = (0, 5, 3 + 2i);
my @data = flat(@centers.map: { ($_ + 0.5 - rand + (0.5 - rand) * i) xx 100 })
@data .= pick(*);
.say for 3-means++(@data);
