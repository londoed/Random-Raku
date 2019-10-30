#############################################
############### GUESSING GAME ###############
############## by <|londoed|>  ##############
#############################################

use v6.d;
use Term::ReadKey;

say "[!] Welcome to the number-guessing game!\n\n\n";

my $level = prompt("[*] What difficulty level would you like? (low, medium, or hard) ").lc;

say "[!] Enter 'q' to QUIT\n\n\n";

my $min = 1;
my $max;

given $level {
  when "low" { $max = 10 }
  when "medium" { $max = 100 }
  when "hard" { $max = 1000 }
  default { $max = 10 }
}

say "[+] The magic number is between $min and $max\n\n";
my $magic_number = ($max + 1).rand;

my $guess = prompt("[*] Enter your guess: ");

while $guess ~~ /\d/ {
  given $guess.Int {
    when 0..$magic_number { say "[-] Too low, try again\n\n"};
    when $magic_number {
      say "\n\n[+] You guessed it!!!\nThe magic number was $magic_number\n\n\n";
      my $enter = prompt("Press the 'enter' key to continue...");
      exit if key-pressed('enter', $enter);
    }
    default { say "[-] Too high, try again\n\n"};
  }
  $guess = prompt("[*] Enter your next guess: ");
}

say "[-] Invalid entry, you lose";
exit;
