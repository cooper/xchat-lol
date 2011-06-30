#!/usr/bin/perl
# Copyright (c) 2011, Mitchell Cooper

use warnings;
use strict;
use Xchat ':all';

my $cap = 0;
my $fcap = 0;
my @colors = qw[05 04 07 08 09 03 11 10 12 02 06 13 15 14];

Xchat::hook_command('lol', 'lol');
Xchat::hook_command('lolbow', 'lolbow');
Xchat::hook_command('loler', 'loler');
Xchat::hook_command('lolerbow', 'lolerbow');

sub lol {
    my $msg = $_[1][1];
    Xchat::command('SAY '.str2lol($msg));
}

sub loler {
    my $msg = $_[1][1];
    Xchat::command('SAY '.str2loler($msg));
}

sub lolbow {
    my $msg = $_[1][1];
    Xchat::command('SAY '.str2rainbow(str2lol($msg)));
}

sub lolerbow {
    my $msg = $_[1][1];
    Xchat::command('SAY '.str2rainbow(str2loler($msg)));
}

sub str2rainbow {
    my ($msg, $str) = (shift, '');
    foreach my $l (split //, $msg) {
        if (uc $l eq $l) {
            $l = "\2$l\2"
        }
        $l = "\x03".($colors[rand @colors]).$l;
        $str .= $l
    } 
    return $str
}

sub str2lol {
    my ($msg, $str) = (shift, '');
    $fcap = ($fcap ? 0 : 1);
    $cap  = $fcap;
    foreach my $l (split //, $msg) {
        $str .= $l, next if $l =~ m/\W/;
        if ($cap) {
            $cap = 0
        }
        else {
            $cap = 1
        }
        $str .= ($cap ? uc $l : lc $l)
    }
    return $str
}

sub str2loler {
    my ($msg, $str, $y) = (shift, '', 0);
    foreach my $l (split //, $msg) {
        $str .= $l, next if $l =~ m/\W/;
        if (rand 2 > 1) {
            $y = 1
        }
        else {
            $y = 0
        }
        $str .= ($y ? uc $l : lc $l)
    }
    return $str
}
