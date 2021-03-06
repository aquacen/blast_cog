# blast_cog

## To configure:

1. Download Prot2003-2014 fasta (ftp://ftp.ncbi.nih.gov/pub/COG/COG2014/data/prot2003-2014.fa.gz) to a **COG_DB_directory**

2. Gunzip prot (gunzip prot2003-2014.fa.gz)

3. Create Blast DB: (makeblastdb -dbtype prot -out db2003-2014 -title db2003-2014 -max_file_sz 300000000 -in prot2003-2014.fa -parse_seqids)

4. Download cog2003-2014.csv (ftp://ftp.ncbi.nih.gov/pub/COG/COG2014/data/cog2003-2014.csv) in the COG_DB_directory

5. Download cognames2003-2014.tab (ftp://ftp.ncbi.nih.gov/pub/COG/COG2014/data/cognames2003-2014.tab) in COG_DB_directory

6. Download fun2003-20014.tab (ftp://ftp.ncbi.nih.gov/pub/COG/COG2014/data/fun2003-2014.tab) in COG_DB_directory

7. Git clone in a workspace dir: (git clone https://github.com/aquacen/blast_cog.git)


## To use:

1. Enter in the workspace dir (cd $HOME/blast_cog)

2. Run cog shell script with parameters:

./cog FASTA_WITH_AMINOACIDS COG_DB_directory

    Example:
    ./cog fno.faa ../cogdb


## Pre-requeriments:

1. NCBI-Blast+ Stand alone (makeblastdb and blastp): ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/

2. Perl: https://www.perl.org/

3. GNU Parallel - The Command-Line Power Tool
   O. Tange (2011): GNU Parallel - The Command-Line Power Tool, login: The USENIX Magazine, February 2011:42-47.


## Advanced settings

1. To increase number of threads in BlastP update cog shell script THREADS variable

2. To remove parallel dependence see comments on cog shell script