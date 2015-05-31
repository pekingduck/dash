#!/usr/bin/perl -w

use strict;

use local::lib;
use File::Basename qw(basename);
use DBD::SQLite;
use HTML::Entities qw(decode_entities);

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
		"Type" => "Type",
		"Autoconf Macro" => "Macro",
		"C Enum" => "Enum",
		"C Function" => "Function",
		"C Hook" => "Hook",
		"C Macro" => "Macro",
		"C Procedure" => "Procedure",
		"C Type" => "Type",
		"C Variable" => "Variable",
		"C function" => "Function",
		"Condition Type" => "Type",
		"Deprecated Scheme Procedure" => "Procedure",
		# "External Representation" => "External Representation",
		# "HTTP Header" => "HTTP Header",
		# "HTTP Header Type" => "HTTP Header Type",
		# "HTTP Implementation" => "HTTP Implementation",
		"Instruction" => "Instruction",
		"REPL Command" => "Command",
		"Scheme Hook" => " Hook",
		"Scheme Macro" => "Macro",
		"Scheme Parameter" => "Parameter",
		"Scheme Procedure" => "Procedure",
		"Scheme Procedures" => "Procedure",
		"Scheme Syntax" => "Macro",
		"Scheme Variable" => "Variable",
		"Scheme procedure" => "Procedure",
		"Syntax" => "Macro",
		"class option" => "Option",
		#"generic" => "generic",
		"library syntax" => "Macro",
		"macro" => "Macro",
		"method" => "Method",
		#"primitive generic" => "primitive generic",
		"primitive procedure" => "Procedure",
		"procedure" => "Procedure",
		"slot option" => "Option",
		"syntax" => "Syntax"
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
my $doc_id = "guile";

shift;
while (<>) {
  my $file = basename($ARGV);
  if ($file eq "index.html") {
    if (m!<tr><td><a href="([^\"]+)"[^>]*>([^<]+)</a>!) {
      $stmt->execute(decode_entities($2), "Guide", "$doc_id/$1");
    }
  } elsif (m!<dt><a name="([^\"]+)"></a>([^:]+): <strong>([^<]+)!) {
    # print("$3,$type_map{$2},$file#$1\n");
    if (not exists $type_map{$2}) {
      print("$2\n");
    } else {
      $stmt->execute(decode_entities($3), $type_map{$2}, "$doc_id/$file#$1");
    }
  } elsif (m!<dt><a name="([^\"]+)"></a>([^:]+): <em>.*</em> <strong>([^<]+)!) {
    if (not exists $type_map{$2}) {
      print("$2\n");
    } else {
      $stmt->execute(decode_entities($3), $type_map{$2}, "$doc_id/$file#$1");
    }
  }
}


$dbh->commit();
$dbh->disconnect();
