#!/usr/bin/perl
use strict;
use warnings;

die "perl 04.split_Chromosome_plasmid.pl [Total_Genome.list][Plasmids.ids][output|table][outdir] " unless @ARGV == 4;

open(LIST,$ARGV[0])||die;
open(ID,$ARGV[1])||die;
open(OUT,">$ARGV[2]")||die;
my $dir=$ARGV[3];
mkdir $dir unless -e $dir;
my %hash;
while(<ID>){
	chomp;
	my @a=split /\t/;
	$hash{$a[0]}=1;
	#$hash{$a[4]}=1;
}
close ID;
while(<LIST>){
	chomp;
	my @a=split /\t/;
	my $size=0;
	open(TMP,$a[-1])||die;
	my $id="";
	my %flag=();
	open(OC,">$dir/$a[0]\_chromosome.fna")||die;
	open(OP,">$dir/$a[0]\_plasmid.fna")||die;
	while(<TMP>){
		chomp;
		if(/>([^\.]+)/){
			$id=$1;
			if(/plasmid/i){
				$flag{$id}=1;
			}
			if($hash{$id} || $flag{$id}){
				print OP "$_\n";
			}
			else{
				print OC "$_\n";
			}
		}
		else{
			if($hash{$id} || $flag{$id}){
				print OP "$_\n";
			}
			else{
				print OC "$_\n";
				s/\s+$//;
				$size +=length;
			}
		}
	}
	close TMP;
	print OUT "$a[0]\t$a[1]\t$a[2]\t$a[3]\t$a[4]\t$size\t$dir/$a[0]\_chromosome.fna";
	if( ! -s "$dir/$a[0]\_plasmid.fna"){
		print OUT "\tNA\n";
		unlink "$dir/$a[0]\_plasmid.fna";
	}
	else{
		print OUT "\t$dir/$a[0]\_plasmid.fna\n";
	}
}
close LIST;
close OUT;

