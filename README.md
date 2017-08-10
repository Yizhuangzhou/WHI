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

Pooling two files together:
cat Archea_assembly_summary.txt Bacteria_assembly_summary.txt >assembly_summary.txt

### 1.2. Generate script for downloading genomes
perl Scripts/01.FormShell_4wget.pl assembly_summary.txt [outdir] wget.sh

[outdir] the output directory to save downloaded genomes

### 1.3. Download genomes
sh wget.sh

### 1.4. 
