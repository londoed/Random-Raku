#!/usr/bin/env perl6

###########################################
############### MODIFY USER ###############
###########################################

my @mod_user;
my @add_user;

my $user_name = prompt("[*] Enter the username to modify ").chomp;

my $g_result = prompt("[*] Would you like to add this account to any groups [Y/n]?").chomp;

if $g_result.lc == "y" {
  my $g_name = prompt("\n[*] Enter the primary group: ").chomp;
  my @mod_user = "-g $g_name";

  while $g_name {
    $g_name = prompt("\n[*] Enter next group: (type 'exit' when done)").chomp;
    break if $g_name == "exit";
    my @add_user.push("-G $g_name");
  }
}

my $s_result = prompt("[*] Would you like to change the starting shell [Y/n]?").chomp;

if $s_result.lc == "y" {
  say "\n\n\n[1] Bourne Again Shell (bash)";
  say "[2] Korn Shell (ksh)";
  say "[3] Z Shell (zsh)";
  say "[4] C Shell (csh)";

  my $sh_num = prompt("[*] Which shell would you like to use? ").chomp.Int;
  my $shell = case $sh_num
    when 1 {
      '/bin/bash';
    } when 2 {
      '/bin/ksh';
    } when 3 {
      '/bin/zsh';
    } when 4 {
      '/bin/csh';
    } default {
      '/bin/bash';
    }
  }
  my @mod_user.push("-s $shell");
}

my $d_result = prompt("[*] Would you like to change the home directory [Y/n]? ").chomp;

if $d_result.lc == "y" {
  my $dir = prompt("[*] Enter new director: ").chomp;
  @mod_user.push("-d $dir");
}

my $l_result = prompt("[*] Would you like to change the login name [Y/n]? ").chomp;

if $l_result.lc == "y" {
  my $name = prompt("[*] Enter new login name: ").chomp;
  @mod_user.push("-l $name");
}

if ("usermod @mod_user") {
  say "\n\n[+] Successfully modified: $user_name\n";
} else {
  say "\n\n[-] Unable to modify: $user_name\n";
}
