#! /usr/bin/perl
use 5.013;    # 5.014
use strict;
use warnings;
use Text::CSV_XS;

# my $csv = Text::CSV_XS->new( { binary => 1 } )    # should set binary attribute.
    # or die "Cannot use CSV: " . Text::CSV_XS->error_diag();

# Windows EOL marker
# $csv->eol("\r\n");

# Linux EOL marker
# $csv->eol ("\n");

# $csv->empty_is_undef(1);

my $fn = $ARGV[0];

my $column_number = $ARGV[1];

open( my $fh, "<", $fn ) or die "ERROR: Problem reading $fn\n";

# print "Reading column headers...";
# $csv->getline($fh);

my %counts;
my %names;

our $csv = Text::CSV_XS->new ({ binary => 1, auto_diag => 1 });
 open $fh, "<", $fn or die "$fn: $!";
 # get only the 4th column

my @column = map { $_->[$column_number] } @{$csv->getline_all ($fh)};
	close $fh or die "file.csv: $!";

my $str;
my $shrunk;

for $str ( @column ) {

    $str =~ s/ +/ /ig;
    $shrunk = lc($str);
    $shrunk =~ s/\W//g;

    if ( defined $counts{$shrunk}){
    	$counts{$shrunk}++;
    } else {
    	$counts{$shrunk} = 1;
    	$names{$shrunk} = $str;
    }
}

for ( keys(%counts) ) {
	print "$names{$_}: $counts{$_}\n";
}