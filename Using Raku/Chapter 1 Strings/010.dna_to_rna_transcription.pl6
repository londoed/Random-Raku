# Convert the given DNA sequence into a compliment RNA sequence #
my %transcription = {A => 'U', C => 'G', G => 'C', T => 'A'};

my $dna = 'ACCATCAGTC';
my $rna = $dna.trans(%transcription);
say $rna; #=> UGGUAGUCAG

say $dna.trans(%transcription, :squash); #=> UGGUAGUCAG

# Also possible to replace the sequences of more than one character #
say $dna.trans('ACCA' => 'UGGU', 'TCA' => 'AGU', 'GTC' => 'CAG');
