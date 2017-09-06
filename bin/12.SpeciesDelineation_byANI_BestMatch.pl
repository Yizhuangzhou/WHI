#!usr/bin/perl -w
use strict;
die "perl $0 [ANI_WHI_PSG.xls][output]" unless @ARGV == 2;
open(IF,$ARGV[0])||die;
open(OUT,">$ARGV[1]")||die;
my %id;
my %max;
<IF>;
while(<IF>){
	chomp;
	my @a=split /\t/;
	if(!$id{$a[1]}){
		$id{$a[1]}=$a[0];
		$max{$a[1]}=$a[4];
	}
	elsif($a[4] > $max{$a[1]}){
		$id{$a[1]}=$a[0];
		$max{$a[1]}=$a[4];
	}
}
close IF;
open(IF,$ARGV[0])||die;
<IF>;
print OUT "Ref\tQuery\tANI\tWHI\tPSG\n";
while(<IF>){
	chomp;
	my @a = split /\t/;
	if($id{$a[1]} eq $a[0]){
		if($a[4] >= 95){
			print OUT "$a[0]\t$a[1]\t$a[4]\t$a[5]\t$a[6]\n";
		}
	}
}
close IF;
close OUT;
