#!/usr/bin/env perl6

###########################################################
############### CALCULATE LOAN PAYMENT RATE ###############
###########################################################

my $loan = prompt("[*] Enter loan amount: ").chomp.Int;
my $time = prompt("[*] Enter length of time in months: ").chomp.Int;
my $rate = prompt("[*] Enter interest rate: ").chomp.Rat / 100;

my $i = (1 + $rate / 12)**(12 / 12) - 1;
my $annuity = (1 - (1 / (1 + $i))**$time) / i;

my $payment = $loan / $annuity;
say "$payment per month";
