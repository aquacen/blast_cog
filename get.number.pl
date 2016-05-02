#!/usr/bin/perl

use strict;

my $file_fsa = $ARGV[0];
my $file_result = $ARGV[1];
my $file_detail = $ARGV[2];
my $file_cogfun = $ARGV[3];

open(Ffun, "$file_cogfun") || die "Can't open input file '$file_cogfun'\n";
my @funlist = ();
while (<Ffun>) {
    chomp;
    
    my @items = split("\t", $_);
    push(@funlist,\@items);
}
close(Ffun);

open(Fdet, "$file_detail") || die "Can't open input file '$file_detail'\n";
my %count;
while (<Fdet>) {
    chomp;
    
    my @items = split("\t", $_);
    my @it = split("", @items[2]);
    
    foreach my $i (@it){
	if (!exists $count{$i}){
	    $count{$i} = 0;
	}
	$count{$i}++;
    }
}
close(Fdet);

open(FSA, "$file_fsa") || die "Can't open input file '$file_fsa'\n";
my @allloci;
while(<FSA>){
    if (/\>/) {
	my $locus = substr($_, 1, index($_," ")-1);
	push(@allloci, $locus);
    }
}
close(FSA);

open(FRESUL, "$file_result") || die "Can't open input file '$file_fsa'\n";
my %lociwb;
while(<FRESUL>){
    my @res = split("\t", $_ );
    my $lres = $res[0];
    $lociwb{$lres} = "true";
}
close(FRESUL);


my %count2;
foreach my $key (keys @funlist){
    my @local = @{@funlist[$key]};
    print $count{@local[0]}, "\t";
    print join("\t", @local),"\n";
    
    if (!exists $count2{@local[2]}){
	$count2{@local[2]} = 0;
    }
    #print $count{@local[0]},@local[2],"\n";
    $count2{@local[2]} += int($count{@local[0]});
}

my $notfound = 0;
foreach my $locus (@allloci){
    if (!exists $lociwb{$locus}){
	$notfound = $notfound + 1;
    }
}
print $notfound,"\t-\tNot in COG\n";


print "\n";
print "1. INFORMATION STORAGE AND PROCESSING\t",$count2{1},"\n";
print "2. CELLULAR PROCESSES AND SIGNALING\t",$count2{2},"\n";
print "3. METABOLISM\t",$count2{3},"\n";
print "4. POORLY CHARACTERIZED\t",$count2{4},"\n";
print "5. NOT IN COG\t",$notfound,"\n";