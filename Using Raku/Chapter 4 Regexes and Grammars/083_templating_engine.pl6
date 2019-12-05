# Implementing a simple templating engine, which substitutes values in placeholders of the form %name$ #
my $template = "Hello, %name%! Welcome to %city%!";
my %data = (
  name => 'Klara',
  city => 'Karlovy Vary'
);

say process_template($template, %data);

sub process_template($template is copy, $data) {
  $template ~~ s:g/ '%' (\w+) '%' /%data{$0}/;
  return $template;
}
