# WHI
A genome-based method embracing evolutionary distance and ecology to delineate prokaryotic species

# Please Cite
If you use WHI in your publication, please cite:

# Support
If you are having issues, please email me via zhouyizhuang3@163.com

## Test on DDH database
The extended DDH database: data/DDH_Database.xls  
Following the below procedures, you will obtains the results for DDH database: data/DDH_Results.xls  

### 1. Gain genome information 
perl bin/DDH_GenomeInfo.pl Total_Chrom_Plasmid.list Data/DDH_Database.xls DDH_GenomeInfo.xls
Total_Chrom_Plasmid.list: to get this file, you should follow the procedures for collecting NCBI genomes (step 1.1 to 1.5)  

### 2. Calculate Z-values for DDH genomes
perl bin/Zvalue.pl DDH_GenomeInfo.xls DDH_Zvalue.xls

### 3. Calculated TETRAs
perl bin/DDH_TETRA.pl DDH_Zvalue.xls DDH_Database.xls DDH_TETRA.xls

## 

# Test on NCBI genomes

# Procedures for collecting NCBI genomes
## 1. Genome collection
### 1.1 Download assembly_summary.txt
For archea genomes:  
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/genbank/archea/assembly_summary.txt  
mv assembly_summary.txt Archea_assembly_summary.txt    
Note: The data used in our paper is Data/Archea_assembly_summary.txt. You should use this data to repeat our study. Please note that if you download assembly_summary.txt by yourself, the results may be slightly different because of updated NCBI database.  

For eubacteria genomes:  
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/genbank/bacteria/assembly_summary.txt  
mv assembly_summary.txt Bacteria_assembly_summary.txt  
Note: The data used in our paper is Data/Archea_assembly_summary.txt. You should use this data to repeat our study. Please note that if you download assembly_summary.txt by yourself, the results may be slightly different because of updated NCBI database.  

Merging two files:  
cat Archea_assembly_summary.txt Bacteria_assembly_summary.txt >Total_assembly_summary.txt

### 1.2. Generate script for downloading genomes
perl bin/01.GenerateShell_4wget.pl Total_assembly_summary.txt Genome wget.sh 

### 1.3. Download and decompress genomes
sh wget.sh

Decompress files:  
perl bin/02.GenerateShell_4Gzip.pl Genome gzip.sh    
sh gzip.sh

### 1.4 Generate genome list 
To generate a table containing assembly_accession,species_taxid,organism_name,infraspecific_name, assembly_level,and file path:   
perl bin/03.Generate_GenomeList.pl Total_assembly_summary.txt Genome Total_Genome.list Total_Genome.log  

### 1.5. Separate Chromosomes and Plasmids
To separate chromosomes and plasmids, and then calculate the genome sizes for chromosomes:  
perl bin/04.Separate_Chrom_Plasmid.pl Total_Genome.list data/Plasmids.ids Total_Chrom_Plasmid.list Chromosome_Plasmid
Plasmids.ids: downloaded from NCBI(wget ftp://ftp.ncbi.nlm.nih.gov/genomes/archive/old_refseq/Plasmids/Plasmids.ids)  

## 2. Validated Species and type strains
  Species with validated names were collected from the List of Prokaryotic names with Standing in Nomenclature (LPSN) database (http://www.bacterio.net/), which are included in Data/Validated_SpeciesName.xls.  
  
  Type strains were recognized using the Straininfo bioportal (http://www.straininfo.net/) and LPSN. Collected type strains are included in Data/Type_strain.xls.

## 3. Genome selection  
### 3.1 Select genomes with validated species names
To discard genomes without validated species name and retain genomes belonging to validated species  
perl bin/05.ValidatedSpecies_GenomeInfo.pl Data/Validated_SpeciesName.xls Total_assembly_summary.txt ValidatedSpecies_GenomeInfo.xls  
ValidatedSpecies_GenomeInfo.xls: the output file to contain only genomes belonging to validated species

### 3.2 Add strain information  
To add strain information to each genomes with validated species names:  
perl bin/06.Add_StrainInfo.pl ValidatedSpecies_GenomeInfo.xls Validated_SpeciesName.xls Total_assembly_summary.txt ValidatedSpecies_GenomeInfo_Strain.xls  
ValidatedSpecies_GenomeInfo_Strain.xls: the output file

### 3.3 Select draft genomes with size >0.5 megabase-pairs (Mb)
To filter out low-coverage genomes (< 0.5 Mb):  
perl bin/07.ValidatedGenome_more500kb.pl ValidatedSpecies_GenomeInfo_Strain.xls ValidatedGenome_more500kb.xls  
ValidatedGenome_more500kb.xls: the output file

## 4. Reference and query genomes 
To select reference and query genomes:  
perl bin/08.Ref_Query_GenomeInfo.pl ValidatedGenome_more500kb.xls Data/Type_strain.xls Ref_GenomeInfo.xls Query_GenomeInfo.xls  
Ref_GenomeInfo.xls: the output file for selected references  
Query_GenomeInfo.xls: the output file for selected queries


