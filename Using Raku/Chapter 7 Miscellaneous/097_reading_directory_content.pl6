# Print the file names form the current directory #
say dir();

# Better way #
.path.say for dir;

# Code equivalent to the more verbose fragment #
for dir() -> $file {
  say $file.path;
}

# To print the full paths of the files #
.absolute.say for dir;

# Listing all jpeg files with tregular expressions #
for dir(test => /\.jpg$/) -> $file {
  say $file.path;
}
