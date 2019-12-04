# Ask a user for their name and greet them by priting 'Hello, <Name>!'

say 'Hello, ' ~ prompt('Enter your name: ') ~ '!';

# ANOTHER WAY#
my $name = prompt('Enter your name: ');
say "Hello, $name!";

# ANOTHER WAY #
print 'Enter your name: ';
my $name = get();
say "Hello, $name!";

# ANOTHER WAY #
say "Enter your name: ";
my $name = $*IN.get();
say "Hello, $name!";
