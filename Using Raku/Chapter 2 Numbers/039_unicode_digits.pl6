# Print all Unicode digits #
for 1..0x10FFFD {
  my $char = $_.chr;
  print $char if $char ~~ /<:digit>/;
}

# Using the uniname() method to discover the name of the Unicode digit #
say $char ~ ' ' ~ $char.uniname if $char ~~ /<:digit>/;
