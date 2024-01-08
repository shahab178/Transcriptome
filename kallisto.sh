#!/bin/bash
#Indexes with kallisto (kmer = 31)
cd xx
/.../kallisto_linux-vx.xx.x/kallisto index --index=transcripts_kallisto_index Homo_sapiens.GRCh38.cdna.all.fa 

#Generate abundance estimates for all samples using Kallisto
/.../kallisto_linux-vx.xx.x/kallisto quant -b 100 -i /.../transcripts_kallisto_index --output-dir=sample_name --threads=8  seq_PE_1.fq seq_PE_2.fq

#Create a list of all transcript IDs for later use
cat GRCh38_latest_rna.fna | grep ">" | perl -ne '$_ =~ s/\>//; print $_' | sort | uniq > transcript_id_list.txt

#Create a single TSV file that has the TPM abundance estimates for all samples or use tximport to work in R
paste */abundance.tsv | cut -f 1,2,5,10,15,20,25,30 > transcript_tpms_all_samples.tsv
ls -1 */abundance.tsv | perl -ne 'chomp $_; if ($_ =~ /(\S+)\/abundance\.tsv/){print "\t$1"}' | perl -ne 'print "target_id\tlength$_\n"' > header.tsv
cat header.tsv transcript_tpms_all_samples.tsv | grep -v "tpm" > transcript_tpms_all_samples.tsv2
mv transcript_tpms_all_samples.tsv2 transcript_tpms_all_samples.tsv
rm -f header.tsv 



