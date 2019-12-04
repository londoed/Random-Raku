# Encode a message using the Caesar cipher technique #
my $message = 'hello, world!';
my $secret = $message.trans(['a'..'z'] => ['w'..'z', 'a'..'v']);
say $secret; #=> dahhk, shnhz!

my $decoded = $secret.trans(['w'..'z', 'a'..'v'] => ['a'..'z']);
say $decoded; #=> hello, world!
