#!/usr/bin/perl
use strict;
use warnings;
#Title and description
#Data import utility for Clifton Call Centre.
#Loads data into the database to add to the number of records available for calling.

#At this stage the CSV needs to be formatted precisely to allow import, a later
#upgrade will allow for picking specific fields out of a larger file or in a different
#order

#No column headers
#Columns in following order
#Company name
#Address 1
#Address 2
#Town
#County
#Postcode
#Phone1
#Title
#First name
#Surname
#Email

#Module imports
use File::HomeDir; #Used to locate the user's home folder
use DBI; #Database access module
use Text::CSV_XS; #For loading the csv data file

#Initialse variables
my $home = File::HomeDir->my_home;
my $dbfile = $home . "/.ccc/ccc.db";

my @fields; #For csv

my $file = $ARGV[0] or die "Need to get CSV file on the command line\n"; #For csv
my @data; #For csv
my $donotcall = 0; #Used to set the donotcall database field

###Database access variables
my $dsn      = "dbi:SQLite:dbname=$dbfile";
my $user     = "";
my $password = "";
###End of database vars

#Subs

#Main Program
#Connect to database
my $dbh = DBI->connect($dsn, $user, $password, {
   PrintError       => 0,
   RaiseError       => 1,
   AutoCommit       => 1,
   FetchHashKeyName => 'NAME_lc',
});

#Load data from CSV one line at a time
open(my $fh, '<', $file) or die "Can't read file '$file' [$!]\n";
while (my $line = <$fh>) {
    chomp $line;
    my @fields = split(/,/, $line);
    push @data, \@fields;
    print "$fields[0] -- $fields[8] $fields[9]\n";
    $dbh->do('INSERT INTO records (business, address1, address2, town, county, postcode, phone1, phone2, title, firstname, surname, email, donotcall) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
    undef,
    $fields[0], $fields[1], $fields[2], $fields[3], $fields[4], $fields[5], $fields[6], $fields[7], $fields[8], $fields[9], $fields[10], $fields[11], $donotcall);
}

#$dbh->do('INSERT INTO people (business, address1, address2, town, county, postcode, phone1, phone2, title, firstname, surname, email, donotcall) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
#  undef,
#  $fields[0], $fields[1], $fields[2], $fields[3], $fields[4], $fields[5], $fields[6], $fields[7], $fields[8], $fields[9], $fields[10], $donotcall);

$dbh->disconnect;

#Temporary code to print read data. This will be removed when the database routines are added.
print "\n";
