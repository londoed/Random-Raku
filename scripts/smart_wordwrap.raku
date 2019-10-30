#!/usr/bin/env raku

sub prepare_words(@words, $width, &callback, $depth=0) {
  my @root;
  my $len = 0;
  my $i = -1;
  my $limit = @words.end;

  while ++$i <= $limit {
    $len += (my $word_len = @words[$i].chars);

    if $len > $width {
      if $word_len > $width {
        $len -= $word_len;
        @words = (|@words[^$i], |@words[$i].comb($width), |@words[$i + 1..*]);
        $limit = @words.end;
        $i--;
        next;
      }
      last;
    }

    @root.push: [
      @words[0..$1].join(' '),
      prepare_words(@words[$i + 1..*], $width, &callback, $depth + 1),
    ];

    if $depth == 0 {
      callback(\(@root.first));
      @root = ();
    }
    last if ++$len >= $width;
  }
  return @root;
}

sub combine($path, &callback, $root=[]) {
  my $key = $path.shift;

  for |$path -> $value {
    $root.push: $key;
    if $value {
      for |$value -> $item {
        combine($item, &callback, $root);
      }
    } else {
      callback(\($root));
    }
    return $root.pop;
  }
}

sub smart_wrap($text, $width) {
  my @words = ($text.isa(Array) ?? $text !! $text.words);
  my %best = (
    score => Inf,
    value => [],
  );

  prepare_words(@words, $width, ->($path) {
    combine($path, ->($combination) {
      my $score = 0;

      for $combination[0..*-2] -> $line {
        $score += ($width - $line.chars)**2;
      }

      if $score < %best<score> {
        %best<score> = $score;
        %best<value> = [|$combination];
      }
    })
  });
  return %best<value>.join("\n");
}

# [!] USAGE EXAMPLES [!] #
my $text = "aaa bb cc ddddd";
say smart_wrap($text, 6);

say '-' x 80;

$text = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';
say smart_wrap($text, 20);

say '-' x 80;

$text = "Lorem ipsum dolor ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ amet, consectetur adipiscing elit.";
say smart_wrap($text, 20);

say '-' x 80;

$text = 'As shown in the above phases (or steps), the algorithm does many useless transformations';
say smart_wrap($text, 20);

say '-' x 80;
