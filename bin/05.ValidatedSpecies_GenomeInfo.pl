#!usr/bin/perl -w
use strict;
die "perl $0 [Validated_SpeciesName.xls][Total_Chrom_Plasmid.list][output]" unless @ARGV==3;
open(IF,$ARGV[0])||die;
open(OUT,">$ARGV[2]")||die;
my %hash;
while(<IF>){
	chomp;
	my @a=split /\t/;
	$hash{$a[0]}=$a[1];
}
close IF;
&ValidatedGenome($ARGV[1]);
close OUT;
sub ValidatedGenome{
	my ($file)=@_;
	open(TMP,$file)||die;
	while(<TMP>){
		chomp;
		my @a=split /\t/;
		if($hash{$a[1]}){
			print OUT "$a[0]\t$a[1]\t$hash{$a[1]}\t$a[3]\t$a[4]\t$a[5]\t$a[6]\t$a[7]\n";
		}
	}
	close TMP;
}
