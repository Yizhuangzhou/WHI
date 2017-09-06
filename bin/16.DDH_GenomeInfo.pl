#!usr/bin/perl -w
use strict;
die "perl $0 [Total_Chrom_Plasmid.list][DDH_Database.xls][output]" unless @ARGV ==3;
open(IN,$ARGV[1])||die;
open(OUT,">$ARGV[2]")||die;
my %hash;
<IN>;
while(<IN>){
	chomp;
	my @a=split /\t/;
	$hash{$a[0]}=1;
	$hash{$a[3]}=1;
}
close IN;
&Process($ARGV[0]);
close OUT;
sub Process{
	my ($file)=@_;
	open(IF,$file)||die;
	while(<IF>){
		chomp;
		my @a=split /\t/;
		if($hash{$a[0]}){
			print OUT "$_\n";
		}
	}
	close IF;
}
