#!usr/bin/perl -w
use strict;
die "perl $0 [Delta.list][Genome_Size.xls][output]" unless @ARGV == 3;
open(LIST,$ARGV[0])||die;
open(IF,$ARGV[1])||die;
open(OUT,">$ARGV[2]")||die;
my ($id1,$id2,$WHI);
my %size;
while(<IF>){
	chomp;
	my @a=split /\t/;
	$size{$a[0]}=$a[1];
}
close IF;
print OUT "Ref\tQuery\tRef_Size\tQuery_Size\tANI\tPSG1\tWHI1\tPSG3\tWHI3\tPSG2\tWHI2\n";
while(<LIST>){
	chomp;
	my $file=$_;
	if($file=~/(GCA_[\d\.]+)\_(GCA_[\d\.]+)\.delta/){
		$id1=$1;
		$id2=$2;
	}
	open(IF,$file);
	<IF>;
	<IF>;
	my $sumlen=0;
	my $idelen=0;
	my $len=0;
	my $deletionNum=0;
	my $errorNum=0;
	my ($scaf1,$scaf2);
	my %len1=();
	my %len2=();
	my %hash=();
	my %flag=();
	while(<IF>){
		chomp;
		if(/>/){
			my @a=split /\s+/;
			$scaf1=$a[0];
			$scaf2=$a[1];
		}
		else{
			my @a=split /\s+/;
			if(@a == 7){
				$len=$a[1]-$a[0]+1;
				$errorNum = $a[4];
				$deletionNum =0;
				if($len >= 500){
					foreach($a[0] .. $a[1]){
						$hash{$scaf1}{$_}++;
					}
					my $min=$a[2];
					my $max=$a[3];
					if($a[3] < $a[2]){
						$min=$a[3];
						$max=$a[2];
					}
					foreach ($min .. $max){
						$flag{$scaf2}{$_}++;
					}
				}
			}
			elsif($a[0] < 0){
				$deletionNum ++;
			}
			elsif($a[0] == 0){
				if($len >= 500){
					$sumlen += $len+$deletionNum;
					$idelen +=($len+$deletionNum-$errorNum);
				}
			}
		}
	}
	close IF;
	if($sumlen == 0){
		print OUT "$id1\t$id2\t$size{$id1}\t$size{$id2}\t0\t0\t0\n";
	}
	else{
		my $p=$idelen/$sumlen;
		my $totallen1=$size{$id1};
		my $totallen2=$size{$id2};
		my $len1=0;
		my $len2=0;
		foreach my $k1(keys %hash){
			my $n=scalar keys %{$hash{$k1}};
			$len1 +=$n;
		}
		foreach my $k1(keys %flag){
			my $n=scalar keys %{$flag{$k1}};
			$len2 +=$n;
		}
	
		my $PSG1=sprintf("%.2f",$len1*100/$totallen1);
		my $WHI1=sprintf("%.2f",$p*$len1*100/$totallen1);
		my $PSG2=sprintf("%.2f",$len2*100/$totallen2);
		my $WHI2=sprintf("%.2f",$p*$len2*100/$totallen2);
		my $PSG3=sprintf("%.2f",($len1+$len2)*100/($totallen1+$totallen2));
		my $WHI3=sprintf("%.2f",$p*($len1+$len2)*100/($totallen1+$totallen2));
		my $ANI=sprintf("%.2f",$idelen*100/$sumlen);
		if($PSG2 >$PSG1){
			print OUT "$id1\t$id2\t$size{$id1}\t$size{$id2}\t$ANI\t$PSG1\t$WHI1\t$PSG3\t$WHI3\t$PSG2\t$WHI2\n";
		}
		else{
			print OUT "$id1\t$id2\t$size{$id1}\t$size{$id2}\t$ANI\t$PSG2\t$WHI2\t$PSG3\t$WHI3\t$PSG1\t$WHI1\n";
		}
		#my $WHI=sprintf("%.2f",$p*$PSG);
	#	print OUT "$id1\t$id2\t$size{$id1}\t$size{$id2}\t$ANI\t$WHI\t$PSG\n";
	}
}
close LIST;
close OUT;
