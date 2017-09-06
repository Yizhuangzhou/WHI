#!usr/bin/perl -w
use strict;
die "perl $0 [WHI_validate_detail.xls][ANI_validate_detail.xls][Total query number][output]" unless @ARGV == 4;
my $total=$ARGV[2];
open(OUT,">$ARGV[3]")||die;
my %hash;
my %sum;
&ReadFile($ARGV[0],"WHI");
&ReadFile($ARGV[1],"ANI");
my @method=qw(WHI ANI);
print OUT"Method\tAssigned\tUnassigned\tRecall (%)\tConsistent\tInconsistent\tPrecision (%)\tF-score (%)\n";
my $precision;
foreach my $k(@method){
	my $unassigned=$total-$sum{$k};
	my $recall=$sum{$k}*100/$total;
	print OUT "$k\t$sum{$k}\t$unassigned";
	printf OUT "\t%.2f",$recall;
	foreach(qw(Intra Inter)){
		if($hash{$k}{$_}){
			print OUT "\t$hash{$k}{$_}";
		}
		else{
			print OUT "\t0";
		}
	}
	if($hash{$k}{"Intra"}){
		$precision=$hash{$k}{"Intra"}*100/$sum{$k};
	}
	else{
		$precision=0;
	}
	my $Fscore=2*$recall*$precision/($recall+$precision);
	printf OUT "\t%.2f\t%.2f\n",$precision,$Fscore;
}

close OUT;


sub ReadFile{
	my ($file,$method)=@_;
	open(TMP,$file)||die;
	<TMP>;
	while(<TMP>){
		chomp;
		my @a=split /\t/;
		$hash{$method}{$a[7]}++;
		$sum{$method}++;
	}
	close TMP;
}
