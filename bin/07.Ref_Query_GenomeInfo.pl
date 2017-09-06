#!usr/bin/perl -w
use strict;
die "perl $0 [ValidatedGenome_more500kb.xls][Data/Type_strain.xls][output|Ref][output|Query]" unless @ARGV==4;
open(IF,$ARGV[0])||die;
open(IN,$ARGV[1])||die;
open(OUT,">$ARGV[2]")||die;
open(OF,">$ARGV[3]")||die;
my %hash;
while(<IN>){
	chomp;
	my @a=split /\t/;
	my @strain=split /\s*\=\s*/,$a[1];
	foreach(@strain){
		$hash{$a[0]}{$_}=1;
	}
}
close IN;
my %status=();
my %type;
my %size;
while(<IF>){
	chomp;
	my @a=split /\t/;
		$status{$a[0]}=$a[4];
		my @strain=split /\s*[\;\,]\s*/,$a[3];
		my $flag=0;
		foreach(@strain){
			if($hash{$a[2]}{$_}){
				$flag=1;
				last;
			}
		}
		if($flag == 1){
			push @{$type{$a[1]}{"Type"}},$a[0]
		}
		else{
			push @{$type{$a[1]}{"unType"}},$a[0];
		}
		$size{$a[0]}=$a[5];
}
close IF;
my %strain;
foreach my $k1(keys %type){
	my $flag= 0;
	if($type{$k1}{"Type"}){
		my @strain=@{$type{$k1}{"Type"}};
		@strain=sort {$size{$b} <=> $size{$a}} @strain;
		foreach my $strain(@strain){
			if($status{$strain} eq "Complete Genome"){
				$strain{$strain}="Type";
				$flag = 1;
				last;
			}
		}
		if($flag  == 0){
			$flag = 1;
			$strain{$strain[0]}="Type";
		}
	}
	if($flag == 0){
		if($type{$k1}{"unType"}){
			my @strain=@{$type{$k1}{"unType"}};
			@strain=sort {$size{$b} <=> $size{$a}} @strain;
			foreach my $strain(@strain){
				if($status{$strain} eq "Complete Genome"){
					$strain{$strain}="unType";
					$flag = 1;
					last
				}
			}
			if($flag == 0){
				$flag = 1;
				$strain{$strain[0]}="unType";
			}
		}
	}
}
open(IF,$ARGV[0])||die;
while(<IF>){
	chomp;
	my @a=split /\t/;
		if($strain{$a[0]}){
			print OUT "$_\t$strain{$a[0]}\n";
		}
		else{	
			print OF "$_\n";
		}
}
close IF;
close OUT;
close OF;
