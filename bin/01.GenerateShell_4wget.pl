#!usr/bin/perl -w
use strict;
die "perl $0 [Total_assembly_summary.txt][outdir][output]" unless @ARGV==3;
open(IF,$ARGV[0])||die;
my $dir=$ARGV[1];
mkdir $dir unless (-e $dir);
open(OUT,">$ARGV[2]")||die;
while(<IF>){
	chomp;
	if(/^\#/){
		next;
	}
	else{
		my @a=split /\t/;
		my $n=scalar @a;
		if($n == 20){
			my @b=split /\//,$a[-1];
			my $file="$a[-1]/$b[-1]\_genomic.fna.gz";
			print OUT "wget -c $file -P $dir/\n";
		}
		else{
			my @b=split /\//,$a[-2];
			my $file="$a[-2]/$b[-1]\_genomic.fna.gz";
			print OUT "wget -c $file -P $dir\n";
		}
	}
}
close IF;
close OUT;
