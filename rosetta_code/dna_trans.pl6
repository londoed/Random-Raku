#################################################
############### DNA TRANSCRIPTION ###############
#################################################

my %transcription = A => 'U', C => 'G', G => 'C', T => 'A';

my $dna = 'ACCATCAGTC';
my $rna = $dna.trans(%transcription);
say $rna;
