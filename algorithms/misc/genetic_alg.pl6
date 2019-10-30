########################################################
############### SIMPLE GENETIC ALGORITHM ###############
########################################################

use Algorithm::Genetic;
use Algorithm::Genetic::Genotype;
use Algorithm::Genetic::Selection::Roulette;

my $target = 42;

class FindMeaning does Algorithm::Genetic does Algorithm::Genetic::Selection::Roulette {
  has Int $.target;

  method is_finished() returns Bool {
    say "Gen{self.generation} --- pop. size: {@!population.elems}";
    self.population.tail[0].result == $!target;
  }
}

class Equation does Algorithm::Genetic::Genotype {
  our $eq_target = $target;
  our @options = <1 9>;

  has Int $.a is mutable(-> $v {(-1, 1).pick + $v}) = @options.pick;
  has Int $.b is mutable(-> $v {(-1, 1).pick + $v}) = @options.pick;

  method result() {
    return $!a * $!b;
  }

  method !calc_score() returns Numeric {
    return (self.result() - $eq_target)**2;
  }
}

my FindMeaning $ga .= new(:genotype(Equation.new), :mutation_probability(4 / 5), :$target);

$ga.evolve(:generations(1000), :size(16));

say "Stopped at generation {$ga.generation} with result: {.a} x {.b} = {.result} and a score of {.score}" given $ga.population.tail[0];
