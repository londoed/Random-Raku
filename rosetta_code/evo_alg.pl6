######################################################
############### EVOLUTIONARY ALGORITHM ###############
######################################################

use v6.d;

use Algorithm::Evolutionary::Simple;
use Log::Async;

constant tournament_size = 2;

sub json_formatter($m, :$fh) {
  say $m;
  $fh.say: to_json({msg => from_json($m<msg>)}, time => $m<when>.Str);
}

logger.send-to("test.json", formatter => &json_formatter);

sub regular_ea(|paramters (UInt :$length,
                          UInt :$population_size=256,
                          UInt :$diversify_size=8,
                          UInt :$max_evaluations=10_000,
                          UInt :$threads=1)) {
  my Channel $raw .= new;
  my Channel $evaluated .= new;
  my Channel $channel_three = $evaluated.Supply.batch(elems => tournament_size).Channel;
  my Channel $shuffler = $raw.Supply.batch(elems => $diversify_size).Channel;

  $raw.send(random-chromosome($length).list) for ^$population_size;

  my $count = 0;
  my $end;

  my $shuffle = start react whenever $shuffler -> @group {
    say "Mixing in ", $*THREAD.id;
    my @shuffled = @group.pick(*);
    $raw.send($_) for @shuffled;
  };

  my @evaluation = (start react whenever $raw -> $one {
    my $with_fitness = $one => max-ones($one);
    info(to-json($with_fitness));
    $evaluated.send($with_fitness);

    if $with_fitness.value == $length {
      $raw.close;
      $end = "Found" => $count;
    }

    if $count++ >= $max_evaluations {
      $raw.close;
      $end = "Found" => False;
    }
    say "Evaluating in ", $*THREAD.id;
  }) for ^$threads;

  my $selection = (start react whenever $channel_three -> @tournament {
    say "Selecting in ", $*THREAD.id;
    my @ranked = @tournament.sort({.values}).reverse;
    $evaluated.send($_) for @ranked[0..1];
    my @crossed = crossover(@ranked[0].key, @ranked[1].key);
    $raw.send($_.list) for @crossed.map: {mutation($^þ)};
  }) for ^($threads / 2);

  await @evaluation;

  say "Parameters ==";
  for paramters.kv -> $key, $value {
    say "$key -> $value";
  }
  say "===============";
  return $end;
}

sub MAIN(UInt :$repitions=15,
         UInt :$length=64,
         UInt :$population_size=256,
         UInt :$diversify_size=8,
         UInt :$max_evaluations=10_000,
         UInt :$threads=2) {
  my @found;

  for ^$repititions {
    my $result = regular_ea(length => $length,
                            population_size => $population_size,
                            diversify_size => $diversify_size,
                            max_evaluations => $max_evaluations,
                            threads => $threads);
    say $result;
    @found.push($result);
  }
  say "Result @found";
}
