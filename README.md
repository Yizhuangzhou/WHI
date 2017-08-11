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
cat Archea_assembly_summary.txt Bacteria_assembly_summary.txt >Total_assembly_summary.txt

### 1.2. Generate script for downloading genomes
perl bin/01.GenerateShell_4wget.pl Total_assembly_summary.txt Genome wget.sh

Genome: the output directory to save downloaded genomes  
wget.sh: the generated script to download genomes

### 1.3. Download genomes
sh wget.sh

Decompress files:
perl bin/02.GenerateShell_4Gzip.pl Genome gzip.sh  
gzip.sh: the generated scripts to decompress files  
sh gzip.sh

### 1.4 Generate genome list 
To generate a table containing assembly_accession,species_taxid,organism_name,assembly_level,and Path for fasta file  
perl bin/03.Generate_GenomeList.pl Total_assembly_summary.txt Genome Total_Genome.list Total_Genome.log  
Total_Genome.list: the output file containing genome information  
Total_Genome.log: the output file containing organisms without fasta files

### 1.5. Separate Chromosomes and Plasmids
To separate chromosomes and plasmids, and then calculate the genome sizes for chromosomes  
perl bin/04.Separate_Chrom_Plasmid.pl Total_Genome.list Plasmids.ids Total_Chrom_Plasmid.list Chromosome_Plasmid
Plasmids.ids: downloaded from NCBI(wget ftp://ftp.ncbi.nlm.nih.gov/genomes/archive/old_refseq/Plasmids/Plasmids.ids)  
Total_Chrom_Plasmid.list: the output file, containing assembly_accession,species_taxid,organism_name,assembly_level, file_path for chromsomes, and file_path for plasmids  
Chromosome_Plasmid: the output directory containing separated chromsome and plasmid sequences  

### 1.6 Add strain information
perl bin/05.Add_Strain.pl Total_assembly_summary.txt Total_Chrom_Plasmid.list Total_Chrom_Plasmid_Strain.xls  
Total_Chrom_Plasmid_Strain.xls: the output file  

## 2. Species with validated names and type strains
  Species with validated names were collected from the List of Prokaryotic names with Standing in Nomenclature (LPSN) database (http://www.bacterio.net/), which are included in Data/Validated_SpeciesName.xls.  
  Type strains were recognized using the Straininfo bioportal (http://www.straininfo.net/) and LPSN. Collected type strains are included in Data/Type_strain.xls.

## 3. Genome selection

