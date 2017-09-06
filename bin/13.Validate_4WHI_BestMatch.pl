#!usr/bin/perl -w
use strict;
die "perl $0 [SpeciesDelineation_byWHI_BestMatch.xls][Ref_GenomeInfo.xls][Query_GenomeInfo.xls][output|detail][output|stat]" unless @ARGV == 5;
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
my %stat;
my $f=<IF>;
chomp($f);
print OUT "$f\tSP1\tSP2\tType\tClass\n";
while(<IF>){
	chomp;
	my @a=split /\t/;
	my $type;
	if($spid{$a[0]} == $spid{$a[1]}){
		$type="Intra";
	}
	else{
		$type="Inter";
	}
	print OUT "$_\t$spid{$a[0]}\t$spid{$a[1]}\t$type\t";
	if($a[2] <90.5){
		$stat{"<90.5"}{"$type"}++;
		print OUT "<90.5\n";
	}
	elsif($a[2] <95){
		$stat{"<95"}{"$type"}++;
		print OUT "<95\n";
	}
	else{
		$stat{">=95"}{"$type"}++;
		print OUT ">=95 \n";
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
