# Aurora

## 1. Data:  
The data transferred can be found under:
`/pghbio/aurora/data/received`

We have received four different analysis so far:  
a. Biospecimen *(55 xml files)*  
b. RNA-Seq *(**rna/**: 150 fastqs, 75 BAMs, 75 quant.sf and **rna2/**: 324 fastqs, 162 BAMs)*  
c. Methylation *(Level1: 396 idats, Level2: 198 tsv, Level3: 198 tsv, Level4: 1 tsv)*  
d. Variant calling  

They can be seen in the following folders:
```
achakka: received$ pwd
/pghbio/aurora/data/received
achakka: received$ ls -lh
total 220K
drwxrwxr-x+ 4 ropelews mc5fp7p  12K Oct 29 09:00 biospecimen
drwxrwxr-x+ 2 ropelews mc5fp7p  18K Aug 24 02:32 genome
drwxrwxr-x+ 3 ropelews mc5fp7p  12K Oct 18 10:44 meth
drwxrwxr-x+ 3 ropelews mc5fp7p  50K Dec 11 21:35 rna
drwxr-xr-x+ 2 ropelews mc5fp7p 130K Jan 25 20:19 rna2
```

A more details description of the files is given below.
### 1.a. Biospecimen
The biospecimen folder contains all the xml details of the patient samples. The xml files have been organized in two folder and in total we have *55 xml* files.

The files are located in the following directories:
```
achakka: biospecimen$ pwd
/pghbio/aurora/data/received/biospecimen
achakka: biospecimen$ ls -lh
total 6.2M
drwxrwxr-x+ 2 jmw004 mc5fp7p  12K Jul 19  2018 nationwidechildrens.org_BRCA.bio.Level_1.517.0.AUR
-rw-rwx---+ 1 jmw004 mc5fp7p 1.3M Oct 29 08:56 nationwidechildrens.org_BRCA.bio.Level_1.517.0.AUR.tar
drwxrwxr-x+ 2 jmw004 mc5fp7p  14K Jul 19  2018 nationwidechildrens.org_BRCA.bio.Level_1.620.0.AUR
-rw-rwx---+ 1 jmw004 mc5fp7p 3.9M Oct 29 08:57 nationwidechildrens.org_BRCA.bio.Level_1.620.0.AUR.tar
achakka: biospecimen$ ls *
nationwidechildrens.org_BRCA.bio.Level_1.517.0.AUR.tar  nationwidechildrens.org_BRCA.bio.Level_1.620.0.AUR.tar

nationwidechildrens.org_BRCA.bio.Level_1.517.0.AUR:
nationwidechildrens.org_biospecimen.AUR-AD9E.xml  nationwidechildrens.org_biospecimen.AUR-AD9G.xml  nationwidechildrens.org_biospecimen.AUR-AD9I.xml  README.txt
nationwidechildrens.org_biospecimen.AUR-AD9F.xml  nationwidechildrens.org_biospecimen.AUR-AD9H.xml  nationwidechildrens.org_biospecimen.AUR-AD9J.xml  SUBMISSION.json

nationwidechildrens.org_BRCA.bio.Level_1.620.0.AUR:
nationwidechildrens.org_biospecimen.AUR-ADCB.xml  nationwidechildrens.org_biospecimen.AUR-AF98.xml  nationwidechildrens.org_biospecimen.AUR-AFSL.xml
nationwidechildrens.org_biospecimen.AUR-AE5G.xml  nationwidechildrens.org_biospecimen.AUR-AF99.xml  nationwidechildrens.org_biospecimen.AUR-AFSO.xml
nationwidechildrens.org_biospecimen.AUR-AE5H.xml  nationwidechildrens.org_biospecimen.AUR-AF9A.xml  nationwidechildrens.org_biospecimen.AUR-AFSP.xml
nationwidechildrens.org_biospecimen.AUR-AE6X.xml  nationwidechildrens.org_biospecimen.AUR-AFE4.xml  nationwidechildrens.org_biospecimen.AUR-AFUG.xml
nationwidechildrens.org_biospecimen.AUR-AE6Y.xml  nationwidechildrens.org_biospecimen.AUR-AFE5.xml  nationwidechildrens.org_biospecimen.AUR-AFUI.xml
nationwidechildrens.org_biospecimen.AUR-AEPZ.xml  nationwidechildrens.org_biospecimen.AUR-AFE6.xml  nationwidechildrens.org_biospecimen.AUR-AFUK.xml
nationwidechildrens.org_biospecimen.AUR-AER2.xml  nationwidechildrens.org_biospecimen.AUR-AFE7.xml  nationwidechildrens.org_biospecimen.AUR-AFUL.xml
nationwidechildrens.org_biospecimen.AUR-AER4.xml  nationwidechildrens.org_biospecimen.AUR-AFE9.xml  nationwidechildrens.org_biospecimen.AUR-AFUM.xml
nationwidechildrens.org_biospecimen.AUR-AER5.xml  nationwidechildrens.org_biospecimen.AUR-AFEA.xml  nationwidechildrens.org_biospecimen.AUR-AFUN.xml
nationwidechildrens.org_biospecimen.AUR-AER6.xml  nationwidechildrens.org_biospecimen.AUR-AFEC.xml  nationwidechildrens.org_biospecimen.AUR-AFUO.xml
nationwidechildrens.org_biospecimen.AUR-AER7.xml  nationwidechildrens.org_biospecimen.AUR-AFKB.xml  nationwidechildrens.org_biospecimen.AUR-AFUP.xml
nationwidechildrens.org_biospecimen.AUR-AER8.xml  nationwidechildrens.org_biospecimen.AUR-AFKD.xml  nationwidechildrens.org_biospecimen.AUR-AG0J.xml
nationwidechildrens.org_biospecimen.AUR-AERW.xml  nationwidechildrens.org_biospecimen.AUR-AFKF.xml  nationwidechildrens.org_biospecimen.AUR-AG0M.xml
nationwidechildrens.org_biospecimen.AUR-AERX.xml  nationwidechildrens.org_biospecimen.AUR-AFR2.xml  nationwidechildrens.org_biospecimen.AUR-AG0N.xml
nationwidechildrens.org_biospecimen.AUR-AERY.xml  nationwidechildrens.org_biospecimen.AUR-AFR3.xml  nationwidechildrens.org_biospecimen.AUR-AG12.xml
nationwidechildrens.org_biospecimen.AUR-AF94.xml  nationwidechildrens.org_biospecimen.AUR-AFR4.xml  README.txt
nationwidechildrens.org_biospecimen.AUR-AF95.xml  nationwidechildrens.org_biospecimen.AUR-AFR5.xml  SUBMISSION.json
achakka: biospecimen$ ls */*.xml | wc -l
55

```
### 1.b. RNA-Seq
The RNA-Seq files were submitted in two different folders: `rna/` and `rna2/`.

Under `rna/`, we can find the following files:
```
achakka: rna$ pwd
/pghbio/aurora/data/received/rna
achakka: rna$ ls *.bam | wc -l
75
achakka: rna$ ls *.quant.sf | wc -l
75
achakka: rna$ cd fastq/
achakka: fastq$ pwd
/pghbio/aurora/data/received/rna/fastq
achakka: fastq$ ls *.fastq.gz | wc -l
150
```
Under `rna2/`, we can find the following folders:
```
achakka: rna2$ pwd
/pghbio/aurora/data/received/rna2
achakka: rna2$ ls *.bam | wc -l
162
achakka: rna2$ ls *.fastq.gz | wc -l
324
```

RNA-Seq workflow was provided by UNC as following:
```
refdir=/datastore/nextgenout4/share/labs/bioinformatics/seqware/ref/hg38/
scriptdir=/datastore/scripts
outdir=/home/testSample
picarddir=/datastore/software/picard-tools-1.86
fq1=/home/test_r1.fastq.gz
fq2=/home/test_r2.fastq.gz

#STAR:
STAR --genomeDir $refdir/star_hg38_d1 --readFilesCommand zcat --readFilesIn $fq1 $fq2 --outSAMunmapped Within --outSAMtype BAM Unsorted --quantMode TranscriptomeSAM --runThreadN 16 --outFileNamePrefix $outdir/STAR_ #docker cpus:16 mem:4

#sort bam file
samtools sort -o $outdir/STAR_Aligned.out.sort.bam $outdir/STAR_Aligned.out.bam #docker mem:8

#index bam file
samtools index $outdir/STAR_Aligned.out.sort.bam #docker mem:4

#Salmon:
salmon quant -t $refdir/transcripts_hg38/gencode.v22.pc_transcripts.fa -l IU -a $outdir/STAR_Aligned.toTranscriptome.out.bam -o $outdir/Salmon_out # docker mem:8

#Picard rna-seq QC
java  -Xms4G -Xmx4G -XX:ParallelGCThreads=1 -jar $picarddir/CollectRnaSeqMetrics.jar REF_FLAT=$refdir/refFlat_hg38.txt RIBOSOMAL_INTERVALS=$refdir/hg38d1_rmsk_rrna.txt STRAND_SPECIFICITY=NONE CHART_OUTPUT=$outdir/RNAqc.pdf METRIC_ACCUMULATION_LEVEL=ALL_READS INPUT=$outdir/STAR_Aligned.out.sort.bam OUTPUT=$outdir/RNAqc.txt VALIDATION_STRINGENCY=SILENT # docker mem:8

#Summarize isoform and gene level
echo -e "\t$outdir/Salmon_out/quant.sf" > $outdir/Salmon_out/salmon_isoform.txt
sed -i 's|t/datastore|\t/datastore|g' $outdir/Salmon_out/salmon_isoform.txt
cut -f 1,5 $outdir/Salmon_out/quant.sf >> $outdir/Salmon_out/salmon_isoform.txt

java -Xmx4G -cp $scriptdir salmonIsoformToGene $outdir/Salmon_out/salmon_isoform.txt $refdir/transcripts_hg38/gencode.v22.annotation.gtf > $outdir/Salmon_out/salmon_gene.txt # docker mem:8

Rscript $scriptdir/normalizeGenes.R $outdir/Salmon_out/salmon_gene.txt $outdir/Salmon_out/salmon_gene_normalized.txt #docker mem:4

rm -rfv $outdir/working/* # cleanup
rm $outdir/STAR_Aligned.toTranscriptome.out.bam && rm $outdir/STAR_Aligned.out.bam # cleanup
```

### 1.c. Methylation

### 1.d. Variant calling

## 2. cBio
