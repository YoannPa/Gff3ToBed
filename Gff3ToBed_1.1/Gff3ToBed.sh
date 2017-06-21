#!/bin/bash

#Gff3ToBed Extractor
#This script is free of rights.
#Author : PAGEAUD Yoann - yoann.pageaud@gmail.com
#Runs under Linux - Ubuntu 16.04

#For a specific feature and a specific biotype
if [ "$1" != "" ] && [ "$2" == "gff3" ] && [ "$3" != "all" ] && [ "$4" != "all" ] && [ "$5" == "ens" ]; then
	cat "$1" \
	| awk '{if($0 ~/^chr/ && $3 ~ /'"$3"'/ && $9 ~ /gene_type='"$4"'/) \
	{printf ("%s\t%d\t%d\t%s\t%s\t%c",$1,($4 - 1),$5,$2,$3,$7); \
	split($9,a,";"); \
	for (i=0;i<=10;i++) \
	{if(a[i] ~/^ID/){split(a[i],b,"="); \
	if(b[2] ~/^[A-Za-z_]+:/){split(b[2],c,":"); \
	printf("\t%s",c[2]);}else{printf("\t%s",b[2]);}}}; \
	print "\r";}}' \
	| sort -k1,1 -Vs -k2,2n > "$3"_"$4".bed;
	echo "$3"_"$4".bed;

elif [ "$1" != "" ] && [ "$2" == "gff3" ] && [ "$3" != "all" ] && [ "$4" != "all" ] && [ "$5" == "hgnc" ]; then
	cat "$1" \
	| awk '{if($0 ~/^chr/ && $3 ~ /'"$3"'/ && $9 ~ /gene_type='"$4"'/) \
	{printf ("%s\t%d\t%d\t%s\t%s\t%c",$1,($4 - 1),$5,$2,$3,$7); \
	split($9,a,";"); \
	for (i=0;i<=10;i++) \
	{if(a[i] ~/^gene_name/){split(a[i],b,"="); \
	printf("\t%s",b[2]);}}; \
	print "\r"}}' \
	| sort -k1,1 -Vs -k2,2n > "$3"_"$4".bed;
	echo "$3"_"$4".bed;

elif [ "$1" != "" ] && [ "$2" == "gff3" ] && [ "$3" != "all" ] && [ "$4" != "all" ] && [ "$5" == "both" ]; then
	cat "$1" \
	| awk '{if($0 ~/^chr/ && $3 ~ /'"$3"'/ && $9 ~ /gene_type='"$4"'/) \
	{printf ("%s\t%d\t%d\t%s\t%s\t%c",$1,($4 - 1),$5,$2,$3,$7); \
	split($9,a,";"); \
	for (i=0;i<=10;i++) \
	{if(a[i] ~/^gene_name/ || a[i] ~/^ID/){split(a[i],b,"="); \
	if(b[2] ~/^[A-Za-z_]+:/){split(b[2],c,":"); \
	printf("\t%s",c[2]);}else{printf("\t%s",b[2]);}}}; \
	print "\r"}}' \
	| sort -k1,1 -Vs -k2,2n > "$3"_"$4".bed;
	echo "$3"_"$4".bed;

elif [ "$1" != "" ] && [ "$2" == "gz" ] && [ "$3" != "all" ] && [ "$4" != "all" ] && [ "$5" == "ens" ]; then
	zcat "$1" \
	| awk '{if($0 ~/^chr/ && $3 ~ /'"$3"'/ && $9 ~ /gene_type='"$4"'/) \
	{printf ("%s\t%d\t%d\t%s\t%s\t%c",$1,($4 - 1),$5,$2,$3,$7); \
	split($9,a,";"); \
	for (i=0;i<=10;i++) \
	{if(a[i] ~/^ID/){split(a[i],b,"="); \
	if(b[2] ~/^[A-Za-z_]+:/){split(b[2],c,":"); \
	printf("\t%s",c[2]);}else{printf("\t%s",b[2]);}}}; \
	print "\r";}}' \
	| sort -k1,1 -Vs -k2,2n \
	| gzip > "$3"_"$4".bed."$2";
	echo "$3"_"$4".bed."$2";

elif [ "$1" != "" ] && [ "$2" == "gz" ] && [ "$3" != "all" ] && [ "$4" != "all" ] && [ "$5" == "hgnc" ]; then
	zcat "$1" \
	| awk '{if($0 ~/^chr/ && $3 ~ /'"$3"'/ && $9 ~ /gene_type='"$4"'/) \
	{printf ("%s\t%d\t%d\t%s\t%s\t%c",$1,($4 - 1),$5,$2,$3,$7); \
	split($9,a,";"); \
	for (i=0;i<=10;i++) \
	{if(a[i] ~/^gene_name/){split(a[i],b,"="); \
	printf("\t%s",b[2]);}}; \
	print "\r"}}' \
	| sort -k1,1 -Vs -k2,2n \
	| gzip > "$3"_"$4".bed."$2";
	echo "$3"_"$4".bed."$2";

elif [ "$1" != "" ] && [ "$2" == "gz" ] && [ "$3" != "all" ] && [ "$4" != "all" ] && [ "$5" == "both" ]; then
	zcat "$1" \
	| awk '{if($0 ~/^chr/ && $3 ~ /'"$3"'/ && $9 ~ /gene_type='"$4"'/) \
	{printf ("%s\t%d\t%d\t%s\t%s\t%c",$1,($4 - 1),$5,$2,$3,$7); \
	split($9,a,";"); \
	for (i=0;i<=10;i++) \
	{if(a[i] ~/^gene_name/ || a[i] ~/^ID/){split(a[i],b,"="); \
	if(b[2] ~/^[A-Za-z_]+:/){split(b[2],c,":"); \
	printf("\t%s",c[2]);}else{printf("\t%s",b[2]);}}}; \
	print "\r"}}' \
	| sort -k1,1 -Vs -k2,2n \
	| gzip > "$3"_"$4".bed."$2";
	echo "$3"_"$4".bed."$2";

#For a specific feature and all biotypes
elif [ "$1" != "" ] && [ "$2" == "gff3" ] && [ "$3" != "all" ] && [ "$4" == "all" ] && [ "$5" == "ens" ]; then
	cat "$1" \
	| awk '{if($0 ~/^chr/ && $3 ~ /'"$3"'/) \
	{printf ("%s\t%d\t%d\t%s\t%s\t%c",$1,($4 - 1),$5,$2,$3,$7); \
	split($9,a,";"); \
	for (i=0;i<=10;i++) \
	{if(a[i] ~/^ID/){split(a[i],b,"="); \
	if(b[2] ~/^[A-Za-z_]+:/){split(b[2],c,":"); \
	printf("\t%s",c[2]);}else{printf("\t%s",b[2]);}}}; \
	print "\r";}}' \
	| sort -k1,1 -Vs -k2,2n > "$3"_"$4".bed;
	echo "$3"_"$4".bed;

elif [ "$1" != "" ] && [ "$2" == "gff3" ] && [ "$3" != "all" ] && [ "$4" == "all" ] && [ "$5" == "hgnc" ]; then
	cat "$1" \
	| awk '{if($0 ~/^chr/ && $3 ~ /'"$3"'/) \
	{printf ("%s\t%d\t%d\t%s\t%s\t%c",$1,($4 - 1),$5,$2,$3,$7); \
	split($9,a,";"); \
	for (i=0;i<=10;i++) \
	{if(a[i] ~/^gene_name/){split(a[i],b,"="); \
	printf("\t%s",b[2]);}}; \
	print "\r"}}' \
	| sort -k1,1 -Vs -k2,2n > "$3"_"$4".bed;
	echo "$3"_"$4".bed;

elif [ "$1" != "" ] && [ "$2" == "gff3" ] && [ "$3" != "all" ] && [ "$4" == "all" ] && [ "$5" == "both" ]; then
	cat "$1" \
	| awk '{if($0 ~/^chr/ && $3 ~ /'"$3"'/) \
	{printf ("%s\t%d\t%d\t%s\t%s\t%c",$1,($4 - 1),$5,$2,$3,$7); \
	split($9,a,";"); \
	for (i=0;i<=10;i++) \
	{if(a[i] ~/^gene_name/ || a[i] ~/^ID/){split(a[i],b,"="); \
	if(b[2] ~/^[A-Za-z_]+:/){split(b[2],c,":"); \
	printf("\t%s",c[2]);}else{printf("\t%s",b[2]);}}}; \
	print "\r"}}' \
	| sort -k1,1 -Vs -k2,2n > "$3"_"$4".bed;
	echo "$3"_"$4".bed;

elif [ "$1" != "" ] && [ "$2" == "gz" ] && [ "$3" != "all" ] && [ "$4" == "all" ] && [ "$5" == "ens" ]; then
	zcat "$1" \
	| awk '{if($0 ~/^chr/ && $3 ~ /'"$3"'/) \
	{printf ("%s\t%d\t%d\t%s\t%s\t%c",$1,($4 - 1),$5,$2,$3,$7); \
	split($9,a,";"); \
	for (i=0;i<=10;i++) \
	{if(a[i] ~/^ID/){split(a[i],b,"="); \
	if(b[2] ~/^[A-Za-z_]+:/){split(b[2],c,":"); \
	printf("\t%s",c[2]);}else{printf("\t%s",b[2]);}}}; \
	print "\r";}}' \
	| sort -k1,1 -Vs -k2,2n \
	| gzip > "$3"_"$4".bed."$2";
	echo "$3"_"$4".bed."$2";

elif [ "$1" != "" ] && [ "$2" == "gz" ] && [ "$3" != "all" ] && [ "$4" == "all" ] && [ "$5" == "hgnc" ]; then
	zcat "$1" \
	| awk '{if($0 ~/^chr/ && $3 ~ /'"$3"'/) \
	{printf ("%s\t%d\t%d\t%s\t%s\t%c",$1,($4 - 1),$5,$2,$3,$7); \
	split($9,a,";"); \
	for (i=0;i<=10;i++) \
	{if(a[i] ~/^gene_name/){split(a[i],b,"="); \
	printf("\t%s",b[2]);}}; \
	print "\r"}}' \
	| sort -k1,1 -Vs -k2,2n \
	| gzip > "$3"_"$4".bed."$2";
	echo "$3"_"$4".bed."$2";

elif [ "$1" != "" ] && [ "$2" == "gz" ] && [ "$3" != "all" ] && [ "$4" == "all" ] && [ "$5" == "both" ]; then
	zcat "$1" \
	| awk '{if($0 ~/^chr/ && $3 ~ /'"$3"'/) \
	{printf ("%s\t%d\t%d\t%s\t%s\t%c",$1,($4 - 1),$5,$2,$3,$7); \
	split($9,a,";"); \
	for (i=0;i<=10;i++) \
	{if(a[i] ~/^gene_name/ || a[i] ~/^ID/){split(a[i],b,"="); \
	if(b[2] ~/^[A-Za-z_]+:/){split(b[2],c,":"); \
	printf("\t%s",c[2]);}else{printf("\t%s",b[2]);}}}; \
	print "\r"}}' \
	| sort -k1,1 -Vs -k2,2n \
	| gzip > "$3"_"$4".bed."$2";
	echo "$3"_"$4".bed."$2";

#For all features and a specific biotype
elif [ "$1" != "" ] && [ "$2" == "gff3" ] && [ "$3" == "all" ] && [ "$4" != "all" ] && [ "$5" == "ens" ]; then
	cat "$1" \
	| awk '{if($0 ~/^chr/ && $9 ~ /gene_type='"$4"'/) \
	{printf ("%s\t%d\t%d\t%s\t%s\t%c",$1,($4 - 1),$5,$2,$3,$7); \
	split($9,a,";"); \
	for (i=0;i<=10;i++) \
	{if(a[i] ~/^ID/){split(a[i],b,"="); \
	if(b[2] ~/^[A-Za-z_]+:/){split(b[2],c,":"); \
	printf("\t%s",c[2]);}else{printf("\t%s",b[2]);}}}; \
	print "\r";}}' \
	| sort -k1,1 -Vs -k2,2n > "$3"_"$4".bed;
	echo "$3"_"$4".bed;

elif [ "$1" != "" ] && [ "$2" == "gff3" ] && [ "$3" == "all" ] && [ "$4" != "all" ] && [ "$5" == "hgnc" ]; then
	cat "$1" \
	| awk '{if($0 ~/^chr/ && $9 ~ /gene_type='"$4"'/) \
	{printf ("%s\t%d\t%d\t%s\t%s\t%c",$1,($4 - 1),$5,$2,$3,$7); \
	split($9,a,";"); \
	for (i=0;i<=10;i++) \
	{if(a[i] ~/^gene_name/){split(a[i],b,"="); \
	printf("\t%s",b[2]);}}; \
	print "\r"}}' \
	| sort -k1,1 -Vs -k2,2n > "$3"_"$4".bed;
	echo "$3"_"$4".bed;

elif [ "$1" != "" ] && [ "$2" == "gff3" ] && [ "$3" == "all" ] && [ "$4" != "all" ] && [ "$5" == "both" ]; then
	cat "$1" \
	| awk '{if($0 ~/^chr/ && $9 ~ /gene_type='"$4"'/) \
	{printf ("%s\t%d\t%d\t%s\t%s\t%c",$1,($4 - 1),$5,$2,$3,$7); \
	split($9,a,";"); \
	for (i=0;i<=10;i++) \
	{if(a[i] ~/^gene_name/ || a[i] ~/^ID/){split(a[i],b,"="); \
	if(b[2] ~/^[A-Za-z_]+:/){split(b[2],c,":"); \
	printf("\t%s",c[2]);}else{printf("\t%s",b[2]);}}}; \
	print "\r"}}' \
	| sort -k1,1 -Vs -k2,2n > "$3"_"$4".bed;
	echo "$3"_"$4".bed;

elif [ "$1" != "" ] && [ "$2" == "gz" ] && [ "$3" == "all" ] && [ "$4" != "all" ] && [ "$5" == "ens" ]; then
	zcat "$1" \
	| awk '{if($0 ~/^chr/ && $9 ~ /gene_type='"$4"'/) \
	{printf ("%s\t%d\t%d\t%s\t%s\t%c",$1,($4 - 1),$5,$2,$3,$7); \
	split($9,a,";"); \
	for (i=0;i<=10;i++) \
	{if(a[i] ~/^ID/){split(a[i],b,"="); \
	if(b[2] ~/^[A-Za-z_]+:/){split(b[2],c,":"); \
	printf("\t%s",c[2]);}else{printf("\t%s",b[2]);}}}; \
	print "\r";}}' \
	| sort -k1,1 -Vs -k2,2n \
	| gzip > "$3"_"$4".bed."$2";
	echo "$3"_"$4".bed."$2";

elif [ "$1" != "" ] && [ "$2" == "gz" ] && [ "$3" == "all" ] && [ "$4" != "all" ] && [ "$5" == "hgnc" ]; then
	zcat "$1" \
	| awk '{if($0 ~/^chr/ && $9 ~ /gene_type='"$4"'/) \
	{printf ("%s\t%d\t%d\t%s\t%s\t%c",$1,($4 - 1),$5,$2,$3,$7); \
	split($9,a,";"); \
	for (i=0;i<=10;i++) \
	{if(a[i] ~/^gene_name/){split(a[i],b,"="); \
	printf("\t%s",b[2]);}}; \
	print "\r"}}' \
	| sort -k1,1 -Vs -k2,2n \
	| gzip > "$3"_"$4".bed."$2";
	echo "$3"_"$4".bed."$2";

elif [ "$1" != "" ] && [ "$2" == "gz" ] && [ "$3" == "all" ] && [ "$4" != "all" ] && [ "$5" == "both" ]; then
	zcat "$1" \
	| awk '{if($0 ~/^chr/ && $9 ~ /gene_type='"$4"'/) \
	{printf ("%s\t%d\t%d\t%s\t%s\t%c",$1,($4 - 1),$5,$2,$3,$7); \
	split($9,a,";"); \
	for (i=0;i<=10;i++) \
	{if(a[i] ~/^gene_name/ || a[i] ~/^ID/){split(a[i],b,"="); \
	if(b[2] ~/^[A-Za-z_]+:/){split(b[2],c,":"); \
	printf("\t%s",c[2]);}else{printf("\t%s",b[2]);}}}; \
	print "\r"}}' \
	| sort -k1,1 -Vs -k2,2n \
	| gzip > "$3"_"$4".bed."$2";
	echo "$3"_"$4".bed."$2";

#For all features and all biotype
elif [ "$1" != "" ] && [ "$2" == "gff3" ] && [ "$3" == "all" ] && [ "$4" == "ens" ]; then
	cat "$1" \
	| awk '{if($0 ~/^chr/) \
	{printf ("%s\t%d\t%d\t%s\t%s\t%c",$1,($4 - 1),$5,$2,$3,$7); \
	split($9,a,";"); \
	for (i=0;i<=10;i++) \
	{if(a[i] ~/^ID/){split(a[i],b,"="); \
	if(b[2] ~/^[A-Za-z_]+:/){split(b[2],c,":"); \
	printf("\t%s",c[2]);}else{printf("\t%s",b[2]);}}}; \
	print "\r";}}' \
	| sort -k1,1 -Vs -k2,2n > "$3".bed;
	echo "$3".bed;

elif [ "$1" != "" ] && [ "$2" == "gff3" ] && [ "$3" == "all" ] && [ "$4" == "hgnc" ]; then
	cat "$1" \
	| awk '{if($0 ~/^chr/) \
	{printf ("%s\t%d\t%d\t%s\t%s\t%c",$1,($4 - 1),$5,$2,$3,$7); \
	split($9,a,";"); \
	for (i=0;i<=10;i++) \
	{if(a[i] ~/^gene_name/){split(a[i],b,"="); \
	printf("\t%s",b[2]);}}; \
	print "\r"}}' \
	| sort -k1,1 -Vs -k2,2n > "$3".bed;
	echo "$3".bed;

elif [ "$1" != "" ] && [ "$2" == "gff3" ] && [ "$3" == "all" ] && [ "$4" == "both" ]; then
	cat "$1" \
	| awk '{if($0 ~/^chr/) \
	{printf ("%s\t%d\t%d\t%s\t%s\t%c",$1,($4 - 1),$5,$2,$3,$7); \
	split($9,a,";"); \
	for (i=0;i<=10;i++) \
	{if(a[i] ~/^gene_name/ || a[i] ~/^ID/){split(a[i],b,"="); \
	if(b[2] ~/^[A-Za-z_]+:/){split(b[2],c,":"); \
	printf("\t%s",c[2]);}else{printf("\t%s",b[2]);}}}; \
	print "\r"}}' \
	| sort -k1,1 -Vs -k2,2n > "$3".bed;
	echo "$3".bed;

elif [ "$1" != "" ] && [ "$2" == "gz" ] && [ "$3" == "all" ] && [ "$4" == "ens" ]; then
	zcat "$1" \
	| awk '{if($0 ~/^chr/) \
	{printf ("%s\t%d\t%d\t%s\t%s\t%c",$1,($4 - 1),$5,$2,$3,$7); \
	split($9,a,";"); \
	for (i=0;i<=10;i++) \
	{if(a[i] ~/^ID/){split(a[i],b,"="); \
	if(b[2] ~/^[A-Za-z_]+:/){split(b[2],c,":"); \
	printf("\t%s",c[2]);}else{printf("\t%s",b[2]);}}}; \
	print "\r";}}' \
	| sort -k1,1 -Vs -k2,2n \
	| gzip > "$3".bed."$2";
	echo "$3".bed."$2";

elif [ "$1" != "" ] && [ "$2" == "gz" ] && [ "$3" == "all" ] && [ "$4" == "hgnc" ]; then
	zcat "$1" \
	| awk '{if($0 ~/^chr/) \
	{printf ("%s\t%d\t%d\t%s\t%s\t%c",$1,($4 - 1),$5,$2,$3,$7); \
	split($9,a,";"); \
	for (i=0;i<=10;i++) \
	{if(a[i] ~/^gene_name/){split(a[i],b,"="); \
	printf("\t%s",b[2]);}}; \
	print "\r"}}' \
	| sort -k1,1 -Vs -k2,2n \
	| gzip > "$3".bed."$2";
	echo "$3".bed."$2";

elif [ "$1" != "" ] && [ "$2" == "gz" ] && [ "$3" == "all" ] && [ "$4" == "both" ]; then
	zcat "$1" \
	| awk '{if($0 ~/^chr/) \
	{printf ("%s\t%d\t%d\t%s\t%s\t%c",$1,($4 - 1),$5,$2,$3,$7); \
	split($9,a,";"); \
	for (i=0;i<=10;i++) \
	{if(a[i] ~/^gene_name/ || a[i] ~/^ID/){split(a[i],b,"="); \
	if(b[2] ~/^[A-Za-z_]+:/){split(b[2],c,":"); \
	printf("\t%s",c[2]);}else{printf("\t%s",b[2]);}}}; \
	print "\r"}}' \
	| sort -k1,1 -Vs -k2,2n \
	| gzip > "$3".bed."$2";
	echo "$3".bed."$2";

#Missing Arguments
elif [ "$1" != "" ] && [ "$2" != "" ] && [ "$3" == "" ] && [ "$4" == "" ] && [ "$5" == "" ]; then
	echo Error: Arguments are missing.

elif [ "$1" != "" ] && [ "$2" != "" ] && [ "$3" != "" ] && [ "$4" == "" ] && [ "$5" == "" ]; then
	echo Error: Arguments are missing.

elif [ "$1" == "" ] && [ "$2" == "" ] && [ "$3" == "" ] && [ "$4" == "" ] && [ "$5" == "" ]; then
	echo Error: No Arguments. To display help: ./Gff3ToBed.sh -h 

#Help
elif [ "$1" == "-h" ]; then
	echo Usage: ./Gff3ToBed.sh Input_File \
File_Format Gff3_Feature Gff3_Biotype ID
	echo
	echo This version converts 1-based Gff3 file to 0-based Bed file, \
extracts data following specified features and/or biotypes, and sorts them by \
increasing order.
	echo	
	echo List of supported formats: {gff3, gz}
	echo
	echo List of supported features: {gene, transcript, exon, CDS, UTR, \
start_codon, stop_codon, Selenocysteine}
	echo	
	echo List of supported biotypes: \
http://www.gencodegenes.org/gencode_biotypes.html
	echo	
	echo List of supported IDs: {ens, hgnc, both}
	echo	
	echo Command line examples:
	echo - Specific feature and specific biotype to Bed with Ensembl IDs:
	echo ./Gff3ToBed.sh gencode.v25.annotation.gff3.gz gz gene rRNA ens
	echo	
	echo - Specific feature and all biotypes to Bed with HGNC IDs:
	echo ./Gff3ToBed.sh gencode.v25.annotation.gff3.gz gz gene all hgnc
	echo	
	echo - All features and specific biotype to Bed with Ensembl and \
HGNC IDs:
	echo ./Gff3ToBed.sh gencode.v25.annotation.gff3.gz gz all rRNA both
	echo	
	echo - All features and all biotypes to Bed with Ensembl IDs:
	echo ./Gff3ToBed.sh gencode.v25.annotation.gff3.gz gz all ens
	echo	
	echo Report a bug: yoann.pageaud@gmail.com / \
y.pageaud@dkfz-heidelberg.de

fi
