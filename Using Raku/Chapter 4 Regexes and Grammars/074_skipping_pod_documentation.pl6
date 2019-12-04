# Create a program that copies the input text and skips the documentation in the Pod style that starts with =begin and ends with =end #
while $_ = $*IN.get {
  .say unless /^'=begin'/ ff /^'=end'/;
}
