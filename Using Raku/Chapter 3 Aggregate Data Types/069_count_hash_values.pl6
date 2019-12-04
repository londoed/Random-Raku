# Having a hash, count the number of occurrences of each of its values #
my %data = {
  apple => 'red', avocado => 'green',
  banana => 'yellow', grapefruit => 'orange',
  grapes => 'green', kiwi => 'green',
  lemon => 'yellow', orange => 'orange',
  pear => 'green', plum => 'purple',
};

my %stat;
%stat{$_}++ for %data.values;
say %stat; #=> {green => 4, orange => 2, purple => 1, red => 1, yellow => 2}
