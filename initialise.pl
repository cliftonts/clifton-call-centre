#!/usr/bin/perl
use strict;
use warnings;
#Title and description
#Initialisation program for Clifton Call Centre.
#This utility checks for the existance of the settings file for holding the database
#username and password and for any other settings.
#If not found the file is then created, asking the user for the database details.

#Module imports
use Crypt::PBKDF2;

#Initialse variables
my $dir = ".ccc";

#Subs

#Main Program

if (-e "~/.ccc/settings.cfg")
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

#Generate secure password for storage
   my $pbkdf2 = Crypt::PBKDF2->new(
   	hash_class => 'HMACSHA2',
	hash_args => {
		sha_size => 512,
	},
    salt_len => 10,
   );
 
   my $hash = $pbkdf2->generate($pass);
   substr($hash, 0, 0) = 'PASS: ';

#Write data to file
   my $filename = '.ccc/settings.cfg';
   open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";
   print $fh "$dbname\n";
   print $fh "$uname\n";
   print $fh "$hash\n";
   close $fh;
}
