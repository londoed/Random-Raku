# Generate a list of filenames like file1.txt, file2.txt, etc. #
my $filename = "file0.txt";
for 1..5 {
  $filename++;
  say $filename;
}

# FOR A LOT OF FILES #
my $filename = "file000.txt";
for 1..500 {
  $filename++;
  say $filename;
}
