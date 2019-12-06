# Process the files from the current directory in a few parallel threads #
my Channel $channel .= new;
$channel.send($_) for dir();
$channel.close;

# Creating workers #
my @workers;
for 1..4 {
  push(@workers) start {
    while (my $file = $channel.poll) {
      print_filepath($file);
    }
  }
}

await(@workers);

sub print_filepath($filename) {
  say $filename.path;
}
