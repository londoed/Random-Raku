###############################################
############### BASIC MLP MODEL ###############
###############################################

use Math::Matrix;

my $training_input = Math::Matrix.new([0, 0, 1], [0, 1, 1], [1, 0, 1], [1, 1, 1]);
my $training_output = Math::Matrix.new([0], [0], [1], [1]);
my $synaptic_weights = Math::Matrix.new([[2.rand() - 1] xx 3]);

sub sigmoid($x) {
  return 1 / (1 + (-$x).exp);
}

sub d_sigmoid($x) {
  return $x * (1 - $x);
}

sub train($training_input, $training_output) {
  my $output = think($training_input);
  my $error = $training_output - $output;
  my $delta = $output.apply(&d_sigmoid);
  my $adjust = $training_input.T() dot ($delta * $error);
  $synaptic_weights += $adjust;
}

sub think($input) {
  my $inter = ($input dot $synaptic_weights);
  return $inter.apply(&sigmoid);
}

train($training_input, $training_output) for ^100;

my $result = think(Math::Matrix.new([[1, 0, 0]]));

say "Result : {$result[0][0]}";
