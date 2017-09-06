#!usr/bin/perl -w
use strict;
die "perl $0 [ANI_WHI_PSG.xls][Ref_GenomeInfo.xls][Query_GenomeInfo.xls][output|detail][output|stat]" unless @ARGV == 5;
open(IF,$ARGV[0])||die;
open(IN,$ARGV[1])||die;
open(TMP,$ARGV[2])||die;
open(OUT,">$ARGV[3]")||die;
open(OF,">$ARGV[4]")||die;
my %spid;
while(<IN>){
	chomp;
	my @a=split /\t/;
	$spid{$a[0]}=$a[1];
}
close IN;
while(<TMP>){
	chomp;
	my @a=split /\t/;
	$spid{$a[0]}=$a[1];
}
close TMP;
my %id;
my %max;
my %tax;
<IF>;
while(<IF>){
	chomp;
	my @a=split /\t/;
	if($a[4] >= 95){
		if($spid{$a[0]} == $spid{$a[1]}){
			$tax{$a[1]}=$a[0];
		}
		if(!$id{$a[1]}){
			$id{$a[1]}=$a[0];
			$max{$a[1]}=$a[4];
		}
		elsif($a[4] > $max{$a[1]}){
			$id{$a[1]}=$a[0];
			$max{$a[1]}=$a[4];
		}
	}
}
close IF;
open(IF,$ARGV[0])||die;
<IF>;
my %stat;
print OUT "ID1\tID2\tANI\tWHI\tPSG\tSP1\tSP2\tType\tClass\n";
my $PSG="";
my $size="";
while(<IF>){
	chomp;
	my @a=split /\t/;
	if($id{$a[1]}){
		if($tax{$a[1]}){
			if($tax{$a[1]} eq $a[0]){
				my $type="Intra";
				print OUT "$a[0]\t$a[1]\t$a[4]\t$a[5]\t$a[6]\t$spid{$a[0]}\t$spid{$a[1]}\t$type\t";
				if($a[6] <70){
					$stat{"<70"}{"$type"}++;
					print OUT "<70\n";
				}
				else{
					$stat{">=70"}{"$type"}++;
					print OUT ">=70\n";
				}
			}
		}
		elsif($id{$a[1]} eq $a[0]){
			my $type="Inter";
			print OUT "$a[0]\t$a[1]\t$a[4]\t$a[5]\t$a[6]\t$spid{$a[0]}\t$spid{$a[1]}\t$type\t";
			if($a[6] <70){
				$stat{"<70"}{"$type"}++;
				print OUT "<70\n";
			}
			else{
				$stat{">=70"}{"$type"}++;
				print OUT ">=70\n";
			}
		}
	}
}
close IF;
close OUT;
my @rank=qw(Intra Inter);
print OF join("\t",@rank),"\n";
foreach my $k(sort {$a cmp $b} keys %stat){
	print OF "$k";
	foreach(@rank){
		if($stat{$k}{$_}){
			print OF "\t$stat{$k}{$_}";
		}
		else{
			print OF "\t0";
		}
	}
	print OF "\n";
}
close OF;

