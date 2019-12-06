# Create the interpreter for the Brainfuck language #
my $program = $*IN.slurp;
brainfuck($program);

sub brainfuck($program) {
  my @program = $program.comb('');
  my $program_pointer = 0;
  my @data_memory;
  my $data_pointer = 0;

  while $program_pointer < @program.elems {
    given @program[$program_pointer] {
      when '>' { $data_pointer++ }
      when '<' { $data_pointer-- }
      when '+' { @data_memory[$data_pointer]++ }
      when '-' { @data_memory[$data_pointer]-- }
      when '.' { print @data_memory[$data_pointer].chr }
      when '[' {
        $program_pointer = move_forward(@program, $program_pointer) unless @data_memory[$data_pointer];
      }
      when ']' {
        $program_pointer = move_back(@program, $program_pointer) if @data_memory[$data_pointer];
      }
      when ',' { @data_memory[$data_pointer] = $*IN.getc.?ord }
    }
    return $program_pointer++;
  }
}

sub move_back(@program, $program_pointer is copy) {
  my $level = 1;

  while $level && $program_pointer >= 0 {
    $program_pointer--;
    given @program[$program_pointer] {
      when '[' { $level-- }
      when ']' { $level++ }
    }
  }
  return $program_pointer - 1;
}

sub move_forward(@program, $program_pointer is copy) {
  my $level = 1;

  while $level && $program_pointer < @program.elems {
    $program_pointer++;
    given @program[$program_pointer] {
      when '[' { $level++ }
      when ']' { $level-- }
    }
  }
  return $program_pointer - 1;
}

say $program;
say ' ' x $program_pointer ~ '^';
say @data_memory[0..$data_pointer - 1] ~ ' [' ~ @data_memory[$data_pointer] ~ '] ' ~ @data_memory[$data_pointer + 1..*];
