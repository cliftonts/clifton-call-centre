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
use DBI;

#Initialse variables
my $dir = ".ccc";
my $home = File::HomeDir->my_home;
my $dbfile = $home . "/.ccc/ccc.db";
#$home = $home . "/.ccc/settings.cfg";

#Database connection vars
my $dsn      = "dbi:SQLite:dbname=$dbfile";
my $user     = "";
my $password = "";
my $dbh = DBI->connect($dsn, $user, $password, {
   PrintError       => 0,
   RaiseError       => 1,
   AutoCommit       => 1,
   FetchHashKeyName => 'NAME_lc',
});
#End of database vars

#Subs

#Main Program

my $sql = <<'END_SQL';
CREATE TABLE records (
  id       INTEGER PRIMARY KEY,
  business    VARCHAR(100),
  address1    VARCHAR(100),
  address2    VARCHAR(100),
  town        VARCHAR(100),
  county      VARCHAR(100),
  postcode    VARCHAR(100),
  phone1      VARCHAR(100),
  phone2      VARCHAR(100),
  title       VARCHAR(100),
  firstname   VARCHAR(100),
  surname     VARCHAR(100),
  email       VARCHAR(100),
  donotcall   VARCHAR(1)
)
END_SQL
$dbh->do($sql);

$sql = <<'END_SQL';
CREATE TABLE notes (
  id       INTEGER PRIMARY KEY,
  recid    INTEGER,
  response VARCHAR(100),
  comment  VARCHAR(100)
)
END_SQL
$dbh->do($sql);

$sql = <<'END_SQL';
CREATE TABLE callbacks (
  id            INTEGER PRIMARY KEY,
  redid         INTEGER,
  lastcalled    DATETIME,
  callback      DATETIME
)
END_SQL
$dbh->do($sql); 

$dbh->disconnect;
