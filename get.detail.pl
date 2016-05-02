#!/usr/bin/perl

use strict;

my $file_blastr = $ARGV[0];
my $file_cogcsv = $ARGV[1];
my $file_cognam = $ARGV[2];


open(Fcsv, "$file_cogcsv") || die "Can't open input file '$file_cogcsv'\n";
my %csvlist = {};
while (<Fcsv>) {
    chomp;
    
    my @items = split(",", $_);
    $csvlist{$items[0]} = \@items;
}
close(Fcsv);

open(Fnam, "$file_cognam") || die "Can't open input file '$file_cognam'\n";
my %nameslist = {};
while (<Fnam>) {
    chomp;
    
    my @items = split("\t", $_);
    $nameslist{$items[0]} = \@items;
}
close(Fnam);

open(Fres, "$file_blastr") || die "Can't open input file '$file_blastr'\n";
while (<Fres>) {
    chomp;
    
    my @items = split("\t", $_);
    print $items[0], "\t";
    
    my $gis = substr($items[1], index($items[1],"gi|")+3 );
    $gis = substr($gis, 0, index($gis, "|"));
    #print "$gis";
    my @local = @{$csvlist{$gis}};
    my $cogid = @local[6];
    if ( exists $nameslist{$cogid} ){
	my @local2 = @{$nameslist{$cogid}};
	print join("\t", @local2);
    } else {
    }
    print "\n";
}
close(Fres);
