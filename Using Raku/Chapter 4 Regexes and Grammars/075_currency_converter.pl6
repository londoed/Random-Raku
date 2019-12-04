# Parse the string with a currency converting request such as '10 EUR in USD' and print the result #
my %EUR = {
  AUD => 1.4994, CAD => 1.4741,
  CHF => 1.1504, CNY => 7.7846,
  DKK => 7.4439, GBP => 0.89148,
  ILS => 4.1274, JPY => 131.94,
  RUB => 67.471, USD => 1.1759,
};

while (my $request = prompt("> ")).uc {
  $request ~~ /(<[\d .]>+) \s* (<:alpha> ** 3) .* (<:alpha> ** 3)/;
  my ($amount, $from, $to) = $0, $1, $2;
  my $result = 0;

  if $to eq 'EUR' {
    $result = $amount / %EUR{$from};
  } elsif $from eq 'EUR' {
    $result = $amount * %EUR{$to};
  } else {
    $result = $amount * %EUR{$to} / %EUR{$from};
  }

  say "$amount $from = $result $to";
}
