# Sort a list of hashes using data in their values #
my @people = (
  {name => 'Kevin', age => 20},
  {name => 'Amanda', age => 19},
);

@people.sort(*<age>).say;

# Sort of *<age> is the same as... #
@people.sort({ %^a<age> <=> %^b<age> });

# Using a pointy block syntax #
@people.sort( -> %first, %second { %first<age> <=> $second<age> }).say;
