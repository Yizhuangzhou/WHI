#!usr/bin/perl -w
use strict;
use File::Find;

die "perl $0 [indir][output]" unless @ARGV==2;
open(OUT,">$ARGV[1]")||die;
find(\&wanted,$ARGV[0]);

sub wanted{
	if($File::Find::name=~/\.fna\.gz/){
		print OUT "gzip -d $File::Find::name\n";
	}
}
close OUT;
