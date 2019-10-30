#!/usr/bin/env perl6

############################################
############### ADD NEW USER ###############
############################################

my $user_name = prompt("[*] Enter a new username ");

my $g_name = prompt("[*] Enter primary group: ");
my $add_user = "-g $g_name";

while $g_name {
  my $g_name = "\n[*] Enter next group (return blank line when finished) ";
  break if $g_name eq "";
  $add_user + " -G $g_name";
}

say "[+] Which sell would you like to use? ";
say "\n\n\n[1] Bourne Again Shell (bash)";
say "[2] Korn Shell (ksh)";
say "[3] Z Shell (zsh)";
say "[4] C Shell (csh)";

my $sh_num = prompt("[*] Please choose a shell (default bash)" ).Int;
my $shell;

given $sh_num {
  when 1 { $shell = '/bin/bash' }
  when 2 { $shell = '/bin/ksh' }
  when 3 { $shell = '/bin/zsh' }
  when 4 { $shell = '/bin/csh' }
  default { $shell = 'bin/bash' }
}

$add_user + " -s $shell";
$add_user + " -d /home/$user_name";
$add_user + " -m $user_name";

if shell(useradd $add_user) {
  say "\n\n[+] Successfully added: $user_name";
} else {
  say "\n\n[-] Unable to add: $user_name";
}
