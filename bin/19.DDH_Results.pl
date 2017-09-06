#!usr/bin/perl -w
use strict;
die "perl $0 [DDH_Database.xls][DDH_ANI_WHI_PSG.xls][DDH_TETRA.xls][output]" unless @ARGV == 4;
open(DB,$ARGV[0])||die;
open(IF,$ARGV[1])||die;
open(IN,$ARGV[2])||die;
open(OUT,">$ARGV[3]")||die;
my %hash;
<IF>;
while(<IF>){
	chomp;
	my @a=split /\t/;
	$hash{"$a[0]\t$a[1]"}="$a[4]\t$a[5]\t$a[6]";
}
close IF;
my %TETRA;
while(<IN>){
	chomp;
	my @a=split /\t/;
	$TETRA{"$a[0]\t$a[1]"}=$a[2];
}
close IN;
<DB>;
print OUT "ID1\tSP1\tName1\tID2\tSP2\tName2\tDDH (%)\tType\t\tANI (%)\tWHI (%)\tPSG (%)\tTETRA\n";
while(<DB>){
	chomp;
	my @a=split /\t/;
	if($hash{"$a[0]\t$a[3]"}){
		print OUT "$_\t",$hash{"$a[0]\t$a[3]"},"\t",$TETRA{"$a[0]\t$a[3]"},"\n";
	}
	else{
		print STDERR "$a[0]\t$a[3]\n";
	}
}
close DB;
close OUT;
