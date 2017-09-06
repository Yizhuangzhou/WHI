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
	if($a[5] >= 74){
		if($spid{$a[0]} == $spid{$a[1]}){
			$tax{$a[1]}=$a[0];
		}
		if(!$id{$a[1]}){
			$id{$a[1]}=$a[0];
			$max{$a[1]}=$a[5];
		}
		elsif($a[5] > $max{$a[1]}){
			$id{$a[1]}=$a[0];
			$max{$a[1]}=$a[5];
		}
	}
}
close IF;
open(IF,$ARGV[0])||die;
<IF>;
my %stat;
print OUT "Ref\tQuery\tANI\tWHI\tPSG\tSP1\tSP2\tType\tClass\n";
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
				if($a[4] <90.5){
					$stat{"<90.5"}{"$type"}++;
					print OUT "<90.5\n";
				}
				elsif($a[4] <95){
					$stat{"<95"}{"$type"}++;
					print OUT "<95\n";
				}
				else{
					$stat{">=95"}{"$type"}++;
					print OUT ">=95 \n";
				}
			}
		}
		elsif($id{$a[1]} eq $a[0]){
			my $type="Inter";
			print OUT "$a[0]\t$a[1]\t$a[4]\t$a[5]\t$a[6]\t$spid{$a[0]}\t$spid{$a[1]}\t$type\t";
			if($a[4] <90.5){
				$stat{"<90.5"}{"$type"}++;
				print OUT "<90.5\n";
			}
			elsif($a[4] <95){
				$stat{"<95"}{"$type"}++;
				print OUT "<95\n";
			}
			else{
				$stat{">=95"}{"$type"}++;
				print OUT ">=95 \n";
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
