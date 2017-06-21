#!/bin/bash

#Gff3ToBed Extractor
#This script is free of rights.
#Author : PAGEAUD Yoann - yoann.pageaud@gmail.com
#Runs under Linux - Ubuntu 16.04

#For a specific feature and a specific biotype
if [ "$1" != "" ] && \
[ "$2" == "gff3" ] && \
[ "$3" != "all" ] && \
[ "$4" != "all" ]; then
	cat "$1" \
	| awk '{if($0 ~/^chr/ && $3 ~ /'"$3"'/ && $9 ~ /gene_type='"$4"'/) \
	{printf ("%s\t%d\t%d\t%s\t%s\t%c\t",$1,($4 - 1),$5,$2,$3,$7); \
	split($9,a,";"); \
	for (i=0;i<=10;i++) \
	{if(a[i] ~/^gene_name/){split(a[i],b,"="); \
	print b[2]}}}}' \
	| sort -k1,1 -k2,2n > "$3"_"$4".bed;
	echo "$3"_"$4".bed;

elif [ "$1" != "" ] && \
[ "$2" == "gz" ] && \
[ "$3" != "all" ] && \
[ "$4" != "all" ]; then
	zcat "$1" \
	| awk '{if($0 ~/^chr/ && $3 ~ /'"$3"'/ && $9 ~ /gene_type='"$4"'/) \
	{printf ("%s\t%d\t%d\t%s\t%s\t%c\t",$1,($4 - 1),$5,$2,$3,$7); \
	split($9,a,";"); \
	for (i=0;i<=10;i++) \
	{if(a[i] ~/^gene_name/){split(a[i],b,"="); \
	print b[2]}}}}' \
	| sort -k1,1 -k2,2n \
	| gzip > "$3"_"$4".bed."$2";
	echo "$3"_"$4".bed."$2";

#For a specific feature and all biotypes
elif [ "$1" != "" ] && \
[ "$2" == "gff3" ] && \
[ "$3" != "all" ] && \
[ "$4" == "all" ]; then
	cat "$1" \
	| awk '{if($0 ~/^chr/ && $3 ~ /'"$3"'/) \
	{printf ("%s\t%d\t%d\t%s\t%s\t%c\t",$1,($4 - 1),$5,$2,$3,$7); \
	split($9,a,";"); \
	for (i=0;i<=10;i++) \
	{if(a[i] ~/^gene_name/){split(a[i],b,"="); \
	print b[2]}}}}' \
	| sort -k1,1 -k2,2n > "$3"_"$4".bed;
	echo "$3"_"$4".bed;

elif [ "$1" != "" ] && \
[ "$2" == "gz" ] && \
[ "$3" != "all" ] && \
[ "$4" == "all" ]; then
	zcat "$1" \
	| awk '{if($0 ~/^chr/ && $3 ~ /'"$3"'/) \
	{printf ("%s\t%d\t%d\t%s\t%s\t%c\t",$1,($4 - 1),$5,$2,$3,$7); \
	split($9,a,";"); \
	for (i=0;i<=10;i++) \
	{if(a[i] ~/^gene_name/){split(a[i],b,"="); \
	print b[2]}}}}' \
	| sort -k1,1 -k2,2n \
	| gzip > "$3"_"$4".bed."$2";
	echo "$3"_"$4".bed."$2";

#For all features and a specific biotype (or all biotypes if $4 is empty)
elif [ "$1" != "" ] && \
[ "$2" == "gff3" ] && \
[ "$3" == "all" ] && \
[ "$4" != "all" ]; then
	cat "$1" \
	| awk '{if($0 ~/^chr/ && $9 ~ /gene_type='"$4"'/) \
	{printf ("%s\t%d\t%d\t%s\t%s\t%c\t",$1,($4 - 1),$5,$2,$3,$7); \
	split($9,a,";"); \
	for (i=0;i<=10;i++) \
	{if(a[i] ~/^gene_name/){split(a[i],b,"="); \
	print b[2]}}}}' \
	| sort -k1,1 -k2,2n > "$3"_"$4".bed;
	echo "$3"_"$4".bed;

elif [ "$1" != "" ] && \
[ "$2" == "gz" ] && \
[ "$3" == "all" ] && \
[ "$4" != "all" ]; then
	zcat "$1" \
	| awk '{if($0 ~/^chr/ && $9 ~ /gene_type='"$4"'/) \
	{printf ("%s\t%d\t%d\t%s\t%s\t%c\t",$1,($4 - 1),$5,$2,$3,$7); \
	split($9,a,";"); \
	for (i=0;i<=10;i++) \
	{if(a[i] ~/^gene_name/){split(a[i],b,"="); \
	print b[2]}}}}' \
	| sort -k1,1 -k2,2n \
	| gzip > "$3"_"$4".bed."$2";
	echo "$3"_"$4".bed."$2";

#Missing Arguments
elif [ "$1" != "" ] && [ "$2" != "" ] && [ "$3" == "" ] && [ "$4" == "" ]; then
	echo Error: 2 arguments are missing.

elif [ "$1" != "" ] && \
[ "$2" != "" ] && \
[ "$3" != "-a" ] && \
[ "$4" == "" ]; then
	echo Error: 1 argument is missing.

elif [ "$1" == "" ] && [ "$2" == "" ] && [ "$3" == "" ] && [ "$4" == "" ]; then
	echo Error: No Arguments. To display help: ./Gff3ToBed.sh -h 

#Help
elif [ "$1" == "-h" ]; then
	echo Usage: ./Gff3ToBed.sh Input_File \
File_Format Gff3_Feature Gff3_Biotype
	echo
	echo This version converts Gff3 1-based file to Bed 0-based file, \
extracts data following a specified feature and/or biotype, and sorts them by \
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
	echo Command line examples:
	echo - Specific feature and specific biotype to Bed:
	echo ./Gff3ToBed.sh gencode.v25.annotation.gff3.gz gz gene \
rRNA
	echo	
	echo - Specific feature and all biotypes to Bed:
	echo ./Gff3ToBed.sh gencode.v25.annotation.gff3.gz gz gene all
	echo	
	echo - All features and specific biotype to Bed:
	echo ./Gff3ToBed.sh gencode.v25.annotation.gff3.gz gz all rRNA
	echo	
	echo - All features and all biotypes to Bed:
	echo ./Gff3ToBed.sh gencode.v25.annotation.gff3.gz gz all
	echo	
	echo Report a bug: yoann.pageaud@gmail.com / \
y.pageaud@dkfz-heidelberg.de

fi
