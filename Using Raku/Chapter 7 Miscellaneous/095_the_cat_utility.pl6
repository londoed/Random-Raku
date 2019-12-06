# Create the equivalent of the UNIX cat utility that copies its STDIN input directly to STDOUT #
say $*IN.slurp;

# Modification to program to print each line as it is entered #
.say while $_ = $*IN.get;
