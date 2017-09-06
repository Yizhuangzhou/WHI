#!usr/bin/perl -w
use strict;
die "perl $0 [Ref_GenomeInfo.xls][Query_GenomeInfo.xls][Pairs_byTETRA.xls][outdir][output|sh][output|Delta.list]" unless @ARGV == 6;
open(IF,$ARGV[0])||die;
open(IN,$ARGV[1])||die;
open(TMP,$ARGV[2])||die;
my $dir = $ARGV[3];
mkdir $dir unless (-e $dir);
open(OUT,">$ARGV[4]")||die;
open(OF,">$ARGV[5]")||die;
my %hash;
while(<IF>){
	chomp;
	my @a=split /\t/;
	$hash{$a[0]}=$a[6];
}
close IF;
while(<IN>){
	chomp;
	my @a=split /\t/;
	$hash{$a[0]}=$a[6];
}
close IN;
while(<TMP>){
	chomp;
	my @a=split /\t/;
	my $prefix="$dir/$a[1]\_$a[0]";
	print OF "$prefix\.delta\n";
	if(! -s "$prefix\.delta"){
		print OUT "/Bailab2/PROJECT/zhouyzh/software/MUMmer3.23/nucmer --maxmatch -p $prefix $hash{$a[1]} $hash{$a[0]}\n";
	}
}
close TMP;
close OUT;
close OF;
