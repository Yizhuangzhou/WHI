# WHI
A genome-based method embracing evolutionary distance and ecology to delineate prokaryotic species

# Please Cite
If you use WHI in your publication, please cite:

# Support
If you are having issues, please email me via zhouyizhuang3@163.com

# Protocol
## 1. Genome collection
### 1.1 Download assembly_summary.txt
For archea genomes:  
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/genbank/archea/assembly_summary.txt  
mv assembly_summary.txt Archea_assembly_summary.txt  

For eubacteria genomes:  
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/genbank/bacteria/assembly_summary.txt  
mv assembly_summary.txt Bacteria_assembly_summary.txt

Merging two files:  
cat Archea_assembly_summary.txt Bacteria_assembly_summary.txt >assembly_summary.txt

### 1.2. Generate script for downloading genomes
perl bin/01.GenerateShell_4wget.pl assembly_summary.txt Genome wget.sh

Genome: the output directory to save downloaded genomes  
wget.sh: the generated script to download genomes

### 1.3. Download genomes
sh wget.sh

Decompress files:
perl bin/02.GenerateShell_4Gzip.pl Genome gzip.sh  
gzip.sh: the generated scripts to decompress files  
sh gzip.sh

### 1.4 Generate genome list 
perl bin/03.Generate_GenomeList.pl assembly_summary.txt Genome Total_Genome.list Total_Genome.log  
Total_Genome.list: the output file containing genome information,including 5 columns: assembly_accession,species_taxid,organism_name,assembly_level,and File_Path  
Total_Genome.log: the output file containing organisms without fasta files

### 1.4. Separate Chromosomes and Plasmids

