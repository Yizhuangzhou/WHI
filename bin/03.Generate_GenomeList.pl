#!usr/bin/perl -w
use strict;
use File::Basename;
use File::Find;

die "perl $0 [Total_assembly_summary.txt][indir][output][log]" unless @ARGV==4;
open(IF,$ARGV[0])||die;
my $indir=$ARGV[1];
open(OUT,">$ARGV[2]")||die;
open(LOG,">$ARGV[3]")||die;
my %hash;
find(\&wanted,$indir);
while(<IF>){
	chomp;
	if(/^\#/){
		next;
	}
	else{
		my @a=split /\t/;
		if($hash{$a[0]}){
			$a[8]=~s/strain\=type strain\:\s+//;
			$a[8]=~s/strain\=//;
			my $strain="";
			if($a[8] ne ""){
				$strain=$a[8];
			}
			else{
				$strain="NA";
			}
			print OUT "$a[0]\t$a[6]\t$a[7]\t$strain\t$a[11]\t$hash{$a[0]}\n";
		}
		else{
			print LOG "$a[0]\n";
		}
	}
}
close IF;
close OUT;
close LOG;

sub wanted{
	my $file;
	if($File::Find::name=~/\.fna/){
		my $file=$File::Find::name;
		my $base=basename($file,"\.fna");
		if($base=~/(GCA\_[\d\.]+)/){
			$hash{$1}=$file;
		}
	}
}

