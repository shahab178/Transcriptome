#!/bin/bash
#Indexes with kallisto (kmer = 31)
cd xx
/.../kallisto_linux-vx.xx.x/kallisto index --index=transcripts_kallisto_index Homo_sapiens.GRCh38.cdna.all.fa 

#Generate abundance estimates for all samples using Kallisto
/.../kallisto_linux-vx.xx.x/kallisto quant -b 100 -i /.../transcripts_kallisto_index --output-dir=sample_name --threads=8  seq_PE_1.fq seq_PE_2.fq

#Create a list of all transcript IDs for later use
cat GRCh38_latest_rna.fna | grep ">" | perl -ne '$_ =~ s/\>//; print $_' | sort | uniq > transcript_id_list.txt





