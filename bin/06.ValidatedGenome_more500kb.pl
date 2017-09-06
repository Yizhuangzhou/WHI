#!usr/bin/perl -w
use strict;
die "perl $0 [ValidatedSpecies_GenomeInfo.xls][output]" unless @ARGV== 2;
open(IF,$ARGV[0])||die;
open(OUT,">$ARGV[1]")||die;
while(<IF>){
	chomp;
	my @a=split /\t/;
	if($a[4] eq "Complete Genome" || $a[5] >= 500000){
		print OUT "$_\n";
	}
}
close IF;
close OUT;
