#!usr/bin/perl -w
use strict;
die "perl $0 [DDH_GenomeInfo.xls][DDH_Database.xls][outdir][output|sh][output|Delta.list]" unless @ARGV == 5;
open(IF,$ARGV[0])||die;
open(IN,$ARGV[1])||die;
my $dir = $ARGV[2];
mkdir $dir unless (-e $dir);
open(OUT,">$ARGV[3]")||die;
open(OF,">$ARGV[4]")||die;
my %flag;
while(<IF>){
	chomp;
	my @a=split /\t/;
	$flag{$a[0]}=$a[6];
}
close IF;
<IN>;
while(<IN>){
	chomp;
	my @a=split /\t/;
	my $prefix="$dir/$a[0]\_$a[3]";
	if(! -s "$prefix\.delta"){
		if(!$flag{$a[0]}){
			print STDERR "$a[0]\n";
		}
		if(!$flag{$a[3]}){
			print STDERR "$a[3]\n";
		}
		if(! -s "$prefix\.delta"){
			print OUT "/Bailab2/PROJECT/zhouyzh/software/MUMmer3.23/nucmer --maxmatch -p $prefix $flag{$a[0]} $flag{$a[3]}\n";
		}
		print OF "$prefix\.delta\n";
	}
}
close IN;
close OUT;
