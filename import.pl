#!/usr/bin/perl
use strict;
use warnings;
#Title and description
#Data import utility for Clifton Call Centre.
#Loads data into the database to add to the number of records available for calling.

#Module imports
use File::HomeDir;

#Initialse variables
my $home = File::HomeDir->my_home;
$home = $home . "/.ccc/settings.cfg";
my $pass;
my $uname;
my $dbname;

#Subs

#Main Program

#Open settings file and read data. Split header titles from data
open (MYFILE, $home); 
while (<MYFILE>) { 
   chomp; 
   print substr($_, 0, 7);
   if (substr($_, 0, 6) eq 'PASS: ') {
      $pass = substr($_, 6, (length $_)-6);
   }
   if (substr($_, 0, 7) eq 'UNAME: ') {
      $uname = substr($_, 7, (length $_)-7);
   }
   if (substr($_, 0, 8) eq 'DBNAME: ') {
      $dbname = substr($_, 8, (length $_)-8);
   }
} 
close (MYFILE);

#Temporary code to print read data. This will be removed when the database routines are added.
print "\n";
print $pass."\n";
print $uname."\n";
print $dbname."\n";
