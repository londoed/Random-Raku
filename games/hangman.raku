#######################################
############### HANGMAN ###############
############# by @londoed  ############
#######################################

unless @*ARGV[0] && @*ARGV[0].IO.f {
  say "[!] USAGE: raku hangman.raku <wordfile.txt>\n\n";
  exit;
}

my @words = slurp(@*ARGV[0]);
my $mystery_word = @words[(0..@words.elems).rand].chomp;
my Array @solution .= new($mystery_word.chars, "-");
my @guessed;
my $steps = 6;

while $steps > 0 {
  say "\n\n[+] You have $steps guesses left";
  say "\n\nGuessed: @guessed";
  say "\n\nWord: @solution";

  my $guess = prompt("[*] Enter a letter or guess the word: ").lc.chomp;

  if $guess eq $mystery_word.Str {
    say "[+] You have been pardoned!";
    exit;
  }

  if $guess == any(@guessed) {
    say "[-] You have already guessed that letter. Try again...";
    next;
  } elsif $guess == any($mystery_word) {
    say "[+] The letter was found!"
    for $mystery_word.kv -> $x {
      if $mystery_word[$x] eq $guess {
        @solution[$x] = $guess;
      }
    }
  } else {
    say "[-] Sorry, that letter is not correct...";
  }
  @guessed.push($guess);
  $steps--;
}

say "\n\n[-] Sorry, you were HANGED!!!";
say "The word was: $mystery_word";
