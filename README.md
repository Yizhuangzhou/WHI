# WHI
A genome-based method embracing evolutionary distance and ecology to delineate prokaryotic species

# Genome collection and selection
## 1. Download assembly_summary.txt
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/genbank/archea/assembly_summary.txt (for archea genomes)

wget ftp://ftp.ncbi.nlm.nih.gov/genomes/genbank/bacteria/assembly_summary.txt (for eubacteria genomes)

Then pool these two files together which named assembly_summary.txt

## 2. Generate script for downloading genomes
perl Scripts/01.FormShell_4wget.pl assembly_summary.txt [outdir] wget.sh

[outdir] the output directory to save downloaded genomes

## 3. Download genomes
sh wget.sh

## 4. 
