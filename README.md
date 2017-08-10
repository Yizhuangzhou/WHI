# WHI
A genome-based method embracing evolutionary distance and ecology to delineate prokaryotic species ＜/br＞

# Please Cite
<br>If you use WHI in your publication, please cite:＜/br＞

# Support
If you are having issues, please email me via zhouyizhuang3@163.com＜/br＞

# Protocol＜/br＞
## 1. Genome collection＜/br＞
### 1.1 Download assembly_summary.txt＜/br＞
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/genbank/archea/assembly_summary.txt (for archea genomes)＜/br＞
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/genbank/bacteria/assembly_summary.txt (for eubacteria genomes)＜/br＞

Then pool these two files together which named assembly_summary.txt＜/br＞

### 1.2. Generate script for downloading genomes
perl Scripts/01.FormShell_4wget.pl assembly_summary.txt [outdir] wget.sh

[outdir] the output directory to save downloaded genomes

### 1.3. Download genomes
sh wget.sh

### 1.4. 
