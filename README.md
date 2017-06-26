# Gff3ToBed
## Convert and Extract Specific Genomic Data from a Gff3 file to a Bed file.

**Author: PAGEAUD Y. (1),(2)**

**1-** [**DKFZ, Germany.**](http://www.dkfz.de/)

**2-** [**Université Paris Diderot - Paris 7, France.**](http://www.univ-paris-diderot.fr/) 
 
**Version: 1.1**

**Compatibility: Linux (Ubuntu 16.04)**

**Last Update: 22/06/2017**

## Short description:
Gff3ToBed is a shell script using awk to extract and format specific genomic
 data contained in a Gff3 (1-based) file to a Bed (0-Based) file.  

## Prerequesites:
Gff3ToBed is using awk to parse gff3 files.
Awk should be installed by default with Ubuntu 16.04.  
If not, you can install it with from the Terminal:

```bash
sudo apt install original-awk
```

Alternatively, you can install **Synaptic** (which is the graphical version of
 GTK+ and APT) from the **Ubuntu Software Center** Application. it will allow
 you to install original-awk without using the **Terminal**.

Gff3ToBed has to be executable. to make a script executable type the following command in the Terminal:
```bash
sudo chmod +x Gff3ToBed
```

## How to use it ?
### How does it work ? 
Gff3ToBed is a shell script using awk to extract and format genomic data from a
 Gff3 (1-based) file to a Bed (0-Based) file.  
<br>
**Gff3 Format:**
```
chr1	HAVANA	gene	11869	14409	.	+	.	ID=ENSG00000223972.5;gene_id=ENSG00000223972.5;gene_type=transcribed_unprocessed_pseudogene;gene_name=DDX11L1;level=2;havana_gene=OTTHUMG00000000961.2
chr1	HAVANA	transcript	11869	14409	.	+	.	ID=ENST00000456328.2;Parent=ENSG00000223972.5;gene_id=ENSG00000223972.5;transcript_id=ENST00000456328.2;gene_type=transcribed_unprocessed_pseudogene;gene_name=DDX11L1;transcript_type=processed_transcript;transcript_name=DDX11L1-002;level=2;transcript_support_level=1;tag=basic;havana_gene=OTTHUMG00000000961.2;havana_transcript=OTTHUMT00000362751.1
chr1	HAVANA	exon	11869	12227	.	+	.	ID=exon:ENST00000456328.2:1;Parent=ENST00000456328.2;gene_id=ENSG00000223972.5;transcript_id=ENST00000456328.2;gene_type=transcribed_unprocessed_pseudogene;gene_name=DDX11L1;transcript_type=processed_transcript;transcript_name=DDX11L1-002;exon_number=1;exon_id=ENSE00002234944.1;level=2;transcript_support_level=1;tag=basic;havana_gene=OTTHUMG00000000961.2;havana_transcript=OTTHUMT00000362751.1
chr1	HAVANA	exon	12613	12721	.	+	.	ID=exon:ENST00000456328.2:2;Parent=ENST00000456328.2;gene_id=ENSG00000223972.5;transcript_id=ENST00000456328.2;gene_type=transcribed_unprocessed_pseudogene;gene_name=DDX11L1;transcript_type=processed_transcript;transcript_name=DDX11L1-002;exon_number=2;exon_id=ENSE00003582793.1;level=2;transcript_support_level=1;tag=basic;havana_gene=OTTHUMG00000000961.2;havana_transcript=OTTHUMT00000362751.1
chr1	HAVANA	exon	13221	14409	.	+	.	ID=exon:ENST00000456328.2:3;Parent=ENST00000456328.2;gene_id=ENSG00000223972.5;transcript_id=ENST00000456328.2;gene_type=transcribed_unprocessed_pseudogene;gene_name=DDX11L1;transcript_type=processed_transcript;transcript_name=DDX11L1-002;exon_number=3;exon_id=ENSE00002312635.1;level=2;transcript_support_level=1;tag=basic;havana_gene=OTTHUMG00000000961.2;havana_transcript=OTTHUMT00000362751.1
chr1	HAVANA	transcript	12010	13670	.	+	.	ID=ENST00000450305.2;Parent=ENSG00000223972.5;gene_id=ENSG00000223972.5;transcript_id=ENST00000450305.2;gene_type=transcribed_unprocessed_pseudogene;gene_name=DDX11L1;transcript_type=transcribed_unprocessed_pseudogene;transcript_name=DDX11L1-001;level=2;transcript_support_level=NA;ont=PGO:0000005,PGO:0000019;tag=basic;havana_gene=OTTHUMG00000000961.2;havana_transcript=OTTHUMT00000002844.2
chr1	HAVANA	exon	12010	12057	.	+	.	ID=exon:ENST00000450305.2:1;Parent=ENST00000450305.2;gene_id=ENSG00000223972.5;transcript_id=ENST00000450305.2;gene_type=transcribed_unprocessed_pseudogene;gene_name=DDX11L1;transcript_type=transcribed_unprocessed_pseudogene;transcript_name=DDX11L1-001;exon_number=1;exon_id=ENSE00001948541.1;level=2;transcript_support_level=NA;ont=PGO:0000005,PGO:0000019;tag=basic;havana_gene=OTTHUMG00000000961.2;havana_transcript=OTTHUMT00000002844.2
```

**Bed Format:**

```
chr1	11868	14409	HAVANA	gene	+	ENSG00000223972.5	DDX11L1
chr1	11868	14409	HAVANA	transcript	+	ENST00000456328.2	DDX11L1
chr1	11868	12227	HAVANA	exon	+	ENST00000456328.2	DDX11L1
chr1	12009	13670	HAVANA	transcript	+	ENST00000450305.2	DDX11L1
chr1	12009	12057	HAVANA	exon	+	ENST00000450305.2	DDX11L1
chr1	12612	12721	HAVANA	exon	+	ENST00000456328.2	DDX11L1
chr1	13220	14409	HAVANA	exon	+	ENST00000456328.2	DDX11L1
```
The output Bed file is created where the script is saved, and named following
 the parameters you selected for data extraction.  
Depending on the format of you input file (.gff3 or gff3.gz) the output file
 will be a .bed or a bed.gz file.  
<br>
### Basic Gff3 to Bed conversion
Like gff2bed (BEDOPS), Gff3ToBed can handle the basic conversion of a Gff3 file
 to a Bed file.  
<br>
**Example: Extract all data to a Bed file**
```
./Gff3ToBed.sh gencode.v26.annotation.gff3 gff3 all both

chr1	11868	14409	HAVANA	gene	+	ENSG00000223972.5	DDX11L1
chr1	11868	14409	HAVANA	transcript	+	ENST00000456328.2	DDX11L1
chr1	11868	12227	HAVANA	exon	+	ENST00000456328.2	DDX11L1
chr1	12009	13670	HAVANA	transcript	+	ENST00000450305.2	DDX11L1
chr1	12009	12057	HAVANA	exon	+	ENST00000450305.2	DDX11L1
chr1	12612	12721	HAVANA	exon	+	ENST00000456328.2	DDX11L1
chr1	13220	14409	HAVANA	exon	+	ENST00000456328.2	DDX11L1
```

### Feature and Biotype Specific Extraction

Contrary to gff2bed (BEDOPS), when converting your Gff3 to Bed you can specify
 features and biotypes matching the data you would like to extract.  
This option makes Gff3ToBed extremely fast for the file conversion, much faster
 than gff2bed.
 
**Example: Extract to Bed only genes giving rRNA**
```
./Gff3ToBed.sh gencode.v26.annotation.gff3 gff3 gene rRNA both

chr1	9437668	9437778	ENSEMBL	gene	-	ENSG00000252956.1	RNA5SP40
chr1	13623183	13623284	ENSEMBL	gene	-	ENSG00000222952.1	RNA5SP41
chr1	34112948	34113063	ENSEMBL	gene	+	ENSG00000201148.1	RNA5SP42
chr1	37264676	37264786	ENSEMBL	gene	-	ENSG00000252368.1	RNA5SP43
chr1	39154163	39154296	ENSEMBL	gene	-	ENSG00000222378.1	RNA5SP44
chr1	41466936	41467028	ENSEMBL	gene	-	ENSG00000252563.1	RNA5SP45
chr1	43196416	43196536	ENSEMBL	gene	+	ENSG00000199240.1	RNA5SP46
```

### Support .gff3 and .gff3.gz archive
To use Gff3ToBed you do not have to extract your .gff3.gz archive.  
It is especially convenient if your are working on large gff3 files.  
Gff3ToBed is also faster when working on gff3.gz archive.  
Consequently, the output file will be a bed.gz archive.  

**Example: Extract to Bed all data from a .gff3.gz archive to a bed.gz archive**
```
./Gff3ToBed.sh gencode.v26.annotation.gff3.gz gz all both

chr1	11868	14409	HAVANA	gene	+	ENSG00000223972.5	DDX11L1
chr1	11868	14409	HAVANA	transcript	+	ENST00000456328.2	DDX11L1
chr1	11868	12227	HAVANA	exon	+	ENST00000456328.2	DDX11L1
chr1	12009	13670	HAVANA	transcript	+	ENST00000450305.2	DDX11L1
chr1	12009	12057	HAVANA	exon	+	ENST00000450305.2	DDX11L1
chr1	12612	12721	HAVANA	exon	+	ENST00000456328.2	DDX11L1
chr1	13220	14409	HAVANA	exon	+	ENST00000456328.2	DDX11L1
```

### Select which IDs you want in your Bed file
Additionally, Gff3ToBed let you choose between HGNC (HUGO Gene Nomenclature Committee)
 and Ensembl IDs for your output Bed file.  
You can either get HGNC IDs, Ensembl IDs, or both IDs in your output Bed file.  

**Example: Get all genes with their Ensembl IDs in a Bed file**
```
./Gff3ToBed.sh gencode.v26.annotation.gff3 gff3 gene all ens

chr1	11868	14409	HAVANA	gene	+	ENSG00000223972.5
chr1	14403	29570	HAVANA	gene	-	ENSG00000227232.5
chr1	17368	17436	ENSEMBL	gene	-	ENSG00000278267.1
chr1	29553	31109	HAVANA	gene	+	ENSG00000243485.5
chr1	30365	30503	ENSEMBL	gene	+	ENSG00000284332.1
chr1	34553	36081	HAVANA	gene	-	ENSG00000237613.2
chr1	52472	53312	HAVANA	gene	+	ENSG00000268020.3

```

## Additionnal
To display the help  and more examples in the terminal:

```bash
./Gff3ToBed -h
```

## Copyrights: "Copyleft".
Source code is shared and can be used and modify freely by everyone wanting to improve it.  

## Report an error / Ask a question:
**E-mail:** [**yoann.pageaud@gmail.com**](yoann.pageaud@gmail.com) /
 [**y.pageaud@dkfz-heidelberg.de**](y.pageaud@dkfz-heidelberg.de)
