# Generate a random string that can be used as a password #
say ('0'..'z').pick(15).join('');

# To limit the characters available in the password #
my @chars = '0'...'9', 'A'...'Z', 'a'...'z';
say @chars.pick(15).join('');

# Solving the task for repeated characters allowed #
my $password = '';
$password ~= ('0'..'z').pick() for 1..15;
say $password;

# Using the .roll() method #
my $password = '';
$password ~= ('0'..'z').roll() for 1..15;
