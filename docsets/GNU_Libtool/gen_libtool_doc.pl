#!/usr/bin/perl -w

use strict;

use local::lib;
use File::Basename qw(basename);
use DBD::SQLite;

my %type_map = (
		"Function" => "Function",
		"Special Form" => "Function",
		"Variable" => "Variable",
		"Command" => "Command",
		"User Option" => "Option",
		"Macro" => "Macro",
		"Constant" => "Constant",
		"Prefix Command" => "Command",
		"Data Type" => "Type",
		"Function Type" => "Type",
		"Type" => "Type"
	       );


my $dbh = DBI->connect("dbi:SQLite:uri=file:$ARGV[0]/docSet.dsidx",
		       undef, undef, { AutoCommit => 0 }
		      );

$dbh->do("DROP TABLE IF EXISTS searchIndex;");
$dbh->do(qq/CREATE TABLE searchIndex(id INTEGER PRIMARY KEY,
            name TEXT, type TEXT, path TEXT);/);
$dbh->do(qq/CREATE UNIQUE INDEX anchor ON searchIndex (name, type, path);/);

my $stmt = $dbh->prepare(qq/INSERT OR IGNORE INTO searchIndex(name, type, path) 
                           VALUES (?,?,?);/);
my $doc_id = "libtool";

shift;
while (<>) {
  my $file = basename($ARGV);
  if ($file eq "index.html") {
    if (m!<tr><td><a href="([^\"]+)"[^>]*>([^<]+)</a>!) {
      $stmt->execute($2, "Guide", "$doc_id/$1");
    }
  } elsif (m!<dt><a name="([^\"]+)"></a>([^:]+): <strong>([^<]+)!) {
    # print("$3,$type_map{$2},$file#$1\n");
    $stmt->execute($3, $type_map{$2}, "$doc_id/$file#$1");
  } elsif (m!<dt><a name="([^\"]+)"></a>([^:]+): <em>.*</em> <strong>([^<]+)!) {
    print("$3,$2,$file#$1\n");
    $stmt->execute($3, $type_map{$2}, "$doc_id/$file#$1");
  }
}


$dbh->commit();
$dbh->disconnect();
