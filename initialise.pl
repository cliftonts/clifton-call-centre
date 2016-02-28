#!/usr/bin/perl
use strict;
use warnings;
#Title and description
#Initialisation program for Clifton Call Centre.
#This utility checks for the existance of the settings file for holding the database
#username and password and for any other settings.
#If not found the file is then created, asking the user for the database details.

#Module imports
use File::HomeDir;

#Initialse variables
my $dir = ".ccc";

#Subs

#Main Program

my $home = File::HomeDir->my_home;
$home = $home . "/.ccc/settings.cfg";

if (-e $home)
{
   print "Database already initialised\n";
} else {
   chdir;
   mkdir $dir;

#Input DB details
   print "Enter database name:- ";
   my $dbname = <STDIN>;
   $dbname =~ s/[\n\r\f\t]//g;
   substr($dbname, 0, 0) = 'DBNAME: ';
   print "Enter username:- ";
   my $uname = <STDIN>;
   $uname =~ s/[\n\r\f\t]//g;
   substr($uname, 0, 0) = 'UNAME: ';
   print "Enter password:- ";
   my $pass = <STDIN>;
   $pass =~ s/[\n\r\f\t]//g;
   substr($pass, 0, 0) = 'PASS: ';

#Write data to file
   my $filename = '.ccc/settings.cfg';
   open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";
   print $fh "$dbname\n";
   print $fh "$uname\n";
   print $fh "$pass\n";
   close $fh;
}
